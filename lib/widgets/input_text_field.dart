import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InputTextFormField extends HookWidget {
  String? labelText;
  String? hintText;
  String? initialValue;
  int? minLines;
  String? Function(String?)? validator;
  Function(String?)? onSaved;
  InputBorder? border;
  bool? isPassword;
  bool? isEmail;
  bool? filled;
  Widget? prefix;
  Widget? suffix;

  InputTextFormField({
    this.labelText,
    this.hintText,
    this.initialValue,
    this.minLines,
    this.border,
    this.validator,
    this.onSaved,
    this.isEmail = false,
    this.isPassword = false,
    this.filled = false,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        minLines: minLines,
        maxLines: null,
        initialValue: initialValue,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          labelText: labelText,
          contentPadding: EdgeInsets.only(top: 30, left: 8, bottom: 10),
          border: border,
          filled: filled,
          fillColor: Colors.white70,
          suffix: suffix,
        ),
        obscureText: isPassword! ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType:
            isEmail! ? TextInputType.emailAddress : TextInputType.multiline,
      ),
    );
  }
}
