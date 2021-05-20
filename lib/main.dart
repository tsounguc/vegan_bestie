import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/home.dart';

void main() {
  runApp(ProviderScope(child: Home()));
}
