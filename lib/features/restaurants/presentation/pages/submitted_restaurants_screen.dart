import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/date_time_extensions.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_submit_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/add_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class SubmittedRestaurantsScreen extends StatelessWidget {
  const SubmittedRestaurantsScreen({super.key});

  static const id = 'submittedRestaurantsScreen';

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return StreamBuilder<List<RestaurantSubmit>>(
      stream: serviceLocator<FirebaseFirestore>()
          .collection(FirebaseConstants.submittedRestaurantsCollection)
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (event) => RestaurantSubmitModel.fromMap(event.data()),
                )
                .toList(),
          ),
      builder: (context, snapshot) {
        final restaurantSubmits =
            context.submittedRestaurantsProvider.submittedRestaurants = snapshot.data ?? <RestaurantSubmitModel>[];
        return BlocListener<RestaurantsCubit, RestaurantsState>(
          listener: (context, state) {
            // if (state is ProductFound) {
            //   Navigator.of(context).pushNamed(
            //     ProductFoundPage.id,
            //     arguments: state.product,
            //   );
            // }
          },
          child: Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              surfaceTintColor: Colors.white,
              leading: CustomBackButton(
                color: context.theme.iconTheme.color!,
              ),
              title: const Text(
                'Submitted Restaurants',
              ),
            ),
            body: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: restaurantSubmits.length,
                    itemBuilder: (BuildContext context, int index) {
                      final submission = restaurantSubmits[index];
                      return GestureDetector(
                        onTap: () {
                          // BlocProvider.of<RestaurantsCubit>(context).fetchProduct(
                          //   barcode: restaurant.barcode,
                          // );
                          Navigator.of(context).pushNamed(
                            AddRestaurantScreen.id,
                            arguments: submission.submittedRestaurant,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 25,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 12.5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade700),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: context.width * 0.65,
                                    child: Text(
                                      'Restaurant name: ${submission.submittedRestaurant.name}',
                                      style: TextStyle(
                                        // color: Colors.grey.shade800,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<RestaurantsCubit>(
                                        context,
                                      ).deleteRestaurantSubmission(submission);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address: ${submission.submittedRestaurant.streetAddress}, '
                                      '\n${submission.submittedRestaurant.city}, ${submission.submittedRestaurant.state}',
                                      style: TextStyle(
                                        // color: Colors.grey.shade800,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Vegan status: ${submission.submittedRestaurant.veganStatus}',
                                  style: TextStyle(
                                    // color: Colors.grey.shade800,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (!submission.submittedRestaurant.veganStatus)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    'Has vegan options: ${submission.submittedRestaurant.hasVeganOptions}',
                                    style: TextStyle(
                                      // color: Colors.grey.shade800,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Price: ${submission.submittedRestaurant.price}',
                                  style: TextStyle(
                                    // color: Colors.grey.shade800,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'From User: ${submission.userName}',
                                      style: TextStyle(
                                        // color: Colors.grey.shade800,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Submitted ${submission.submittedAt.timeAgo}',
                                      style: TextStyle(
                                        // color: Colors.grey.shade800,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
