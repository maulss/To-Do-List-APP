import 'package:flutter/material.dart';
import 'package:todo_app/constants/color_constant.dart';
import 'package:todo_app/constants/text_style_constant.dart';

class FormWidget extends StatelessWidget {
  const FormWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscureText,
      this.onChanged,
      this.errorText,
      this.suffixIcon});

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? errorText;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyleConstant.lato,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          errorText: errorText,
          suffixIconColor: Colors.white,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: ColorConstant.backgroundFormColor.withOpacity(0.4),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          labelStyle: TextStyleConstant.lato,
          labelText: labelText),
      controller: controller,
    );
  }
}
