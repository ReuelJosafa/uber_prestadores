import 'package:flutter/material.dart';

import '../../shared/components/custom_back_button_widget.dart';
import '../../shared/components/custom_elevated_button_widget.dart';
import '../../shared/components/custom_text_form_field_widget.dart';
import '../../shared/constants/app_routes.dart';
import '../password_recovery_success/password_recovery_success_page.dart';

class PasswordSelectionPage extends StatefulWidget {
  const PasswordSelectionPage({Key? key}) : super(key: key);

  @override
  State<PasswordSelectionPage> createState() => _PasswordSelectionPageState();
}

class _PasswordSelectionPageState extends State<PasswordSelectionPage> {
  final passwordFocus = FocusNode();
  final passwordConfirmationFocus = FocusNode();

  bool _isPasswordVisible = true;
  bool _isPasswordconfirmationVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(),
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Column(
                children: [
                  Text('Escolha uma nova senha!',
                      style: theme.textTheme.headline1!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 28)),
                  const SizedBox(height: 20),
                  Text(
                      'Crie uma nova senha para sua conta, não se esqueça de mantê-la salva em seu dispositivo para não perdê-la.',
                      style: theme.textTheme.headline4!
                          .copyWith(fontWeight: FontWeight.w300)),
                  const SizedBox(height: 50),
                  CustomTextFormField(
                      underlineBorder: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      focusNode: passwordFocus,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(passwordConfirmationFocus),
                      obscureText: _isPasswordVisible,
                      title: 'Nova senha',
                      hintText: 'Nova senha',
                      icon: IconButton(
                        onPressed: () => setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        }),
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                        ),
                      )),
                  CustomTextFormField(
                      underlineBorder: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      focusNode: passwordConfirmationFocus,
                      obscureText: _isPasswordconfirmationVisible,
                      title: 'Confirme a senha',
                      hintText: 'Confirme a senha',
                      icon: IconButton(
                        onPressed: () => setState(() {
                          _isPasswordconfirmationVisible =
                              !_isPasswordconfirmationVisible;
                        }),
                        icon: Icon(
                          _isPasswordconfirmationVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 106),
            CustomElevatedButton(
              context,
              title: 'Salvar nova senha',
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.passwordRecovered),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      title: Text('Crie uma nova senha',
          style: theme.textTheme.headline3!.copyWith(
            fontWeight: FontWeight.w500,
          )),
      centerTitle: true,
      leading: CustomBackButton(context),
    );
  }
}
