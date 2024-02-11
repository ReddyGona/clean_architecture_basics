import 'package:clean_architecture_basics/core/utilities/typedef.dart';
import 'package:clean_architecture_basics/src/authentication/domain/entities/user.dart';

// the class below is used to create a repository class for authenticating
// the user the below class will act as a blueprint for creating the methods
// that we will use to authenticate the user

// the abstract class below will just contain the signature of the methods
// that we will use to authenticate the user
abstract class AuthenticationRepository {
  const AuthenticationRepository();

  // signature of the method below is used to create a user

  // The class below either returns an instance of the Failure class if there
  // is a Failure or exception or it returns a void if the operation
  // is successful

  // In the code below we are returning the Failure instance in case of failure
  // rather then apiFailure because according to the SRP principle we should
  // not depend on the implementation

  // if we specify the actual failure as a return type below then in future if
  // we change the Failure type then we will have to change that everywhere

  // The below code is based on loose coupling principle
  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  // signature of method to get list of users
  ResultFuture<List<User>> getUsers();
}
