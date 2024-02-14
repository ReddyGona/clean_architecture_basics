import 'dart:convert';

import 'package:clean_architecture_basics/core/utilities/typedef.dart';
import 'package:clean_architecture_basics/src/authentication/domain/entities/user.dart';

// creating a class to get the details of the user from the api endpoint

// The class below extends from the User class to get the properties for
// getting the details of the users

// NOTE: in Clean architecture an entity is a blue print and the Model is the extension of that Blueprint

// so in the code below User entity is a blueprint and UserModel is an
// extension of the User blueprint and we are extending the User entity
// using UserModel to add more functionality
class UserModel extends User {
  // creating an instance of the userModel class and passing the values
  // as required using the super keyword to pass the values to the constructor
  // of the User class this UserModel class extends from the user class
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  // creating a copyWith() method to update the details of the UserModel
  // since all the variables are final

  // The below method will update only that value whose new value is provided
  // other will have their previous values only since we are using this keyword
  UserModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  const UserModel.empty()
      : this(
          id: '1',
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  // creating a method to convert the json data to dart object

  // the fromMap() method takes data of type DataMap as input

  // using the this() method and passing the json as input to return
  // the instance of UserModel as output
  UserModel.fromMap(DataMap json)
      // the this keyword below is used to pass the data to the constructor
      // of the UserModel class which in turn using super keyword will pass
      // this data to the constructor of the user entity class
      : this(
          avatar: json['avatar'] as String,
          name: json['name'] as String,
          createdAt: json['createdAt'] as String,
          id: json['id'] as String,
        );

  // the method below is used to convert the data provided by a String source
  // i.e json into the Dart object

  // NOTE: The below method should be a factory method
  factory UserModel.fromJSON(String jsonData) =>
      UserModel.fromMap(jsonDecode(jsonData) as DataMap);

  // The code below is used to create a method to convert the Dart object
  // to json data
  DataMap toMap() => {
        "id": id,
        "avatar": avatar,
        "createdAt": createdAt,
        "name": name,
      };

  // The code below is used to create a method to convert the encode
  // the Map to json
  String toJSON() => jsonEncode(toMap());
}
