import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/custom_image_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/resources/vegan_icon.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/flexible_space_bar_bottom.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/macronutrient_widget.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/product_found_body.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class ProductFoundPage extends StatefulWidget {
  const ProductFoundPage({super.key});

  static const String id = '/productFoundPage';

  @override
  State<ProductFoundPage> createState() => _ProductFoundPageState();
}

class _ProductFoundPageState extends State<ProductFoundPage> {
  final _scrollController = ScrollController();
  final _toolTipKey = GlobalKey<TooltipState>();

  Future<void> showAndCloseTooltip() async {
    final toolTip = _toolTipKey.currentState;
    await Future<void>.delayed(
      const Duration(milliseconds: 10),
    );
    toolTip?.ensureTooltipVisible();
    await Future<void>.delayed(
      const Duration(seconds: 3),
    );
    Tooltip.dismissAllToolTips();
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final state = BlocProvider.of<ScanProductCubit>(
        context,
      ).state;
      if (state is ProductFound && state.product.ingredients.isNotEmpty) {
        await showAndCloseTooltip();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanProductCubit, ScanProductState>(
      builder: (context, state) {
        if (state is ProductFound) {
          final proteinsAmount = state.product.nutriments.proteins100G;
          final carbsAmount = state.product.nutriments.carbohydrates100G;
          final fatAmount = state.product.nutriments.fat100G;
          final total = proteinsAmount + carbsAmount + fatAmount;
          var proteinsPct = (proteinsAmount / total) * 100;
          if (proteinsPct.isNaN || proteinsPct.isInfinite || proteinsPct.isNegative) {
            proteinsPct = 0;
          }
          var carbsPct = (carbsAmount / total) * 100;
          if (carbsPct.isNaN || carbsPct.isInfinite || carbsPct.isNegative) {
            carbsPct = 0;
          }
          var fatPct = (fatAmount / total) * 100;
          if (fatPct.isNaN || fatPct.isInfinite || fatPct.isNegative) {
            fatPct = 0;
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  expandedHeight: context.height * 0.50,
                  snap: true,
                  pinned: true,
                  floating: true,
                  backgroundColor: Colors.white,
                  leading: const CustomBackButton(),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomImageWidget(
                            imageUrl: state.product.imageFrontUrl,
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: FlexibleSpaceBarBottom(
                      toolTipKey: _toolTipKey,
                      state: state,
                      onTooltipTriggered: showAndCloseTooltip,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProductFoundBody(
                    fatPercentage: fatPct,
                    carbsPercentage: carbsPct,
                    proteinsPercentage: proteinsPct,
                    state: state,
                    scrollController: _scrollController,
                  ),
                ),
              ],
            ),
          );
        }
        return const LoadingPage();
      },
    );
  }
}
