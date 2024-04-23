import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.bio,
    this.savedProductsBarcodes,
    this.savedRestaurantsIds,
  });

  const UserEntity.empty()
      : this(
          uid: '',
          name: '',
          email: '',
          photoUrl: '',
          bio: '',
          savedProductsBarcodes: const [],
          savedRestaurantsIds: const [],
        );
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String? bio;
  final List<String>? savedProductsBarcodes;
  final List<String>? savedRestaurantsIds;

  bool get isAdmin => email == 'christiantsoungui@gmail.com';

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        photoUrl,
        bio,
        savedProductsBarcodes,
        savedRestaurantsIds,
      ];

  @override
  String toString() {
    return 'LocalUser{ uid: $uid, email: $email, fullName: $name '
        'bio: $bio savedFoodProduct: $savedProductsBarcodes '
        'savedRestaurants: $savedRestaurantsIds }';
  }
}
