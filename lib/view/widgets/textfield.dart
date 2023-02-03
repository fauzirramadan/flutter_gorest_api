import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? suffixIcon;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  const CustomTextField(
      {Key? key,
      this.validator,
      this.controller,
      this.onTap,
      this.hintText,
      this.suffixIcon,
      this.onSubmitted,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        suffixIcon: suffixIcon ?? const SizedBox(),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.grey[200],
        filled: true,
      ),
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
    );
  }
}
