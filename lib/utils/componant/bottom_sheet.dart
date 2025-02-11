import 'package:flutter/material.dart';
import 'package:simple_todo_app/utils/componant/main_text_field.dart';

Widget customBottomSheet({
  TextEditingController? controller,
  String? labelText,
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function(String)? onFieldSubmitted,
  TextEditingController? controller1,
  String? labelText1,
  String? hintText1,
  Widget? prefixIcon1,
  Widget? suffixIcon1,
  String? Function(String?)? validator1,
  void Function(String)? onChanged1,
  void Function()? onTap1,
  void Function(String)? onFieldSubmitted1,
  Key? key2,
  TextEditingController? controller2,
  String? labelText2,
  String? hintText2,
  Widget? prefixIcon2,
  Widget? suffixIcon2,
  String? Function(String?)? validator2,
  void Function(String)? onChanged2,
  void Function()? onTap2,
  void Function(String)? onFieldSubmitted2,
  TextInputType? keyboardType = TextInputType.text,
  TextInputType? keyboardType1 = TextInputType.text,
  TextInputType? keyboardType2 = TextInputType.text,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        mainTextField(
          controller: controller,
          hintText: 'Title',
          labelText: 'Title',
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          prefixIcon: Icon(Icons.title),
          suffixIcon: suffixIcon,
          validator: validator,
        ),
        SizedBox(
          height: 16,
        ),
        mainTextField(
          controller: controller1,
          hintText: 'Time',
          labelText: 'Time',
          onChanged: onChanged1,
          onFieldSubmitted: onFieldSubmitted1,
          onTap: onTap1,
          prefixIcon: Icon(Icons.watch_later_outlined),
          suffixIcon: suffixIcon1,
          validator: validator1,
        ),
        SizedBox(
          height: 16,
        ),
        mainTextField(
          controller: controller2,
          hintText: 'Date',
          labelText: 'Date',
          onChanged: onChanged2,
          onFieldSubmitted: onFieldSubmitted2,
          onTap: onTap2,
          prefixIcon: Icon(Icons.calendar_month),
          suffixIcon: suffixIcon2,
          validator: validator2,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    ),
  );
}
