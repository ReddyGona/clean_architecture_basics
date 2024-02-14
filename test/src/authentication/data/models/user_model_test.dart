import 'dart:convert';

import 'package:clean_architecture_basics/core/utilities/typedef.dart';
import 'package:clean_architecture_basics/src/authentication/data/models/user_model.dart';
import 'package:clean_architecture_basics/src/authentication/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // NOTE:
  // for testing a model first test should always be to check that the
  // model is a subclass of the entity class

  // creating an empty constructor of UserModel
  const tModel = UserModel.empty();

  test("should be a sub class of [User] entity", () {
    // using the expect() method and isA<User>() method to check that if the
    // tModel is equal to  / instance of / sub class of User entity
    expect(tModel, isA<User>());
  });

  // getting the user json data from the user.json file
  final tUserJson = fixture("user.json");
  // getting the Map from the json that we have in the tUserJson variable
  final tUserMap = jsonDecode(tUserJson) as DataMap;

  // using the group() method to combine the tests for the fromMap() method
  // in the userModel class
  group("fromMap", () {
    test("should return a [UserModel] with the correct data", () {
      // printing the value of tUserJson to the console
      debugPrint(tUserJson);
      // The code below is used to generate a dart object from the tUserMap
      final result = UserModel.fromMap(tUserMap);
      // using the expect() method and equals(tModel) to check if the value
      // of result is equal to tModel or not
      expect(result, equals(tModel));
    });
  });

  // using the group() method to combine the tests for the fromJson() method
  // in the UserModel class
  group("fromJSON", () {
    // using the test() method to create a test to check the functionality of
    // the fromJson() method
    test("should return a [UserModel] with the correct data", () {
      // printing the value of tUserJson to the console
      debugPrint(tUserJson);
      // The code below is used to generate a dart object from the tUserMap
      final result = UserModel.fromJSON(tUserJson);
      // using the expect() method and equals(tModel) to check if the value
      // of result is equal to tModel or not
      expect(result, equals(tModel));
    });
  });

  // using the group() method to combine the tests for the fromMap() method
  // in the UserModel class
  group("toMap", () {
    // using the test() method to create a test to check the functionality of
    // the fromJson() method
    test("should return a [Map] with the correct data", () {
      // The code below is used to generate a dart object from the tUserMap
      final result = tModel.toMap();
      // using the expect() method and equals(tModel) to check if the value
      // of result is equal to tModel or not
      expect(result, equals(tUserMap));
    });
  });

  // using the group() method to combine the tests for the fromMap() method
  // in the UserModel class
  group("toJSON", () {
    // using the test() method to create a test to check the functionality of
    // the fromJson() method
    test("should return a [JSON] with the correct data", () {
      // The code below is used to generate a dart object from the tUserMap
      final result = tModel.toJSON();
      final testJSON = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });
      // using the expect() method and equals(tModel) to check if the value
      // of result is equal to tModel or not
      expect(result, equals(testJSON));
    });
  });

  // using the group() method to combine the tests for the fromMap() method
  // in the UserModel class
  group("copyWith", () {
    // using the test() method to create a test to check the functionality of
    // the fromJson() method
    test("should return a [UserModel] with the different data", () {
      final result = tModel.copyWith(name: "Paul");
      expect(result.name, equals("Paul"));
    });
  });
}
