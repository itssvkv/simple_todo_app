import 'package:flutter/material.dart';

Widget mainTextField({
  TextEditingController? controller,
  String? labelText,
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function(String)? onFieldSubmitted,
  TextInputType? keyboardType = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    onTap: onTap,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffix: suffixIcon,
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(),
    ),
  );
}
