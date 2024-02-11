import 'package:clean_architecture_basics/core/usecase/usecase.dart';
import 'package:clean_architecture_basics/core/utilities/typedef.dart';
import 'package:clean_architecture_basics/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_basics/src/authentication/domain/repositories/authentication_repository.dart';

// The class below is for the usecase to get the list of the users

// the class below extends from the UseCaseWithoutParams<List<User>> to get access
// to the call() method to call the method to get the list of users from the
// AuthenticationRepository instance

// in the class UseCaseWithoutParams<List<User>> <List<User>>  means that this
//Usecase will return a List<User> type result
class GetUsers extends UseCaseWithoutParams<List<User>> {
  // creating a private final instance of the AuthenticationRepository and
  // passing it to the constructor of GetUsers to get access to methods defined
  // in the AuthenticationRepository class using dependency injection
  final AuthenticationRepository _authenticationRepository;

  GetUsers(this._authenticationRepository);

  // overriding the call() method and returning _authenticationRepository.getUsers()
  // to return the list of the users
  @override
  ResultFuture<List<User>> call() => _authenticationRepository.getUsers();
}
