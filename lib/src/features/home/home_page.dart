import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uber_prestadores/src/features/approvals_history/approvals_history_page.dart';
import 'package:uber_prestadores/src/features/auth/auth_page.dart';
import 'package:uber_prestadores/src/features/search_user/search_user_page.dart';

import '../../shared/constants/app_images.dart';
import '../scheduled_rides/scheduled_rides_page.dart';
import 'submodules/adm/adm_subpage.dart';
import 'submodules/user/user_subpage.dart';

class HomePage extends StatefulWidget {
  final bool isAnAdministrator;
  const HomePage({Key? key, required this.isAnAdministrator}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: widget.isAnAdministrator ? const AdmSubpage() : const UserSubpage(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        widget.isAnAdministrator ? 'Moderação de usuários' : 'Home',
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
              onTap: () {
                //TODO: Implementar ação quando apertar no ícone de notificações.
              },
              child: SvgPicture.asset(AppImages.notification)),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(theme),
            const SizedBox(height: 80),
            if (widget.isAnAdministrator)
              _buildListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ApprovalsHistoryPage()));
                  },
                  icon: SvgPicture.asset(AppImages.simpleCheck),
                  theme: theme,
                  title: 'Histórico de aprovações',
                  subtitle: 'Veja as ultimas aprovações do sistema')
            else
              _buildListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScheduledRidesPage()));
                  },
                  icon: SvgPicture.asset(AppImages.simpleCheck),
                  theme: theme,
                  title: 'Corridas agendadas',
                  subtitle: 'Veja as corridas proximas'),
            if (widget.isAnAdministrator)
              _buildListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchUser()));
                  },
                  icon: SvgPicture.asset(AppImages.addPerson),
                  theme: theme,
                  title: 'Buscar usuários',
                  subtitle: 'Busque por usuário registrado')
            else
              _buildListTile(
                  onTap: () {
                    // Navigator.pop(context);
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ApprovalsHistoryPage())); */
                  },
                  icon: SvgPicture.asset(AppImages.addPerson),
                  theme: theme,
                  title: 'Corridas solicitadas',
                  subtitle: 'Veja as corridas solicitadas'),
            _buildListTile(
                icon: SvgPicture.asset(AppImages.questionCircled),
                theme: theme,
                title: 'Ajuda',
                subtitle: 'Precisando de ajuda?'),
            const Expanded(child: SizedBox()),
            TextButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const AuthPage())),
                child: Text('Sair de minha conta',
                    style: theme.textTheme.headline4!.copyWith(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        color: Colors.white))),
            const SizedBox(height: 24),
            TextButton(
                onPressed: () {},
                child: Text('Termos e condições da nossa empresa',
                    style: theme.textTheme.headline6!.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.white))),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        const SizedBox(width: 16),
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_sharp, color: Colors.white)),
        Expanded(
            child: Text(
          'Menu',
          textAlign: TextAlign.center,
          style: theme.textTheme.headline3!
              .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
        )),
        const SizedBox(width: 60),
      ],
    );
  }

  Widget _buildListTile(
      {required ThemeData theme,
      Widget? icon,
      required String title,
      required String subtitle,
      void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        shape: const Border(bottom: BorderSide(color: Colors.white)),
        leading: SizedBox(
          height: 40,
          width: 40,
          child: icon,
        ),
        title: Text(
          title,
          style: theme.textTheme.headline4!.copyWith(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.headline6!.copyWith(color: Colors.white),
        ),
        trailing: SvgPicture.asset(AppImages.arrowFoward),
      ),
    );
  }
}
