import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/custom_image_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/flexible_space_bar_bottom.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/product_found_body.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class ProductFoundPage extends StatefulWidget {
  const ProductFoundPage({
    super.key,
    required this.product,
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
    BlocProvider.of<ScanProductCubit>(
      context,
    ).removeFoodProductHandler(product: product);
    CoreUtils.showSnackBar(
      context,
      'Product removed',
    );
  }

  void saveFoodProduct(FoodProduct product) {
    BlocProvider.of<ScanProductCubit>(
      context,
    ).saveFoodProductHandler(product: product);
    CoreUtils.showSnackBar(
      context,
      'Product saved',
    );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // final state = BlocProvider.of<ScanProductCubit>(
      //   context,
      // ).state;
      if (widget.product.ingredients.isNotEmpty) {
        await showAndCloseTooltip();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final proteinsAmount = widget.product.nutriments.proteins100G;
    final carbsAmount = widget.product.nutriments.carbohydrates100G;
    final fatAmount = widget.product.nutriments.fat100G;
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
      stream: serviceLocator<FirebaseFirestore>()
          .collection('users')
          .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
          .snapshots()
          .map(
            (event) => UserModel.fromMap(event.data()!),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.userProvider.user = snapshot.data;
        }
        final user = context.userProvider.user;
        print(snapshot.data?.savedProductsBarcodes);
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
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white.withOpacity(0.7),
                    ),
                    child: Icon(
                      Icons.bookmark,
                      color: user!.savedProductsBarcodes!.contains(
                        widget.product.code,
                      )
                          ? Colors.amberAccent
                          : Colors.white,
                      // size: 30,
                    ),
                    onPressed: () => user.savedProductsBarcodes!.contains(
                      widget.product.code,
                    )
                        ? removeFoodProduct(widget.product)
                        : saveFoodProduct(widget.product),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomImageWidget(
                          imageUrl: widget.product.imageFrontUrl,
                        ),
                      ),
                    ],
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
        );
      },
    );
  }
}
