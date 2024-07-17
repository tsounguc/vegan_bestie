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
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurant_review_form_field.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class EditRestaurantReviewScreen extends StatefulWidget {
  const EditRestaurantReviewScreen({
    // required this.argument,
    required this.review,
    required this.restaurant,
    super.key,
  });

  // final EditRestaurantScreenArguments argument;

  final RestaurantReview review;
  final Restaurant restaurant;

  static const String id = '/editRestaurantReviewScreen';

  @override
  State<EditRestaurantReviewScreen> createState() => _EditRestaurantReviewScreenState();
}

class _EditRestaurantReviewScreenState extends State<EditRestaurantReviewScreen> {
  final titleController = TextEditingController();
  final reviewController = TextEditingController();

  double rating = 0;

  @override
  void initState() {
    rating = widget.review.rating;
    titleController.text = widget.review.title;
    reviewController.text = widget.review.review;
    super.initState();
  }

  final textStyle = TextStyle(
    color: Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  bool get ratingChanged => rating != widget.review.rating;

  bool get titleChanged => titleController.text.trim() != widget.review.title;

  bool get reviewChanged => reviewController.text.trim() != widget.review.review;

  bool get nothingChanged => !ratingChanged && !titleChanged && !reviewChanged;

  void submitChanges(BuildContext context) {
    final restaurantReview = (widget.review as RestaurantReviewModel).copyWith(
      title: titleController.text.trim().isNotEmpty
          ? titleController.text.trim()
          : context.currentUser == null
              ? 'Anonymous'
              : context.currentUser!.name,
      review: reviewController.text.trim(),
      rating: rating,
      username: context.currentUser?.name,
      userProfilePic: context.currentUser?.photoUrl ?? kDefaultAvatar,
    );
    BlocProvider.of<RestaurantsCubit>(context).editRestaurantReview(
      review: restaurantReview,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsCubit, RestaurantsState>(
      listener: (context, state) {
        if (state is RestaurantReviewEdited) {
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
                  initialRating: rating,
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

                    return state is EditingRestaurantReview
                        ? const Center(child: CircularProgressIndicator())
                        : LongButton(
                            onPressed: nothingChanged
                                ? null
                                : () {
                                    submitChanges(context);
                                  },
                            label: 'Submit',
                            backgroundColor:
                                nothingChanged ? Colors.grey : Theme.of(context).buttonTheme.colorScheme?.primary,
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
