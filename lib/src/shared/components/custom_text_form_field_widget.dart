import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final Widget? icon;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool underlineBorder;
  final TextEditingController? controller;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.icon,
    required this.title,
    this.keyboardType,
    required this.textInputAction,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.focusNode,
    this.underlineBorder = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!underlineBorder)
          Text(title, style: Theme.of(context).textTheme.headline3),
        const SizedBox(height: 16),
        TextFormField(
          controller: controller,
          obscuringCharacter: '*',
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              constraints: const BoxConstraints(maxHeight: 50),
              hintText: hintText,
              suffixIcon: icon,
              border: underlineBorder
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    )),
        ),
      ],
    );
  }
}
