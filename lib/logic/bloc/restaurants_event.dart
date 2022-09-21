part of 'restaurants_bloc.dart';

abstract class RestaurantsEvent extends Equatable {
  const RestaurantsEvent();
}

class GetRestaurantsEvent extends RestaurantsEvent {
  final Position? position;
  GetRestaurantsEvent({this.position});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
