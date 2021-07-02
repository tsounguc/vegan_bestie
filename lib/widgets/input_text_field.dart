import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheveegan/colors.dart';

class InputTextFormField extends HookWidget {
  TextEditingController? controller;
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
  Color? fillColor;
  Widget? prefix;
  Widget? suffix;
  FocusNode? focusNode;

  InputTextFormField({
    this.focusNode,
    this.controller,
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
    this.fillColor,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            focusNode: focusNode,
            controller: controller,
            minLines: minLines,
            maxLines: null,
            initialValue: initialValue,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              isDense: true,
              hintText: hintText,
              labelStyle: TextStyle(
                color: focusNode!.hasFocus ? Colors.black54 : Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              contentPadding: EdgeInsets.only(top: 15, left: 10, bottom: 15),
              border: border,
              filled: filled,
              fillColor: fillColor,
              suffix: suffix,
            ),
            obscureText: isPassword! ? true : false,
            validator: validator,
            onSaved: onSaved,
            keyboardType:
                isEmail! ? TextInputType.emailAddress : TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}
