import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/enums/update_restaurant_info.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/add_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/open_hour_tile.dart';

import 'package:sheveegan/features/restaurants/presentation/pages/componets/update_restaurant_form.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class UpdateRestaurantScreen extends StatefulWidget {
  const UpdateRestaurantScreen({required this.restaurant, super.key});

  final Restaurant? restaurant;

  static const String id = 'updateRestaurantScreen';

  @override
  State<UpdateRestaurantScreen> createState() => _UpdateRestaurantScreenState();
}

class _UpdateRestaurantScreenState extends State<UpdateRestaurantScreen> {
  final TextEditingController restaurantNameController =
      TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ExpansionTileController veganStatusExpansionController =
      ExpansionTileController();
  bool? veganStatus;
  bool? hasVeganOptions;
  bool? takeout;
  bool? dineIn;
  bool? delivery;

  List<OpenDayItem> openDaysList = [];
  File? pickedImage;

  Future<void> showRestaurantThumbnailPickerOptions(
      BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 10,
              ),
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(
                'Camera',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await CoreUtils.getImageFromCamera();

                setState(() {
                  pickedImage = image;
                });
              },
            ),
            SizedBox(
              child: Divider(
                color: Colors.grey.shade300,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 10,
              ),
              leading: const Icon(
                Icons.image_outlined,
              ),
              title: Text(
                'Gallery',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await CoreUtils.pickImageFromGallery();

                setState(() {
                  pickedImage = image;
                });
              },
            ),
          ],
        );
      },
    );
  }

  bool get restaurantNameChanged =>
      widget.restaurant!.name != restaurantNameController.text.trim();

  bool get streetAddressChanged =>
      widget.restaurant!.streetAddress != streetAddressController.text.trim();

  bool get cityChanged => widget.restaurant!.city != cityController.text.trim();

  bool get stateChanged =>
      widget.restaurant!.state != stateController.text.trim();

  bool get zipcodeChanged =>
      widget.restaurant!.zipCode != zipcodeController.text.trim();

  bool get phoneNumberChanged =>
      widget.restaurant!.phoneNumber != phoneNumberController.text.trim();

  bool get websiteChanged =>
      widget.restaurant!.websiteUrl != websiteController.text.trim();

  bool get descriptionChanged =>
      descriptionController.text.isNotEmpty &&
      widget.restaurant!.description != descriptionController.text.trim();

  bool get veganStatusChanged => widget.restaurant!.veganStatus != veganStatus;

  bool get hasVeganOptionsChanged =>
      widget.restaurant!.hasVeganOptions != hasVeganOptions;

  bool get takeoutChanged => widget.restaurant!.takeout != takeout;

  bool get dineInChanged => widget.restaurant!.dineIn != dineIn;

  bool get deliveryChanged => widget.restaurant!.delivery != delivery;

  bool get openHoursChanged {
    for (final openDay in openDaysList) {
      for (final periodItem in openDay.periodItems) {
        if (periodItem.openTextEditingController.text.isNotEmpty &&
            periodItem.closeTextEditingController.text.isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !restaurantNameChanged &&
      !streetAddressChanged &&
      !cityChanged &&
      !stateChanged &&
      !zipcodeChanged &&
      !phoneNumberChanged &&
      !descriptionChanged &&
      !veganStatusChanged &&
      !hasVeganOptionsChanged &&
      !takeoutChanged &&
      !dineInChanged &&
      !deliveryChanged &&
      !imageChanged &&
      !openHoursChanged &&
      !websiteChanged;

  @override
  void initState() {
    restaurantNameController.text = widget.restaurant!.name;
    streetAddressController.text = widget.restaurant!.streetAddress;
    cityController.text = widget.restaurant!.city;
    stateController.text = widget.restaurant!.state;
    zipcodeController.text = widget.restaurant!.zipCode;
    phoneNumberController.text = widget.restaurant!.phoneNumber;
    descriptionController.text = widget.restaurant!.description ?? '';
    websiteController.text = widget.restaurant!.websiteUrl;
    veganStatus = widget.restaurant!.veganStatus;
    hasVeganOptions = widget.restaurant!.hasVeganOptions;
    takeout = widget.restaurant!.takeout;
    dineIn = widget.restaurant!.dineIn;
    delivery = widget.restaurant!.delivery;

    for (var dayIndex = 0;
        dayIndex < context.daysOfTheWeek.length;
        dayIndex++) {
      final periodItems = <PeriodItem>[
        PeriodItem(
          day: dayIndex,
          periods: const [],
          // widget.restaurant?.openHours.periods.where((period) => period.open.day == dayIndex).toList() ?? [],
          openTextEditingController: TextEditingController(),
          closeTextEditingController: TextEditingController(),
        ),
      ];
      openDaysList.add(OpenDayItem(periodItems: periodItems));
    }

    super.initState();
  }

  @override
  void dispose() {
    restaurantNameController.dispose();
    streetAddressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipcodeController.dispose();
    phoneNumberController.dispose();
    websiteController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> submitChanges(BuildContext context) async {
    final bloc = BlocProvider.of<RestaurantsCubit>(context);
    const openHours = OpenHoursModel.empty();
    final periods = <Period>[];
    if (openHoursChanged) {
      for (var d = 0; d < openDaysList.length; d++) {
        final openDay = openDaysList[d];
        for (var p = 0; p < openDaysList[d].periodItems.length; p++) {
          final dayIndex = openDay.periodItems[p].day;
          final openTime =
              openDay.periodItems[p].openTextEditingController.text;
          final closeTime =
              openDay.periodItems[p].closeTextEditingController.text;

          periods.add(
            PeriodModel(
              open: OpenCloseModel(
                day: dayIndex,
                time: openTime,
              ),
              close: OpenCloseModel(day: dayIndex, time: closeTime),
            ),
          );

          // openHours.periods.add(
          //   period.copyWith(
          //     open: OpenCloseModel(day: dayIndex, time: openTime),
          //     close: OpenCloseModel(day: dayIndex, time: closeTime),
          //   ),
          // );
        }
      }

      openHours.copyWith(periods: periods);
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.openHours,
        restaurantData: OpenHoursModel(periods: periods),
        restaurant: widget.restaurant!,
      );
    }

    if (imageChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.thumbnail,
        restaurantData: pickedImage,
        restaurant: widget.restaurant!,
      );
    }

    if (restaurantNameChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.name,
        restaurantData: restaurantNameController.text,
        restaurant: widget.restaurant!,
      );
    }

    if (streetAddressChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.streetAddress,
        restaurantData: streetAddressController.text,
        restaurant: widget.restaurant!,
      );
    }

    if (cityChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.city,
        restaurantData: cityController.text,
        restaurant: widget.restaurant!,
      );
    }

    if (stateChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.state,
        restaurantData: stateController.text,
        restaurant: widget.restaurant!,
      );
    }
    if (zipcodeChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.zipcode,
        restaurantData: zipcodeController.text,
        restaurant: widget.restaurant!,
      );
    }
    if (phoneNumberChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.phone,
        restaurantData: phoneNumberController.text,
        restaurant: widget.restaurant!,
      );
    }
    if (websiteChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.website,
        restaurantData: websiteController.text,
        restaurant: widget.restaurant!,
      );
    }
    if (descriptionChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.description,
        restaurantData: descriptionController.text,
        restaurant: widget.restaurant!,
      );
    }

    if (veganStatusChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.veganStatus,
        restaurantData: veganStatus,
        restaurant: widget.restaurant!,
      );
    }
    if (hasVeganOptionsChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.hasVeganOptions,
        restaurantData: hasVeganOptions,
        restaurant: widget.restaurant!,
      );
    }

    if (takeoutChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.takeout,
        restaurantData: takeout,
        restaurant: widget.restaurant!,
      );
    }

    if (dineInChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.dineIn,
        restaurantData: dineIn,
        restaurant: widget.restaurant!,
      );
    }

    if (deliveryChanged) {
      await bloc.updateRestaurant(
        action: UpdateRestaurantInfoAction.delivery,
        restaurantData: delivery,
        restaurant: widget.restaurant!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsCubit, RestaurantsState>(
      listener: (context, state) {
        if (state is RestaurantUpdated) {
          CoreUtils.showSnackBar(context, 'Restaurant Updated');
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
        } else if (state is RestaurantAdded) {
          CoreUtils.showSnackBar(context, 'Restaurant submitted');
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
        } else if (state is RestaurantsError) {
          CoreUtils.showSnackBar(context, state.message);
          if (state.message.contains('Restaurant has already been submitted') ||
              state.message.contains('Restaurant is already listed')) {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/'),
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            title: Text(context.currentUser?.isAdmin == true
                ? 'Edit'
                : 'Suggest an edit'),
            centerTitle: true,
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                shrinkWrap: true,
                children: [
                  Builder(
                    builder: (context) {
                      return Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(height: 25.h),
                          Container(
                            height: context.height * 0.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    fit: BoxFit.contain,
                                  )
                                : widget.restaurant?.thumbnail != null &&
                                        widget.restaurant!.thumbnail!.isNotEmpty
                                    ? Image.network(
                                        widget.restaurant!.thumbnail!,
                                        fit: BoxFit.contain,
                                      )
                                    : Icon(
                                        Icons.image_outlined,
                                        color: Colors.grey.shade500,
                                        size: 175,
                                      ),
                          ),
                          Positioned(
                            child: Container(
                              height: context.height * 0.2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                color: Colors.grey.shade600.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await showRestaurantThumbnailPickerOptions(
                                  context);
                            },
                            icon: Icon(
                              (pickedImage != null ||
                                      (widget.restaurant?.thumbnail != null &&
                                          widget.restaurant!.thumbnail!
                                              .isNotEmpty))
                                  ? Icons.edit
                                  : Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  UpdateRestaurantForm(
                    restaurantNameController: restaurantNameController,
                    streetAddressController: streetAddressController,
                    cityController: cityController,
                    stateController: stateController,
                    zipcodeController: zipcodeController,
                    phoneNumberController: phoneNumberController,
                    websiteController: websiteController,
                    descriptionController: descriptionController,
                    veganStatus: veganStatus,
                    hasVeganOptions: hasVeganOptions,
                    veganStatusExpansionController:
                        veganStatusExpansionController,
                    onChangedIsVeganYes: (bool? value) {
                      setState(() {
                        veganStatus = value;
                      });
                      if (veganStatus == true) {
                        veganStatusExpansionController.collapse();
                        hasVeganOptions = null;
                      }
                    },
                    onChangedIsVeganNo: (bool? value) {
                      setState(() {
                        veganStatus = value;
                      });
                      if (veganStatus == false) {
                        veganStatusExpansionController.expand();
                        hasVeganOptions = null;
                      }
                    },
                    onChangedHasVeganOptionsYes: (bool? value) {
                      setState(() {
                        hasVeganOptions = value;
                      });
                    },
                    onChangedHasVeganOptionsNo: (bool? value) {
                      setState(() {
                        hasVeganOptions = value;
                      });
                    },
                    adminList: [
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Takeout',
                          style: TextStyle(
                            color: context.theme.textTheme.bodyMedium?.color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: takeout,
                        onChanged: (bool? value) {
                          setState(() {
                            takeout = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'DineIn',
                          style: TextStyle(
                            color: context.theme.textTheme.bodyMedium?.color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: dineIn,
                        onChanged: (bool? value) {
                          setState(() {
                            dineIn = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Delivery',
                          style: TextStyle(
                            color: context.theme.textTheme.bodyMedium?.color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: delivery,
                        onChanged: (bool? value) {
                          setState(() {
                            delivery = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Theme(
                        data: context.theme
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          collapsedBackgroundColor:
                              context.theme.cardTheme.color,
                          iconColor: context.theme.iconTheme.color,
                          collapsedIconColor: context.theme.iconTheme.color,
                          title: Text(
                            'Open Hours',
                            style: TextStyle(
                              color: context.theme.textTheme.bodyMedium?.color,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: openDaysList.length,
                              itemBuilder: (context, index) {
                                final dayName = context.daysOfTheWeek[index];
                                final openDay = openDaysList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 25),
                                  child: Column(
                                    children: [
                                      OpenHourTile(
                                        title: dayName?.substring(0, 3) ?? '',
                                        value: openDay.isSelected ?? false,
                                        periodControllers: openDay.periodItems,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            openDay.isSelected = value;
                                          });
                                        },
                                        onAddButtonPressed: () {
                                          setState(() {
                                            final periodItem = PeriodItem(
                                              day: index,
                                              periods: const [],
                                              openTextEditingController:
                                                  TextEditingController(),
                                              closeTextEditingController:
                                                  TextEditingController(),
                                            );
                                            openDay.periodItems.add(
                                              periodItem,
                                            );
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      Divider(
                                        color: context.theme.iconTheme.color,
                                        height: 1,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  StatefulBuilder(
                    builder: (context, refresh) {
                      restaurantNameController
                          .addListener(() => refresh(() {}));
                      streetAddressController.addListener(() => refresh(() {}));
                      cityController.addListener(() => refresh(() {}));
                      stateController.addListener(() => refresh(() {}));
                      zipcodeController.addListener(() => refresh(() {}));
                      phoneNumberController.addListener(() => refresh(() {}));
                      websiteController.addListener(() => refresh(() {}));
                      descriptionController.addListener(() => refresh(() {}));
                      for (final openDay in openDaysList) {
                        for (final periodItem in openDay.periodItems) {
                          periodItem.openTextEditingController.addListener(
                            () => refresh(() {}),
                          );
                          periodItem.closeTextEditingController.addListener(
                            () => refresh(() {}),
                          );
                        }
                      }
                      return state is UpdatingRestaurant
                          ? const Center(child: CircularProgressIndicator())
                          : LongButton(
                              onPressed: nothingChanged
                                  ? null
                                  : () => submitChanges(context),
                              label: 'Submit',
                              backgroundColor: nothingChanged
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
