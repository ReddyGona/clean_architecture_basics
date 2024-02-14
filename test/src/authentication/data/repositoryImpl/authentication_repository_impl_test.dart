import 'package:clean_architecture_basics/core/errors/exceptions.dart';
import 'package:clean_architecture_basics/core/errors/failure.dart';
import 'package:clean_architecture_basics/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:clean_architecture_basics/src/authentication/data/repositoryImpl/authentication_repository_impl.dart';
import 'package:clean_architecture_basics/src/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// creating a mock class for mocking / faking the instance of AuthenticationRemoteDataSource
// class to get access to the methods defined in the class for unit testing
class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  // creating an instance of AuthenticationRemoteDataSource
  late AuthenticationRemoteDataSource mockAuthRemoteDataSource;
  // creating an instance of AuthenticationRepositoryImpl
  late AuthenticationRepositoryImpl authenticationRepositoryImpl;

  // using the setup() method to create a new instance of MockAuthRemoteDataSource
  // everytime when we test the AuthenticationRemoteDataSource
  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authenticationRepositoryImpl =
        AuthenticationRepositoryImpl(mockAuthRemoteDataSource);
  });

  // using the group() method to create a group to test the createUser functionality
  group("createUser", () {
    const name = "whatever.name";
    const avatar = "whatever.avatar";
    const createdAt = "whatever.createdAt";

    // using the test method to create a test to check that the createUserAtRemote()
    // method is called successfully
    test(
        "should call the [RemoteDataSource.createUser] and complete successfully"
        "when the call to the remote source is successful", () async {
      when(() => mockAuthRemoteDataSource.createUserAtRemote(
            name: any(named: "name"),
            avatar: any(named: "avatar"),
            createdAt: any(named: "createdAt"),
          )).thenAnswer((invocation) => Future.value());

      final result = await authenticationRepositoryImpl.createUser(
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      );

      expect(result, equals(const Right(null)));

      // using the verify() method to check that the createUser() method from the
      // MockAuthRemoteDataSource is called with right data
      verify(() => mockAuthRemoteDataSource.createUserAtRemote(
            name: name,
            avatar: avatar,
            createdAt: createdAt,
          )).called(1);

      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });

    // using the test() method to write a unit test to check that there is a
    // server failure when the remote source is unsuccessful
    test(
        "should return a [ServerFailure] when the call to the remote source is unsuccessful",
        () async {
      // the code below is to use the when() and thenThrow() block to return
      // a failure when the server call fails
      when(() => mockAuthRemoteDataSource.createUserAtRemote(
            name: any(named: "name"),
            avatar: any(named: "avatar"),
            createdAt: any(named: "createdAt"),
          )).thenThrow(
        const ApiException(
          message: "Unknown error occurred",
          statusCode: 500,
        ),
      );

      final result = await authenticationRepositoryImpl.createUser(
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      );

      // Using the expect() to check that the value of result is same as the
      // value returned by the when() block
      expect(
        result,
        equals(
          const Left(
            ApiFailure(
              message: "Unknown error occurred",
              statusCode: 500,
            ),
          ),
        ),
      );
      //
      verify(() => mockAuthRemoteDataSource.createUserAtRemote(
            name: name,
            avatar: avatar,
            createdAt: createdAt,
          )).called(1);

      //
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });
  });

  // The code below is used to create a group to test the getUsers functionality
  group("getUsers", () {
    test(
        "should call the [RemoteDataSource.getUsers] and return [List<User>]"
        "when call to remote source is successful", () async {
      when(() => mockAuthRemoteDataSource.getUsersFromRemote())
          .thenAnswer((invocation) async => []);

      final result = await authenticationRepositoryImpl.getUsers();

      expect(result, isA<Right<dynamic, List<User>>>());

      verify(() => mockAuthRemoteDataSource.getUsersFromRemote()).called(1);

      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });

    test(
        "should return a [ApiFailure] when the call to the remote server is unsuccessful",
        () async {
      when(() => mockAuthRemoteDataSource.getUsersFromRemote()).thenThrow(
        const ApiException(
          message: "Unknown error occurred",
          statusCode: 500,
        ),
      );
      //
      final result = await authenticationRepositoryImpl.getUsers();

      expect(
        result,
        equals(
          const Left(
            ApiFailure(
              message: "Unknown error occurred",
              statusCode: 500,
            ),
          ),
        ),
      );
      //
      verify(() => mockAuthRemoteDataSource.getUsersFromRemote()).called(1);

      //
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });
  });
}
