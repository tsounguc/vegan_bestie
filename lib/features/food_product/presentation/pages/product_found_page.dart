import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/custom_image_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/presentation/pages/refactors/flexible_space_bar_bottom.dart';
import 'package:sheveegan/features/food_product/presentation/pages/refactors/product_found_body.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';

class ProductFoundPage extends StatefulWidget {
  const ProductFoundPage({
    required this.product,
    super.key,
  });

  final FoodProduct product;

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

  void removeFoodProduct(FoodProduct product) {
    BlocProvider.of<FoodProductCubit>(
      context,
    ).unSaveFoodProductHandler(product: product);
  }

  void saveFoodProduct(FoodProduct product) {
    BlocProvider.of<FoodProductCubit>(
      context,
    ).saveFoodProductHandler(product: product);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.product.ingredients.isNotEmpty) {
        await showAndCloseTooltip();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final proteinsAmount = widget.product.nutriments.proteinsServing;
    final carbsAmount = widget.product.nutriments.carbohydratesServing;
    final fatAmount = widget.product.nutriments.fatServing;
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

    return StreamBuilder<UserModel>(
      stream: DashboardUtils.userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.read<UserProvider>().user = snapshot.data;
        }

        final user = context.userProvider.user;

        final isSaved = user!.savedProductsBarcodes.contains(widget.product.code);

        return BlocListener<FoodProductCubit, FoodProductState>(
          listener: (context, state) {
            if (state is FoodProductSaved) {
              CoreUtils.showSnackBar(
                context,
                'Product saved',
              );
              final foodProductBarcodes = context.userProvider.user?.savedProductsBarcodes ?? [];
              BlocProvider.of<FoodProductCubit>(context).fetchProductsList(foodProductBarcodes);
            }

            if (state is FoodProductUnSaved) {
              CoreUtils.showSnackBar(context, 'Product unsaved');
              final foodProductBarcodes = context.userProvider.user?.savedProductsBarcodes ?? [];
              BlocProvider.of<FoodProductCubit>(context).fetchProductsList(foodProductBarcodes);
            }
            if (state is SavedProductsListFetched) {
              context.savedProductsProvider.savedProductsList = state.savedProductsList;
            }
          },
          child: Scaffold(
            // backgroundColor: Colors.white,
            body: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  expandedHeight: context.height * 0.46,
                  pinned: true,
                  // backgroundColor: Colors.white,
                  leading: const CustomBackButton(),
                  actions: [
                    IconButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white.withOpacity(0.7),
                      ),
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_outline,
                        color: isSaved ? Colors.amberAccent : context.theme.iconTheme.color?.withOpacity(0.5),
                        // size: 30,
                      ),
                      onPressed: () =>
                          isSaved ? removeFoodProduct(widget.product) : saveFoodProduct(widget.product),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: CustomImageWidget(
                      imageUrl: widget.product.imageFrontUrl,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: FlexibleSpaceBarBottom(
                      toolTipKey: _toolTipKey,
                      product: widget.product,
                      onTooltipTriggered: showAndCloseTooltip,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProductFoundBody(
                    fatPercentage: fatPct,
                    carbsPercentage: carbsPct,
                    proteinsPercentage: proteinsPct,
                    product: widget.product,
                    scrollController: _scrollController,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
