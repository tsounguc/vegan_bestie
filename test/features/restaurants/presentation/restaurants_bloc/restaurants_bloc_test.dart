import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/add_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/add_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/delete_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/delete_restaurant_submission.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/edit_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_near_me.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_saved_restaurants.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_user_location.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/save_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/submit_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/unsave_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/update_restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class MockAddRestaurant extends Mock implements AddRestaurant {}

class MockUpdateRestaurant extends Mock implements UpdateRestaurant {}

class MockSubmitRestaurant extends Mock implements SubmitRestaurant {}

class MockGetRestaurantsNearMe extends Mock implements GetRestaurantsNearMe {}

class MockDeleteRestaurantSubmission extends Mock implements DeleteRestaurantSubmission {}

class MockAddRestaurantReview extends Mock implements AddRestaurantReview {}

class MockDeleteRestaurantReview extends Mock implements DeleteRestaurantReview {}

class MockEditRestaurantReview extends Mock implements EditRestaurantReview {}

class MockSaveRestaurant extends Mock implements SaveRestaurant {}

class MockGetSavedRestaurants extends Mock implements GetSavedRestaurants {}

class MockUnSaveRestaurant extends Mock implements UnSaveRestaurant {}

class MockGetUserLocation extends Mock implements GetUserLocation {}

