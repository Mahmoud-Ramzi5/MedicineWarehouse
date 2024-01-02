import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String labelText;
  final bool obsecureText;
  final Icon icon;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final InkWell? inkWell;

  const CustomTextWidget({
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.obsecureText,
    this.hintText,
    this.inputType,
    super.key,
    this.validator,
    this.inkWell,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: TextInputType.phone,
      validator: validator,
      obscureText: obsecureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 20),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 20),
        border: const OutlineInputBorder(),
        prefixIcon: icon,
        iconColor: Colors.green,
        suffixIcon: inkWell,
      ),
    );
  }
}
