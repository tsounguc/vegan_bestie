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

class FoodProductReportScreen extends StatefulWidget {
  const FoodProductReportScreen({super.key, this.product});

  final FoodProductModel? product;
  static const String id = '/foodProductReportScreen';

  @override
  State<FoodProductReportScreen> createState() => _FoodProductReportScreenState();
}

class _FoodProductReportScreenState extends State<FoodProductReportScreen> {
  final List<IssueItem> listOfIssues = [
    IssueItem(
      title: 'Wrong or no image',
      hint: '',
      textEditingController: TextEditingController(),
      expansionTileController: ExpansionTileController(),
    ),
    IssueItem(
      title: 'Incorrect name',
      hint: 'What is the correct name',
      textEditingController: TextEditingController(),
      expansionTileController: ExpansionTileController(),
    ),
    IssueItem(
      title: 'Incorrect protein, carbs, and/or fat amounts',
      hint: 'Please provide more details',
      textEditingController: TextEditingController(),
      expansionTileController: ExpansionTileController(),
    ),
    IssueItem(
      title: 'Wrong or incomplete ingredients',
      hint: 'Please provide more details',
      textEditingController: TextEditingController(),
      expansionTileController: ExpansionTileController(),
    ),
    IssueItem(
      title: 'Wrong Vegan or Vegetarian label',
      hint: 'Please provide more details',
      textEditingController: TextEditingController(),
      expansionTileController: ExpansionTileController(),
    ),
    IssueItem(
      title: 'Wrong product',
      hint: 'Please provide more details',
      textEditingController: TextEditingController(),
      expansionTileController: ExpansionTileController(),
    ),
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
      comment: commentController.text.trim(),
      productNameSuggestion: listOfIssues[1].textEditingController?.text ?? '',
      macrosSuggestion: listOfIssues[2].textEditingController?.text ?? '',
      ingredientsSuggestion: listOfIssues[3].textEditingController?.text ?? '',
      labelSuggestion: listOfIssues[4].textEditingController?.text ?? '',
      productDescription: listOfIssues[5].textEditingController?.text ?? '',
    );
    BlocProvider.of<FoodProductCubit>(
      context,
    ).reportIssue(report);
  }

  @override
  void initState() {
    listOfIssues[1].textEditingController!.text = widget.product?.productName ?? '';
    super.initState();
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
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            leading: CustomBackButton(
              color: context.theme.iconTheme.color!,
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
                      // color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listOfIssues.length,
                    itemBuilder: (context, index) {
                      final issue = listOfIssues[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Theme(
                          data: context.theme.copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            iconColor: context.theme.iconTheme.color,
                            collapsedIconColor: context.theme.iconTheme.color,
                            childrenPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 25,
                            ),
                            initiallyExpanded: issue.isSelected ?? false,
                            controller: issue.expansionTileController,
                            title: Text(
                              issue.title,
                              style: TextStyle(
                                color: context.theme.textTheme.bodyMedium?.color,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            trailing: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: context.theme.iconTheme.color,
                              ),
                              child: Checkbox(
                                value: issue.isSelected,
                                fillColor: MaterialStatePropertyAll(
                                  issue.isSelected! ? context.theme.primaryColor : Colors.transparent,
                                ),
                                onChanged: (value) {
                                  itemSelected = false;
                                  setState(() {
                                    issue.isSelected = value;
                                    if (issue.isSelected == true && issue.title != 'Wrong Image') {
                                      issue.expansionTileController.expand();
                                    } else {
                                      issue.expansionTileController.collapse();
                                    }
                                  });
                                },
                              ),
                            ),
                            enabled: false,
                            children: [
                              if (issue.title != 'Wrong Image')
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: context.width * 0.70,
                                            child: IField(
                                              controller: issue.textEditingController!,
                                              hintText: issue.hint,
                                              hintStyle: TextStyle(
                                                fontSize: 12.sp,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                              textInputAction: null,
                                              maxLines: null,
                                              minLines: index == 1 ? 2 : 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
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

//ignore: must_be_immutable
class IssueItem extends Equatable {
  IssueItem({
    required this.title,
    required this.hint,
    required this.expansionTileController,
    this.isSelected = false,
    this.textEditingController,
  });

  final String title;
  final String hint;
  bool? isSelected;
  final ExpansionTileController expansionTileController;
  final TextEditingController? textEditingController;

  @override
  List<Object?> get props => [title, isSelected];
}
