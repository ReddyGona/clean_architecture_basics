// ignore_for_file: public_member_api_docs, sort_constructors_first
// the code below will contain the use cases for only the create user part
import 'package:equatable/equatable.dart';

import 'package:clean_architecture_basics/core/usecase/usecase.dart';
import 'package:clean_architecture_basics/core/utilities/typedef.dart';
import 'package:clean_architecture_basics/src/authentication/domain/repositories/authentication_repository.dart';

// The class below extends from the UseCaseWithParams<void,CreateUserParams>
// class  because we want to pass parameters to our Use Case (in this case Create User)
// and the UseCaseWithParams class provide access to the call() method that takes
// instance of CreateUserParams class as input that contains the properties that
// we will pass to the createUser() method from the  AuthenticationRepository
// to add a new user
class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  // using dependency injection to create a private instance of AuthenticationRepository
  // to get access to the methods for the createUser use case
  final AuthenticationRepository _authenticationRepository;

  // passing the instance of AuthenticationRepository as input to get access
  // to its functionalities in this class
  const CreateUser(this._authenticationRepository);

  // overriding the call() method and passing the instance of CreateUserParams
  // class as input to create a new user
  @override
  ResultVoid call(CreateUserParams params) async =>
      _authenticationRepository.createUser(
          name: params.name,
          avatar: params.avatar,
          createdAt: params.createdAt);
}

// The class below contains the properties to get the parameters to add a new
// user

// the class below Extends the Equatable class to compare the objects of the
// CreateUserParams class based on the values of name, avatar, createdAt
class CreateUserParams extends Equatable {
  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserParams({
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  // The code below is used to create an empty constructor for the CreateUserParams
  // that will be used to provide the name, avatar and createdAt properties with
  // default values

  // The empty constructor below is useful in testing the CreateUser use case
  // using unit testing

  // NOTE: The empty constructor always have the name as empty as used below
  const CreateUserParams.empty()
      : this(
          createdAt: "_empty.createdAt",
          name: "_empty.name",
          avatar: "_empty.avatar",
        );

  @override
  List<Object?> get props => [name, avatar, createdAt];
}
