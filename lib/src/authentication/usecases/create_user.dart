// the code below will contain the use cases for only the create user part
import 'package:clean_architecture_basics/core/utilities/typedef.dart';
import 'package:clean_architecture_basics/src/authentication/repositories/authentication_repository.dart';

class CreateUser {
  // using dependency injection to create a private instance of AuthenticationRepository
  // to get access to the methods for the createUser use case
  final AuthenticationRepository _authenticationRepository;

  // passing the instance of AuthenticationRepository as input to get access
  // to its functionalities in this class
  const CreateUser(this._authenticationRepository);

  // method below is used to create a new user
  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async =>
      _authenticationRepository.createUser(
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      );
}
