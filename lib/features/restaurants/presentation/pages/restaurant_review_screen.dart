import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurant_review_form_field.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class RestaurantReviewScreen extends StatefulWidget {
  const RestaurantReviewScreen({required this.restaurant, super.key});

  final Restaurant restaurant;

  static const String id = '/restaurantReviewScreen';

  @override
  State<RestaurantReviewScreen> createState() => _RestaurantReviewScreenState();
}

class _RestaurantReviewScreenState extends State<RestaurantReviewScreen> {
  final titleController = TextEditingController();
  final reviewController = TextEditingController();

  double rating = 0;

  void submitReview(BuildContext context) {
    final restaurantReview = RestaurantReviewModel.empty().copyWith(
      title: titleController.text.trim().isNotEmpty
          ? titleController.text.trim()
          : context.currentUser == null
              ? 'Anonymous'
              : context.currentUser!.name,
      text: reviewController.text.trim(),
      rating: rating,
      restaurantId: widget.restaurant.id,
      // username: context.currentUser?.name,
      userId: context.currentUser != null ? context.currentUser!.uid : 'Anonymous',
      // userProfilePic: context.currentUser?.photoUrl ?? kDefaultAvatar,
    );
    BlocProvider.of<RestaurantsCubit>(context).addRestaurantReview(restaurantReview);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsCubit, RestaurantsState>(
      listener: (context, state) {
        if (state is RestaurantReviewAdded) {
          debugPrint('RestaurantReviewAdded');
          Navigator.of(context).pop();
          CoreUtils.showSnackBar(
            context,
            'Review submitted successfully',
          );
        } else if (state is RestaurantsError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.restaurant.name),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Wrap(
                    children: [
                      Text(
                        'How would you rate ${widget.restaurant.name}',
                        style: TextStyle(
                          // color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  allowHalfRating: true,
                  itemBuilder: (context, rating) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  onRatingUpdate: (value) {
                    debugPrint('$value');
                    setState(() {
                      rating = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                RestaurantReviewFormField(
                  fieldTitle: 'Title your review',
                  controller: titleController,
                  borderRadius: BorderRadius.circular(20),
                ),
                SizedBox(height: 10.h),
                RestaurantReviewFormField(
                  fieldTitle: 'Write your review',
                  controller: reviewController,
                  borderRadius: BorderRadius.circular(20),
                  minLines: 4,
                  maxLines: null,
                ),
                const SizedBox(height: 30),
                StatefulBuilder(
                  builder: (context, refresh) {
                    titleController.addListener(() => refresh(() {}));
                    reviewController.addListener(() => refresh(() {}));
                    final canSave = titleController.text.trim().isEmpty || reviewController.text.trim().isEmpty;
                    return state is AddingRestaurantReview
                        ? const Center(child: CircularProgressIndicator())
                        : LongButton(
                            onPressed: () {
                              submitReview(context);
                            },
                            label: 'Submit',
                            backgroundColor:
                                canSave ? Colors.grey : Theme.of(context).buttonTheme.colorScheme?.primary,
                            textColor: Colors.white,
                          );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
