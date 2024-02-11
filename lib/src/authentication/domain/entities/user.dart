import 'package:equatable/equatable.dart';
// The code below is used to create the user entity

// using the equatable class to easily compare the objects for the class
// below without overriding the hashcode and operator method
class User extends Equatable {
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  // The code below is used to create an empty constructor for the User
  // that will be used to provide the name, avatar,id and createdAt properties with
  // default values

  // The empty constructor below is useful in testing the User entity
  // using unit testing

  // NOTE: The empty constructor always have the name as empty as used below
  const User.empty()
      : this(
          id: 1,
          createdAt: "_empty.createdAt",
          name: "_empty.name",
          avatar: "_empty.avatar",
        );

  // according to the code below we will comparing the instances of the
  // user class based on the value of the id and if the id is same but
  // any other field like createdAt,name and avatar are different then
  // also we will consider the objects as same objects.
  @override
  List<Object?> get props => [id];
}
