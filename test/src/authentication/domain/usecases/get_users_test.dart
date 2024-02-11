// the code below is used to write the test cases for the create_user use case
// in the authentication feature

// Three questions to consider when testing a unit/class
// 1. What are the dependencies on which the class that we are going to test dependes on?
//    i.e. what are the things that we need to provide as input to the constructor
//    of the class.
// 2. How can we make the fake version of the dependency on which the class that
//    we are going to test depends?
// 3. How do we control what our dependencies do?

// The code below is to use the Mocktail package to create a mock instance
// of the AuthenticationRepository for testing the create_user use case
import 'package:clean_architecture_basics/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_basics/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_architecture_basics/src/authentication/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

// creating the main() method that will be the entery method for testing this file
void main() {
  // creating a late instance of the CreateUser use case
  late GetUsers getUsers;

  // creating an instance of the AuthenticationRepository for testing the create
  // user use case
  late AuthenticationRepository authRepo;

  // using the setup() method to instantiate the instance of CreateUser before
  // using it for testing the CreateUser use case

  // The setup method below is used to create a new instance of the CreateUser
  // instance for each test case individually
  setUp(() {
    // initializing the authRepo instance using the instance of MockAuthRepository
    // since in testing we use the Mock / fake version of dependencies and not the
    // real version
    authRepo = MockAuthRepository();
    // initializing the instance of CreateUser use case and passing the authRepo
    // instance as input
    getUsers = GetUsers(authRepo);
  });

  // creating an empty instance of User and passing it to a list to return
  // a list of type List<User>
  const tResponse = [User.empty()];

  // using the test() method from the flutter_test package to create a test
  // method to test the create user use case

  // The test method takes the description of the test as first input and
  // anonymous callback having the test that we need to perform as the second
  // input
  test(
      "should call the [AuthenticationRepository.getUsers] and returns [List<User>]",
      () async {
    // The code below is to use the when().thenAnswer() callback to return a
    // instance of Right() having null as input on successful execution of the code
    // below when the when() method calls the createUser() method from authRepo instance
    when(() =>
        // calling the createUser() method from the authRepo instance and passing
        // dummy data using the any() method

        // passing the string as the value to the named property inside the any()
        // method to give a name to the value returned by any() method
        authRepo.getUsers()).thenAnswer((_) async {
      return const Right(tResponse);
    });

    // since we have the call() method inside the CreateUser class so we can use
    // the instance of the CreateUser class i.e. createUser as a function like
    // createUser() and pass the value of params as input
    final result = await getUsers();

    // using the expect() method to check if the value of result is equal to what
    // we expect in the second input that we pass to expect() method or not
    expect(result, const Right<dynamic, List<User>>(tResponse));

    // using the verify() method to see that we actually get the correct result
    // when we called the createUser() method from authRepo instance or not
    verify(() => authRepo.getUsers())
        .called(1); // here the called(1) means that we are verifying that
    // the createUser() method is called exactly 1 time not more than that

    // calling the verifyNoMoreInteractions() method and passing the authRepo
    // instance to verify that after the above testing we are not calling any
    // methods from the authRepo instance
    verifyNoMoreInteractions(authRepo);
  });
}
