import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    required this.onPressed, required this.label, super.key,
  });
  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: Theme.of(context).primaryColor,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
