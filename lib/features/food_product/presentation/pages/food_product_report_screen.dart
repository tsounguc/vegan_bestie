import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';

class FoodProductReportScreen extends StatefulWidget {
  const FoodProductReportScreen({super.key});

  static const String id = '/foodProductReportScreen';

  @override
  State<FoodProductReportScreen> createState() => _FoodProductReportScreenState();
}

class _FoodProductReportScreenState extends State<FoodProductReportScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodProductCubit, FoodProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            leading: const CustomBackButton(
              color: Colors.black,
            ),
            title: Text('Report Issue'),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                shrinkWrap: true,
                children: [],
              ),
            ),
          ),
        );
      },
    );
  }
}
