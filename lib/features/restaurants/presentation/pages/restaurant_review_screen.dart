import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurant_review_form_field.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class RestaurantReviewScreen extends StatefulWidget {
  const RestaurantReviewScreen({required this.restaurantDetails, super.key});

  final RestaurantDetails restaurantDetails;

  static const String id = '/restaurantReviewScreen';

  @override
  State<RestaurantReviewScreen> createState() => _RestaurantReviewScreenState();
}

class _RestaurantReviewScreenState extends State<RestaurantReviewScreen> {
  final titleController = TextEditingController();
  final reviewController = TextEditingController();

  double rating = 0;

  final textStyle = TextStyle(
    color: Colors.black,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsBloc, RestaurantsState>(
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
            title: Text(widget.restaurantDetails.name),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'How would you rate ${widget.restaurantDetails.name}',
                        style: textStyle,
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
                              final restaurantReview = RestaurantReviewModel.empty().copyWith(
                                title: titleController.text.trim().isNotEmpty
                                    ? titleController.text.trim()
                                    : context.currentUser == null
                                        ? 'Anonymous'
                                        : context.currentUser!.name,
                                review: reviewController.text.trim(),
                                rating: rating,
                                restaurantId: widget.restaurantDetails.id,
                                username: context.currentUser?.name,
                                userProfilePic: context.currentUser?.photoUrl ?? kDefaultAvatar,
                              );
                              BlocProvider.of<RestaurantsBloc>(context).add(
                                AddRestaurantReviewEvent(
                                  restaurantReview: restaurantReview,
                                ),
                              );
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
