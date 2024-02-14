import 'dart:convert';

import 'package:clean_architecture_basics/core/errors/exceptions.dart';
import 'package:clean_architecture_basics/core/utilities/constants/network_constants.dart';
import 'package:clean_architecture_basics/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:clean_architecture_basics/src/authentication/data/dataSources/dataSourcesImpl/authentication_remote_data_source_impl.dart';
import 'package:clean_architecture_basics/src/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

// the code below is used to create a mock class to mock / fake the http.Client
// functionality
class MockHttpClient extends Mock implements http.Client {}

void main() {
  // creating an instance of the http.Client
  late http.Client client;

  // since our AuthenticationRemoteDataSourceImpl class implements the
  // AuthenticationRemoteDataSource so we can create an instance of the
  // AuthenticationRemoteDataSource class and initialize it with the instance
  // of AuthenticationRemoteDataSourceImpl class
  late AuthenticationRemoteDataSource authenticationRemoteDataSourceImpl;

  // using the setup method to initialize the http client instance and the
  // authenticationRemoteDataSourceImpl instance
  setUp(() {
    client = MockHttpClient();
    authenticationRemoteDataSourceImpl =
        AuthenticationRemoteDataSourceImpl(client);
    // using the registerFallbackValue() method and passing Uri() instance as
    // input to create a Uri for passing it to the http methods
    registerFallbackValue(Uri());
  });

  // using the group() method to create a group to test the createUser functionality

  // a group can contain another group inside it
  group("createUser", () {
    test("should complete successfully when the status code is 200 or 201",
        () async {
      // using the when() and thenAnswer() to create a assumption that when
      // ever we create a post request then it should give us a 201 status code

      // passing the any() as first input to the post() method to mock / fake
      // any url that we will pass to the post() method and passing any(named: "body")
      // as input to the body property to pass any body to the post method
      when(() => client.post(any(), body: any(named: "body"))).thenAnswer(
          (_) async => http.Response('User Created Successfully', 201));
      // the code below is used to register createUserAtRemote method from the mock
      // instance to create the user
      final methodCall = authenticationRemoteDataSourceImpl.createUserAtRemote;
      // using the expect() method and passing the methodCall() method as input
      // with the data (since the createUserAtRemote() method does not return anything)
      // to create a user and passing completes as second input
      // to check that the methodCall() method actually completes its execution
      expect(
          methodCall(
            name: "name",
            avatar: "avatar",
            createdAt: "createdAt",
          ),
          completes);

      // verifying that actually the createUserAtRemote() method is called
      verify(() => client.post(Uri.parse(NetworkConstants.kCreateUsersEndpoint),
          body: jsonEncode(
            {
              "name": "name",
              "avatar": "avatar",
              "createdAt": "createdAt",
            },
          ))).called(1);

      verifyNoMoreInteractions(client);
    });

    test("Should throw [ApiException] when the status code is not 200 or 201",
        () async {
      when(() => client.post(any(), body: any(named: "body")))
          .thenAnswer((_) async => http.Response(
                'Invalid details',
                400,
              ));
      // the code below is used to register createUserAtRemote method from the mock
      // instance to create the user
      final methodCall = authenticationRemoteDataSourceImpl.createUserAtRemote;
      // using the expect() method and passing the methodCall() method as input
      // with the data (since the createUserAtRemote() method does not return anything)
      // to create a user and passing completes as second input
      // to check that the methodCall() method actually completes its execution
      expect(
          () async => methodCall(
                name: "name",
                avatar: "avatar",
                createdAt: "createdAt",
              ),
          throwsA(
              const ApiException(message: 'Invalid details', statusCode: 400)));

      // verifying that actually the createUserAtRemote() method is called
      verify(() => client.post(Uri.parse(NetworkConstants.kCreateUsersEndpoint),
          body: jsonEncode(
            {
              "name": "name",
              "avatar": "avatar",
              "createdAt": "createdAt",
            },
          ))).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group("getUsers", () {
    final tUsers = [const UserModel.empty()];
    test("should return List<User> when the status code is 200", () async {
      // using the when() and thenAnswer() to create a assumption that when
      // ever we create a post request then it should give us a 201 status code

      // passing the any() as first input to the post() method to mock / fake
      // any url that we will pass to the post() method and passing any(named: "body")
      // as input to the body property to pass any body to the post method
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200));
      // the code below is used to register createUserAtRemote method from the mock
      // instance to create the user
      final result =
          await authenticationRemoteDataSourceImpl.getUsersFromRemote();
      // using the expect() method and passing the methodCall() method as input
      // with the data (since the createUserAtRemote() method does not return anything)
      // to create a user and passing completes as second input
      // to check that the methodCall() method actually completes its execution

      expect(result, equals(tUsers));
      // verifying that actually the createUserAtRemote() method is called
      verify(() => client.get(Uri.parse(NetworkConstants.kGetUsersEndpoint)))
          .called(1);

      verifyNoMoreInteractions(client);
    });

    test("Should throw [ApiException] when the status code is not 200",
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response("Server down", 500));

      // the code below is used to register createUserAtRemote method from the mock
      // instance to create the user
      final methodCall = authenticationRemoteDataSourceImpl.getUsersFromRemote;
      // using the expect() method and passing the methodCall() method as input
      // with the data (since the createUserAtRemote() method does not return anything)
      // to create a user and passing completes as second input
      // to check that the methodCall() method actually completes its execution
      expect(
        ()  => methodCall(),
        throwsA(const ApiException(message: "Server down", statusCode: 500)),
      );

      // verifying that actually the createUserAtRemote() method is called
      verify(() => client.get(
            Uri.parse(NetworkConstants.kGetUsersEndpoint),
          )).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
