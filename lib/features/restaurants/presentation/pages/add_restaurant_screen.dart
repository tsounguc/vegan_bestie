import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/app/providers/theme_inherited_widget.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/section_header.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_submit_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/add_restaurant_form.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/open_hour_tile.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({this.restaurant, super.key});

  final Restaurant? restaurant;

  static const String id = '/addRestaurantScreen';

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final TextEditingController restaurantNameController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ExpansionTileController veganStatusExpansionController = ExpansionTileController();
  bool? veganStatus;
  bool? hasVeganOptions;
  final List<OpenDayItem> openDaysList = [];

  final tddItems = [
    TakeoutDineInDeliveryItem(title: 'Take out'),
    TakeoutDineInDeliveryItem(title: 'Dine in'),
    TakeoutDineInDeliveryItem(title: 'Delivery'),
  ];

  bool get restaurantNameEntered => restaurantNameController.text.trim().isNotEmpty;

  bool get streetAddressEntered => streetAddressController.text.trim().isNotEmpty;

  bool get cityEntered => cityController.text.trim().isNotEmpty;

  bool get stateEntered => stateController.text.trim().isNotEmpty;

  bool get zipcodeEntered => zipcodeController.text.trim().isNotEmpty;

  bool get phoneNumberEntered => phoneNumberController.text.trim().isNotEmpty;

  bool get websiteEntered => websiteController.text.trim().isNotEmpty;

  bool get veganStatusSelected => veganStatus != null;

  bool get hasVeganOptionsSelected => hasVeganOptions != null;

  bool get canSubmit =>
      restaurantNameEntered &&
      streetAddressEntered &&
      cityEntered &&
      stateEntered
      // && zipcodeEntered &&
      // phoneNumberEntered &&
      // websiteEntered
      &&
      veganStatusSelected
      // && hasVeganOptionsSelected
      ;

  @override
  void initState() {
    restaurantNameController.text = widget.restaurant?.name ?? '';
    streetAddressController.text = widget.restaurant?.streetAddress ?? '';
    cityController.text = widget.restaurant?.city ?? '';
    stateController.text = widget.restaurant?.state ?? '';
    zipcodeController.text = widget.restaurant?.zipCode ?? '';
    phoneNumberController.text = widget.restaurant?.phoneNumber ?? '';
    websiteController.text = widget.restaurant?.websiteUrl ?? '';
    descriptionController.text = widget.restaurant?.description ?? '';
    veganStatus = widget.restaurant?.veganStatus;
    hasVeganOptions = widget.restaurant?.hasVeganOptions;

    for (var dayIndex = 0; dayIndex < context.daysOfTheWeek.length; dayIndex++) {
      final periodItems = <PeriodItem>[
        PeriodItem(
          day: dayIndex,
          periods: const [],
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

  void submitRestaurant(BuildContext context) {
    final bloc = BlocProvider.of<RestaurantsCubit>(context);
    final openHours = const OpenHoursModel.empty().copyWith(periods: []);

    for (var d = 0; d < openDaysList.length; d++) {
      final openDay = openDaysList[d];
      for (var p = 0; p < openDaysList[d].periodItems.length; p++) {
        const period = PeriodModel.empty();
        final dayIndex = openDay.periodItems[p].day;
        final openTime = openDay.periodItems[p].openTextEditingController.text;
        final closeTime = openDay.periodItems[p].closeTextEditingController.text;
        openHours.periods.add(
          period.copyWith(
            open: OpenCloseModel(day: dayIndex, time: openTime),
            close: OpenCloseModel(day: dayIndex, time: closeTime),
          ),
        );
      }
    }
    final restaurant = const RestaurantModel.empty().copyWith(
      name: restaurantNameController.text.trim(),
      nameLowercase: restaurantNameController.text.trim().toLowerCase(),
      streetAddress: streetAddressController.text.trim(),
      city: cityController.text.trim(),
      state: stateController.text.trim(),
      zipCode: zipcodeController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      websiteUrl: websiteController.text.trim(),
      description: descriptionController.text.trim(),
      veganStatus: veganStatus,
      hasVeganOptions: hasVeganOptions,
      openHours: openHours,
      takeout: tddItems[0].isSelected,
      dineIn: tddItems[1].isSelected,
      delivery: tddItems[2].isSelected,
    );
    if (context.currentUser?.isAdmin == true) {
      bloc.addRestaurant(
        restaurant,
      );
    } else {
      bloc.submitRestaurant(
        RestaurantSubmitModel.empty().copyWith(
          submittedRestaurant: restaurant,
          userId: context.currentUser?.uid,
          userName: context.currentUser?.name,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ThemeSwitcher.of(context)!;
    return BlocConsumer<RestaurantsCubit, RestaurantsState>(
      listener: (context, state) {
        if (state is RestaurantSubmitted) {
          CoreUtils.showSnackBar(context, 'Restaurant submitted');
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
          // backgroundColor: Colors.white,
          appBar: AppBar(
            // surfaceTintColor: Colors.white,
            leading: CustomBackButton(
              color: context.theme.iconTheme.color!,
            ),
            title: const Text(Strings.addBusinessText),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                shrinkWrap: true,
                children: [
                  AddRestaurantForm(
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
                    veganStatusExpansionController: veganStatusExpansionController,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SectionHeader(
                          sectionTitle: 'Take Out / Dine In / Delivery',
                          seeAll: false,
                          onSeeAll: () {},
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: tddItems.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              unselectedWidgetColor: true == themeMode.isDarkModeOn ? Colors.white : Colors.black,
                            ),
                            child: CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: context.theme.primaryColor,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                tddItems[index].title,
                                style: TextStyle(
                                  color: context.theme.textTheme.bodyMedium?.color,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: tddItems[index].isSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  tddItems[index].isSelected = value!;
                                });
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Theme(
                        data: context.theme.copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          collapsedBackgroundColor: context.theme.cardTheme.color,
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
                                        title: dayName!.substring(0, 3),
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
                                              openTextEditingController: TextEditingController(),
                                              closeTextEditingController: TextEditingController(),
                                            );
                                            openDay.periodItems.add(periodItem);
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
                      restaurantNameController.addListener(() => refresh(() {}));
                      streetAddressController.addListener(() => refresh(() {}));
                      cityController.addListener(() => refresh(() {}));
                      stateController.addListener(() => refresh(() {}));
                      zipcodeController.addListener(() => refresh(() {}));
                      phoneNumberController.addListener(() => refresh(() {}));
                      websiteController.addListener(() => refresh(() {}));
                      descriptionController.addListener(() => refresh(() {}));
                      return state is AddingRestaurant || state is SubmittingRestaurant
                          ? const Center(child: CircularProgressIndicator())
                          : LongButton(
                              onPressed: !canSubmit
                                  ? null
                                  : () => submitRestaurant(
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
class OpenDayItem extends Equatable {
  OpenDayItem({
    required this.periodItems,
    this.isSelected = false,
  });

  bool? isSelected;
  final List<PeriodItem> periodItems;

  @override
  List<Object?> get props => [isSelected, periodItems];
}

class PeriodItem extends Equatable {
  const PeriodItem({
    required this.periods,
    required this.openTextEditingController,
    required this.closeTextEditingController,
    required this.day,
  });

  final TextEditingController openTextEditingController;
  final TextEditingController closeTextEditingController;

  final List<Period> periods;
  final int day;

  @override
  List<Object?> get props => [openTextEditingController, closeTextEditingController, day, periods];
}

//ignore: must_be_immutable
class TakeoutDineInDeliveryItem extends Equatable {
  TakeoutDineInDeliveryItem({
    required this.title,
    this.isSelected = false,
  });

  final String title;
  bool isSelected;

  @override
  List<Object?> get props => [
        title,
        isSelected,
      ];
}
