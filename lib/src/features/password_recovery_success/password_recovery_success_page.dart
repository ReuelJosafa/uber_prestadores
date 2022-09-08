import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uber_prestadores/src/features/home/home_page.dart';
import 'package:uber_prestadores/src/shared/constants/app_images.dart';

import '../../shared/components/custom_elevated_button_widget.dart';

class PasswordRecoverySuccessPage extends StatefulWidget {
  const PasswordRecoverySuccessPage({Key? key}) : super(key: key);

  @override
  State<PasswordRecoverySuccessPage> createState() =>
      _PasswordRecoverySuccessPageState();
}

class _PasswordRecoverySuccessPageState
    extends State<PasswordRecoverySuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              child: Image.asset(AppImages.backgroundSuccess,
                  fit: BoxFit.fitWidth)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 100),
                    SvgPicture.asset(AppImages.checkedIcon),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      child: Text(
                        'Senha recuperada com sucesso!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                child: CustomElevatedButton(
                  color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                  context,
                  title: 'Acessar Conta',
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomePage(isAnAdministrator: true))),
                ),
              ),
              // const SizedBox(height: 60)
            ],
          ),
        ],
      ),
    );
  }
}
