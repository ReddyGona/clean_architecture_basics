import 'package:clean_architecture_basics/core/errors/exceptions.dart';
import 'package:clean_architecture_basics/core/errors/failure.dart';
import 'package:clean_architecture_basics/core/utilities/typedef.dart';
import 'package:clean_architecture_basics/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:clean_architecture_basics/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_basics/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

// The code below is used to create a service class that implements the methods
// defined in the AuthenticationRepository
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  // creating a private instance of the AuthenticationRemoteDataSource class
  // and passing it to the constructor to get access to the methods defined
  // inside the class using dependency injection
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  AuthenticationRepositoryImpl(this._authenticationRemoteDataSource);

  @override
  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    try {
      // calling the createUserAtRemote() method from the _authenticationRemoteDataSource
      // instance to create a user
      await _authenticationRemoteDataSource.createUserAtRemote(
          name: name, avatar: avatar, createdAt: createdAt);
      // returning the Right() instance with null as input
      return const Right(null);
    } on ApiException catch (e) {
      // using the catch() block and returning the Left() instance having ApiFailure
      // instance as input to return the error to the user
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      // the code below is to use the getUsersFromRemote() method from the
      // _authenticationRemoteDataSource instance to get the list of the users
      final result = await _authenticationRemoteDataSource.getUsersFromRemote();
      // using the Right() instance and passing the result as input to return
      // the list of users
      return Right(result);
    } on ApiException catch (e) {
      // using the catch() block and returning the Left() instance having ApiFailure
      // instance as input to return the error to the user
      return Left(ApiFailure.fromException(e));
    }
  }
}
