import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sheveegan/core/resources/media_resources.dart';

class NoNotifications extends StatelessWidget {
  const NoNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(MediaResources.noNotification));
  }
}
