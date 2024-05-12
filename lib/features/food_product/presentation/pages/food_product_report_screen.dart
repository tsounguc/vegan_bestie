import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_model.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_report_model.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/home_page.dart';

class FoodProductReportScreen extends StatefulWidget {
  const FoodProductReportScreen({super.key, this.product});

  final FoodProductModel? product;
  static const String id = '/foodProductReportScreen';

  @override
  State<FoodProductReportScreen> createState() => _FoodProductReportScreenState();
}

class _FoodProductReportScreenState extends State<FoodProductReportScreen> {
  final List<IssueItem> listOfIssues = [
    IssueItem(title: 'Wrong Image'),
    IssueItem(title: 'Incorrect Name'),
    IssueItem(title: 'Incorrect protein, carbs, and/or fat amounts'),
    IssueItem(title: 'Wrong or incomplete ingredients'),
    IssueItem(title: 'Wrong Vegan or Vegetarian label'),
    IssueItem(title: 'Wrong product'),
    IssueItem(title: 'other'),
  ];
  bool itemSelected = false;
  final commentController = TextEditingController();

  bool get commentEntered => commentController.text.trim().isNotEmpty;

  bool get canSubmit => commentEntered || itemSelected;

  void submitChanges(BuildContext context) {
    final user = context.currentUser;
    final report = const FoodProductReportModel.empty().copyWith(
      barcode: widget.product?.code,
      userId: user?.uid,
      userName: user?.name,
      incorrectImage: listOfIssues[0].isSelected,
      incorrectProductName: listOfIssues[1].isSelected,
      incorrectMacros: listOfIssues[2].isSelected,
      incorrectIngredients: listOfIssues[3].isSelected,
      incorrectLabel: listOfIssues[4].isSelected,
      isWrongProduct: listOfIssues[5].isSelected,
      other: listOfIssues[6].isSelected,
      comment: commentController.text.trim(),
    );
    BlocProvider.of<FoodProductCubit>(
      context,
    ).reportIusse(report);
  }

  @override
  Widget build(BuildContext context) {
    for (final item in listOfIssues) {
      if (item.isSelected ?? false) {
        setState(() {
          itemSelected = true;
        });
      }
    }
    return BlocConsumer<FoodProductCubit, FoodProductState>(
      listener: (context, state) {
        if (state is IssueReported) {
          CoreUtils.showSnackBar(context, 'Issue reported');
          // Navigator.pop(context);
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            leading: const CustomBackButton(
              color: Colors.black,
            ),
            title: const Text(
              'Report Issue',
              style: TextStyle(
                // fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 25,
                ),
                shrinkWrap: true,
                children: [
                  Text(
                    "What's the issue?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: listOfIssues.length,
                    itemBuilder: (context, index) {
                      final issue = listOfIssues[index];
                      return CheckboxListTile(
                        value: issue.isSelected,
                        title: Text(
                          issue.title,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onChanged: (value) {
                          itemSelected = false;
                          setState(() {
                            listOfIssues[index].isSelected = value;
                          });
                          debugPrint('${listOfIssues[index].isSelected}');
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 70),
                  IField(
                    controller: commentController,
                    hintText: 'Anything else we should know',
                    borderRadius: BorderRadius.circular(20),
                    maxLines: null,
                    minLines: 4,
                  ),
                  const SizedBox(height: 30),
                  StatefulBuilder(
                    builder: (context, refresh) {
                      commentController.addListener(() => refresh(() {}));
                      return state is ReportingIssue
                          ? const Center(child: CircularProgressIndicator())
                          : LongButton(
                              onPressed: !canSubmit
                                  ? null
                                  : () => submitChanges(
                                        context,
                                      ),
                              label: 'Submit',
                              backgroundColor: !canSubmit
                                  ? Colors.grey
                                  : Theme.of(
                                      context,
                                    ).buttonTheme.colorScheme?.primary,
                              textColor: Colors.white,
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class IssueItem extends Equatable {
  IssueItem({
    required this.title,
    this.isSelected = false,
  });

  final String title;
  bool? isSelected;

  @override
  List<Object?> get props => [title, isSelected];
}