void main() {
  late AddRestaurant addRestaurant;
  late UpdateRestaurant updateRestaurant;
  late SubmitRestaurant submitRestaurant;
  late DeleteRestaurantSubmission deleteRestaurantSubmission;
  late GetRestaurantsNearMe getRestaurantsNearMe;
  late AddRestaurantReview addRestaurantReview;
  late DeleteRestaurantReview deleteRestaurantReview;
  late EditRestaurantReview editRestaurantReview;
  late SaveRestaurant saveRestaurant;
  late UnSaveRestaurant unSaveRestaurant;
  late GetSavedRestaurants getSavedRestaurants;
  late RestaurantsCubit cubit;
  late GetRestaurantsNearMeParams testGetRestaurantsParams;
  late UpdateRestaurantParams testUpdateRestaurantParams;

  late RestaurantsFailure testRestaurantsFailure;
  late AddRestaurantReviewFailure testAddReviewFailure;
  late Restaurant testRestaurant;
  late RestaurantSubmit testRestaurantSubmit;
  late RestaurantReview testRestaurantReview;
  late List<String> testRestaurantsIdsList;

  setUp(() {
    addRestaurant = MockAddRestaurant();
    updateRestaurant = MockUpdateRestaurant();
    submitRestaurant = MockSubmitRestaurant();
    deleteRestaurantSubmission = MockDeleteRestaurantSubmission();
    getRestaurantsNearMe = MockGetRestaurantsNearMe();
    addRestaurantReview = MockAddRestaurantReview();
    deleteRestaurantReview = MockDeleteRestaurantReview();
    editRestaurantReview = MockEditRestaurantReview();
    saveRestaurant = MockSaveRestaurant();
    unSaveRestaurant = MockUnSaveRestaurant();
    getSavedRestaurants = MockGetSavedRestaurants();
    cubit = RestaurantsCubit(
      addRestaurant: addRestaurant,
      updateRestaurant: updateRestaurant,
      submitRestaurant: submitRestaurant,
      deleteRestaurantSubmission: deleteRestaurantSubmission,
      getRestaurantsNearMe: getRestaurantsNearMe,
      addRestaurantReview: addRestaurantReview,
      deleteRestaurantReview: deleteRestaurantReview,
      editRestaurantReview: editRestaurantReview,
      saveRestaurant: saveRestaurant,
      getSavedRestaurants: getSavedRestaurants,
      unSaveRestaurant: unSaveRestaurant,
    );
    testRestaurant = const Restaurant.empty();
    testRestaurantSubmit = RestaurantSubmit.empty();
    testRestaurantReview = RestaurantReview.empty();
    testGetRestaurantsParams = GetRestaurantsNearMeParams.empty();
    testUpdateRestaurantParams = UpdateRestaurantParams.empty();
    testRestaurantsIdsList = [testRestaurant.id];
    testRestaurantsFailure = RestaurantsFailure(
      message: 'message',
      statusCode: 400,
    );
    testAddReviewFailure = AddRestaurantReviewFailure(
      message: 'message',
      statusCode: '',
    );
    registerFallbackValue(testGetRestaurantsParams);
    registerFallbackValue(testUpdateRestaurantParams);
    registerFallbackValue(testRestaurant);
    registerFallbackValue(testRestaurantSubmit);
    registerFallbackValue(testRestaurantReview);
    registerFallbackValue(testRestaurantsIdsList);
  });

  tearDown(() => cubit.close());

  test(
      'given RestaurantsCubit '
      'when bloc is instantiated '
      'then initial state should be [RestaurantsInitial]', () async {
    // Arrange
    // Act
    // Assert
    expect(cubit.state, const RestaurantsInitial());
  });

  group('addRestaurant -', () {
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantsCubit '
      'when [RestaurantsCubit.addRestaurant] is called'
      ' and completed successfully '
      'then emit [AddingRestaurant, RestaurantsAdded]',
      build: () {
        when(() => addRestaurant(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.addRestaurant(testRestaurant),
      expect: () => [
        const AddingRestaurant(),
        const RestaurantAdded(),
      ],
      verify: (cubit) {
        verify(
          () => addRestaurant(testRestaurant),
        ).called(1);
        verifyNoMoreInteractions(addRestaurant);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantsCubit '
      'when [RestaurantsCubit.addRestaurant] is called and unsuccessful '
      'then emit [AddingRestaurant, RestaurantsError]',
      build: () {
        when(() => addRestaurant(any())).thenAnswer(
          (_) async => Left(testRestaurantsFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.addRestaurant(testRestaurant),
      expect: () => [
        const AddingRestaurant(),
        RestaurantsError(message: testRestaurantsFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(
          () => addRestaurant(testRestaurant),
        ).called(1);
        verifyNoMoreInteractions(addRestaurant);
      },
    );
  });

  group('updateRestaurant - ', () {
    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.updateRestaurant] is called '
        'and completed successfully '
        'then emit [UpdatingRestaurant, RestaurantUpdated]',
        build: () {
          when(() => updateRestaurant(any())).thenAnswer(
            (_) async => const Right(null),
          );
          return cubit;
        },
        act: (cubit) => cubit.updateRestaurant(
              action: testUpdateRestaurantParams.action,
              restaurantData: testUpdateRestaurantParams.restaurantData,
              restaurant: testUpdateRestaurantParams.restaurant,
            ),
        expect: () => [
              const UpdatingRestaurant(),
              const RestaurantUpdated(),
            ],
        verify: (cubit) {
          verify(
            () => updateRestaurant(testUpdateRestaurantParams),
          ).called(1);
          verifyNoMoreInteractions(updateRestaurant);
        });

    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.updateRestaurant] is called unsuccessfully '
        'then emit [UpdatingRestaurant, RestaurantsError]',
        build: () {
          when(() => updateRestaurant(any())).thenAnswer(
            (_) async => Left(testRestaurantsFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.updateRestaurant(
              action: testUpdateRestaurantParams.action,
              restaurantData: testUpdateRestaurantParams.restaurantData,
              restaurant: testUpdateRestaurantParams.restaurant,
            ),
        expect: () => [
              const UpdatingRestaurant(),
              RestaurantsError(message: testRestaurantsFailure.errorMessage),
            ],
        verify: (cubit) {
          verify(
            () => updateRestaurant(testUpdateRestaurantParams),
          ).called(1);
          verifyNoMoreInteractions(updateRestaurant);
        });
  });

  group('submitRestaurant - ', () {
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantCubit '
      'when [RestaurantsCubit.submitRestaurant] is called '
      'and completed successfully '
      'then emit [SubmittingRestaurant, RestaurantSubmitted]',
      build: () {
        when(() => submitRestaurant(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.submitRestaurant(testRestaurantSubmit),
      expect: () => [
        const SubmittingRestaurant(),
        const RestaurantSubmitted(),
      ],
      verify: (cubit) {
        verify(
          () => submitRestaurant(testRestaurantSubmit),
        ).called(1);
        verifyNoMoreInteractions(submitRestaurant);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.updateRestaurant] is called unsuccessfully '
        'then emit [UpdatingRestaurant, RestaurantsError]',
        build: () {
          when(() => submitRestaurant(any())).thenAnswer(
            (_) async => Left(testRestaurantsFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.submitRestaurant(testRestaurantSubmit),
        expect: () => [
              const SubmittingRestaurant(),
              RestaurantsError(message: testRestaurantsFailure.errorMessage),
            ],
        verify: (cubit) {
          verify(
            () => submitRestaurant(testRestaurantSubmit),
          ).called(1);
          verifyNoMoreInteractions(submitRestaurant);
        });
  });

  group('deleteRestaurantSubmission - ', () {
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantCubit '
      'when [RestaurantsCubit.deleteRestaurantSubmission] is called '
      'and completed successfully '
      'then emit [DeletingRestaurantSubmit, RestaurantSubmitDeleted]',
      build: () {
        when(() => deleteRestaurantSubmission(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.deleteRestaurantSubmission(testRestaurantSubmit),
      expect: () => [
        const DeletingRestaurantSubmit(),
        const RestaurantSubmitDeleted(),
      ],
      verify: (cubit) {
        verify(
          () => deleteRestaurantSubmission(testRestaurantSubmit),
        ).called(1);
        verifyNoMoreInteractions(deleteRestaurantSubmission);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.deleteRestaurantSubmission] is called unsuccessfully '
        'then emit [DeletingRestaurantSubmit, RestaurantsError]',
        build: () {
          when(() => deleteRestaurantSubmission(any())).thenAnswer(
            (_) async => Left(testRestaurantsFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.deleteRestaurantSubmission(testRestaurantSubmit),
        expect: () => [
              const DeletingRestaurantSubmit(),
              RestaurantsError(message: testRestaurantsFailure.errorMessage),
            ],
        verify: (cubit) {
          verify(
            () => deleteRestaurantSubmission(testRestaurantSubmit),
          ).called(1);
          verifyNoMoreInteractions(deleteRestaurantSubmission);
        });
  });

  group('getRestaurants -', () {
    final testRestaurants = <Restaurant>[];
    final testMarkers = <Marker>{};
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantsCubit '
      'when [RestaurantsCubit.getRestaurants] is called'
      ' and completed successfully '
      'then emit [LoadingRestaurants, RestaurantsLoaded]',
      build: () {
        when(() => getRestaurantsNearMe(any())).thenAnswer(
          (_) => Stream.value(Right(testRestaurants)),
        );
        return cubit;
      },
      act: (cubit) => cubit.getRestaurants(
        testGetRestaurantsParams.position,
        testGetRestaurantsParams.radius,
      ),
      expect: () => [
        const LoadingRestaurants(),
        RestaurantsLoaded(
          restaurants: testRestaurants,
          markers: testMarkers,
          hasReachedEnd: true,
        ),
      ],
      verify: (cubit) {
        verify(
          () => getRestaurantsNearMe(testGetRestaurantsParams),
        ).called(1);
        verifyNoMoreInteractions(getRestaurantsNearMe);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantsCubit '
      'when [RestaurantsCubit.getRestaurants] is called and unsuccessful '
      'then emit [LoadingRestaurants, RestaurantsError]',
      build: () {
        when(() => getRestaurantsNearMe(any())).thenAnswer(
          (_) => Stream.value(Left(testRestaurantsFailure)),
        );
        return cubit;
      },
      act: (cubit) => cubit.getRestaurants(
        testGetRestaurantsParams.position,
        testGetRestaurantsParams.radius,
      ),
      expect: () => [
        const LoadingRestaurants(),
        RestaurantsError(message: testRestaurantsFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(
          () => getRestaurantsNearMe(testGetRestaurantsParams),
        ).called(1);
        verifyNoMoreInteractions(getRestaurantsNearMe);
      },
    );
  });

  group('addRestaurantReview - ', () {
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantCubit '
      'when [RestaurantsCubit.addRestaurantReview] is called '
      'and completed successfully '
      'then emit [AddingRestaurantReview, RestaurantReviewAdded]',
      build: () {
        when(() => addRestaurantReview(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.addRestaurantReview(testRestaurantReview),
      expect: () => [
        const AddingRestaurantReview(),
        const RestaurantReviewAdded(),
      ],
      verify: (cubit) {
        verify(
          () => addRestaurantReview(testRestaurantReview),
        ).called(1);
        verifyNoMoreInteractions(addRestaurantReview);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.addRestaurantReview] is called unsuccessfully '
        'then emit [AddingRestaurantReview, RestaurantsError]',
        build: () {
          when(() => addRestaurantReview(any())).thenAnswer(
            (_) async => Left(testAddReviewFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.addRestaurantReview(testRestaurantReview),
        expect: () => [
              const AddingRestaurantReview(),
              RestaurantsError(message: testAddReviewFailure.message),
            ],
        verify: (cubit) {
          verify(
            () => addRestaurantReview(testRestaurantReview),
          ).called(1);
          verifyNoMoreInteractions(addRestaurantReview);
        });
  });

  group('deleteRestaurantReview - ', () {
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantCubit '
      'when [RestaurantsCubit.deleteRestaurantReview] is called '
      'and completed successfully '
      'then emit [DeletingRestaurantReview, RestaurantReviewDeleted]',
      build: () {
        when(() => deleteRestaurantReview(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.deleteReview(testRestaurantReview),
      expect: () => [
        const DeletingRestaurantReview(),
        const RestaurantReviewDeleted(),
      ],
      verify: (cubit) {
        verify(
          () => deleteRestaurantReview(testRestaurantReview),
        ).called(1);
        verifyNoMoreInteractions(deleteRestaurantReview);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.deleteRestaurantReview] is called unsuccessfully '
        'then emit [DeletingRestaurantReview, RestaurantsError]',
        build: () {
          when(() => deleteRestaurantReview(any())).thenAnswer(
            (_) async => Left(testRestaurantsFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.deleteReview(testRestaurantReview),
        expect: () => [
              const DeletingRestaurantReview(),
              RestaurantsError(message: testRestaurantsFailure.message),
            ],
        verify: (cubit) {
          verify(
            () => deleteRestaurantReview(testRestaurantReview),
          ).called(1);
          verifyNoMoreInteractions(deleteRestaurantReview);
        });
  });

  group('editRestaurantReview - ', () {
    final testReviewModel = RestaurantReviewModel.empty();
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantCubit '
      'when [RestaurantsCubit.editRestaurantReview] is called '
      'and completed successfully '
      'then emit [EditingRestaurantReview, RestaurantReviewEdited]',
      build: () {
        when(() => editRestaurantReview(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.editRestaurantReview(review: testReviewModel),
      expect: () => [
        const EditingRestaurantReview(),
        const RestaurantReviewEdited(),
      ],
      verify: (cubit) {
        verify(
          () => editRestaurantReview(testReviewModel),
        ).called(1);
        verifyNoMoreInteractions(editRestaurantReview);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.editRestaurantReview] is called unsuccessfully '
        'then emit [EditingRestaurantReview, RestaurantsError]',
        build: () {
          when(() => editRestaurantReview(any())).thenAnswer(
            (_) async => Left(testRestaurantsFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.editRestaurantReview(review: testReviewModel),
        expect: () => [
              const EditingRestaurantReview(),
              RestaurantsError(message: testRestaurantsFailure.message),
            ],
        verify: (cubit) {
          verify(
            () => editRestaurantReview(testReviewModel),
          ).called(1);
          verifyNoMoreInteractions(editRestaurantReview);
        });
  });

  group('saveRestaurant - ', () {
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantCubit '
      'when [RestaurantsCubit.saveRestaurant] is called '
      'and completed successfully '
      'then emit [SavingRestaurant, RestaurantSaved]',
      build: () {
        when(() => saveRestaurant(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.saveRestaurant(testRestaurant),
      expect: () => [
        const SavingRestaurant(),
        const RestaurantSaved(),
      ],
      verify: (cubit) {
        verify(
          () => saveRestaurant(testRestaurant.id),
        ).called(1);
        verifyNoMoreInteractions(saveRestaurant);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.saveRestaurant] is called unsuccessfully '
        'then emit [SavingRestaurant, RestaurantsError]',
        build: () {
          when(() => saveRestaurant(any())).thenAnswer(
            (_) async => Left(testRestaurantsFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.saveRestaurant(testRestaurant),
        expect: () => [
              const SavingRestaurant(),
              RestaurantsError(message: testRestaurantsFailure.message),
            ],
        verify: (cubit) {
          verify(
            () => saveRestaurant(testRestaurant.id),
          ).called(1);
          verifyNoMoreInteractions(saveRestaurant);
        });
  });

  group('unSaveRestaurant - ', () {
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantCubit '
      'when [RestaurantsCubit.unSaveRestaurant] is called '
      'and completed successfully '
      'then emit [UnSavingRestaurant, RestaurantUnSaved]',
      build: () {
        when(() => unSaveRestaurant(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.unSaveRestaurant(restaurant: testRestaurant),
      expect: () => [
        const UnSavingRestaurant(),
        const RestaurantUnSaved(),
      ],
      verify: (cubit) {
        verify(
          () => unSaveRestaurant(testRestaurant.id),
        ).called(1);
        verifyNoMoreInteractions(unSaveRestaurant);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.unSaveRestaurant] is called unsuccessfully '
        'then emit [UnSavingRestaurant, RestaurantsError]',
        build: () {
          when(() => unSaveRestaurant(any())).thenAnswer(
            (_) async => Left(testRestaurantsFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.unSaveRestaurant(restaurant: testRestaurant),
        expect: () => [
              const UnSavingRestaurant(),
              RestaurantsError(message: testRestaurantsFailure.message),
            ],
        verify: (cubit) {
          verify(
            () => unSaveRestaurant(testRestaurant.id),
          ).called(1);
          verifyNoMoreInteractions(unSaveRestaurant);
        });
  });

  group('getSavedRestaurants - ', () {
    final testSavedRestaurants = [Restaurant.empty()];
    blocTest<RestaurantsCubit, RestaurantsState>(
      'given RestaurantCubit '
      'when [RestaurantsCubit.getSavedRestaurants] is called '
      'and completed successfully '
      'then emit [FetchingSavedRestaurantsList, SavedRestaurantsListFetched]',
      build: () {
        when(() => getSavedRestaurants(any())).thenAnswer(
          (_) async => Right(testSavedRestaurants),
        );
        return cubit;
      },
      act: (cubit) => cubit.getSavedRestaurants(testRestaurantsIdsList),
      expect: () => [
        const FetchingSavedRestaurantsList(),
        SavedRestaurantsListFetched(savedRestaurantsList: testSavedRestaurants),
      ],
      verify: (cubit) {
        verify(
          () => getSavedRestaurants(testRestaurantsIdsList),
        ).called(1);
        verifyNoMoreInteractions(getSavedRestaurants);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
        'given RestaurantCubit '
        'when [RestaurantsCubit.unSaveRestaurant] is called unsuccessfully '
        'then emit [UnSavingRestaurant, RestaurantsError]',
        build: () {
          when(() => getSavedRestaurants(any())).thenAnswer(
            (_) async => Left(testRestaurantsFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.getSavedRestaurants(testRestaurantsIdsList),
        expect: () => [
              const FetchingSavedRestaurantsList(),
              RestaurantsError(message: testRestaurantsFailure.message),
            ],
        verify: (cubit) {
          verify(
            () => getSavedRestaurants(testRestaurantsIdsList),
          ).called(1);
          verifyNoMoreInteractions(getSavedRestaurants);
        });
  });
}
