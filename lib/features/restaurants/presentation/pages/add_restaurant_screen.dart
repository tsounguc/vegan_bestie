import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({super.key});

  static const String id = '/addRestaurantScreen';

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        // backgroundColor: Colors.white,
        appBar: AppBar(
          // surfaceTintColor: Colors.white,
          leading: const CustomBackButton(),
          title: const Text('Add Restaurant'),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
        ));
  }
}
