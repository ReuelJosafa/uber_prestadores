import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../shared/components/custom_back_button_widget.dart';
import '../../shared/components/custom_elevated_button_widget.dart';
import '../password_selection/password_selection_page.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: _buildAppBar(),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Estamos quase lá!',
                  style: theme.textTheme.headline1!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 28)),
              const SizedBox(height: 20),
              Text(
                  'Insira abaixo o código de confirmação que enviamos para o seu email para prosseguir com a alteração da senha.',
                  style: theme.textTheme.headline4!
                      .copyWith(fontWeight: FontWeight.w300)),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: PinCodeTextField(
                  autoFocus: true,
                  pinTheme: PinTheme(
                      fieldWidth: 46.6,
                      activeColor: theme.colorScheme.tertiary,
                      selectedColor: theme.colorScheme.tertiary,
                      inactiveColor: const Color(0xFFA5A5A5)),
                  textStyle: TextStyle(color: theme.colorScheme.tertiary),
                  hintCharacter: '•',
                  cursorColor: theme.colorScheme.tertiary,
                  obscuringCharacter: '•',
                  blinkWhenObscuring: true,
                  obscureText: true,
                  animationType: AnimationType.scale,
                  keyboardType: TextInputType.number,
                  length: 4,
                  appContext: context,
                  onChanged: (value) {},
                ),
              ),
              const Expanded(child: SizedBox()),
              CustomElevatedButton(
                context,
                title: 'Prosseguir',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PasswordSelectionPage()),
                ),
              ),
            ],
          ),
        ));
  }

  PreferredSizeWidget _buildAppBar() {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      title: Text('Esqueci minha senha',
          style: theme.textTheme.headline3!.copyWith(
            fontWeight: FontWeight.w500,
          )),
      centerTitle: true,
      leading: CustomBackButton(context),
    );
  }
}
