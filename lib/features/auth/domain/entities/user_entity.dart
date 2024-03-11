import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.bio,
  });

  const UserEntity.empty()
      : this(
          uid: '',
          name: '',
          email: '',
          photoUrl: '',
          bio: '',
        );
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String? bio;

  @override
  List<Object?> get props => [uid, email];

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, fullName: $name bio: $bio }';
  }
}
