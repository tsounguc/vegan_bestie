import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/custom_image_widget.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/presentation/pages/food_product_report_screen.dart';
import 'package:sheveegan/features/food_product/presentation/pages/refactors/flexible_space_bar_bottom.dart';
import 'package:sheveegan/features/food_product/presentation/pages/refactors/product_found_body.dart';
import 'package:sheveegan/features/food_product/presentation/pages/update_food_product_screen.dart';
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

  void unSaveFoodProduct(FoodProduct product) {
    BlocProvider.of<FoodProductCubit>(
      context,
    ).unSaveFoodProductHandler(product: product);
  }

  void saveFoodProduct(FoodProduct product) {
    BlocProvider.of<FoodProductCubit>(
      context,
    ).saveFoodProductHandler(product: product);
  }

  void gotoUpdateFoodProductPage(BuildContext context, FoodProduct product) {
    Navigator.pushNamed(
      context,
      UpdateFoodProductScreen.id,
      arguments: UpdateFoodProductPageArguments('Edit Product', product),
    );
  }

  void goToReportIssue(BuildContext context, FoodProduct product) {
    Navigator.pushNamed(
      context,
      FoodProductReportScreen.id,
      arguments: product,
    );
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
    const popupMenuItemPadding = EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 5,
    );
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
        final isAdmin = user != null && user.isAdmin;
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
                          isSaved ? unSaveFoodProduct(widget.product) : saveFoodProduct(widget.product),
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert_outlined,
                        color: context.theme.appBarTheme.iconTheme?.color,
                      ),
                      surfaceTintColor: context.theme.cardTheme.color,
                      color: context.theme.cardTheme.color,
                      offset: const Offset(0, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      itemBuilder: (_) {
                        return [
                          PopupMenuItem<void>(
                            padding: popupMenuItemPadding,
                            onTap: () =>
                                isSaved ? unSaveFoodProduct(widget.product) : saveFoodProduct(widget.product),
                            child: PopupItem(
                              title: isSaved ? 'Unsave' : 'Save',
                              icon: Icon(
                                isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                color: context.theme.iconTheme.color,
                              ),
                            ),
                          ),
                          PopupMenuItem<void>(
                            padding: popupMenuItemPadding,
                            onTap: () => isAdmin
                                ? gotoUpdateFoodProductPage(context, widget.product)
                                : goToReportIssue(context, widget.product),
                            child: PopupItem(
                              title: isAdmin ? 'Fix Issue' : 'Report Issue',
                              icon: Icon(
                                Icons.report_outlined,
                              ),
                            ),
                          ),
                        ];
                      },
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
