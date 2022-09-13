import 'package:flutter/material.dart';

import '../../shared/components/custom_elevated_button_widget.dart';
import '../../shared/components/custom_text_form_field_widget.dart';
import '../../shared/constants/app_routes.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const Text('LOGO',
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.w400)),
              const SizedBox(height: 32),
              const Text('Seja bem-vindo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
              const SizedBox(height: 20),
              Form(
                  child: Column(
                children: [
                  CustomTextFormField(
                      controller: controller,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      title: 'Login',
                      hintText: 'Nome de usuário'),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: _isPasswordObscured,
                      title: 'Senha',
                      hintText: '*********',
                      icon: IconButton(
                        onPressed: () => setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        }),
                        icon: Icon(
                          _isPasswordObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                        ),
                      )),
                ],
              )),
              const SizedBox(height: 11),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.forgetPassword),
                  child: Text("Esqueceu a senha?",
                      style: theme.textTheme.headline4),
                ),
              ),
              const SizedBox(height: 32),
              CustomElevatedButton(context,
                  title: 'Efetuar login',
                  onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.home, (route) => false,
                      arguments: controller.text == 'adm')),
              const SizedBox(height: 32),
              Text.rich(
                TextSpan(text: 'Não tem uma conta? ', children: [
                  WidgetSpan(
                      child: GestureDetector(
                    onTap: () {},
                    child: Text('registre-se',
                        style: theme.textTheme.headline4!
                            .copyWith(fontWeight: FontWeight.w600)),
                  )),
                ]),
                style: theme.textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
