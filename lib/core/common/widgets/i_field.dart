import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IField extends StatelessWidget {
  const IField({
    required this.controller,
    this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.fillColor,
    this.contentPadding,
    this.suffixIcon,
    this.suffix,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.overrideValidator = false,
    this.maxLines = 1,
    this.minLines,
    this.borderRadius,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTap,
    this.fontSize,
    super.key,
  });

  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final int? minLines;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return validator?.call(value);
            },
      maxLines: maxLines,
      minLines: minLines,
      onTap: onTap,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      style: TextStyle(
        // color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: fontSize ?? 14.r,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      readOnly: readOnly,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(90),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(90),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(90),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        // overriding the default padding helps with that puffy look
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),

        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        suffix: suffix,
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              fontSize: 16.r,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
