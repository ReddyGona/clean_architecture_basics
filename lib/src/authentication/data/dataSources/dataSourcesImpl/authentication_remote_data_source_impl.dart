import 'dart:convert';

import 'package:clean_architecture_basics/core/errors/exceptions.dart';
import 'package:clean_architecture_basics/core/utilities/constants/network_constants.dart';
import 'package:clean_architecture_basics/core/utilities/typedef.dart';
import 'package:clean_architecture_basics/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:clean_architecture_basics/src/authentication/data/models/user_model.dart';

import 'package:http/http.dart' as http;

// The code below is used to create a class to do the CRUD operations with the api
// to get the data from the server
class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  // creating an instance of http.Client and passing it as input to the constructor
  // to get access to the http client using dependency injection
  final http.Client _client;

  AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<void> createUserAtRemote({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    try {
      // using the post() method from the client instance to create the user
      final response = await _client.post(
        Uri.parse(NetworkConstants.kCreateUsersEndpoint),
        body: jsonEncode({
          "name": name,
          "avatar": avatar,
          "createdAt": createdAt,
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<UserModel>> getUsersFromRemote() async {
    try {
      final response =
          await _client.get(Uri.parse(NetworkConstants.kGetUsersEndpoint));
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(jsonDecode(response.body) as List).map((data) {
        return UserModel.fromMap(data);
      }).toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
