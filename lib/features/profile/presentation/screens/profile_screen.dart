import 'package:flutter/material.dart';
import 'package:sheveegan/features/profile/presentation/widgets/profile_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const ProfileAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
