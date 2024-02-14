// The code below is used to test the functionality of the Authentication
// cubit

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_basics/core/errors/failure.dart';
import 'package:clean_architecture_basics/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture_basics/src/authentication/domain/usecases/get_users.dart';
import 'package:clean_architecture_basics/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Creating the Mock/Fake version of the CreateUser and GetUsers use case since
// our cubit has dependency on these

class MockCreateUserUseCase extends Mock implements CreateUser {}

class MockGetUsersUseCase extends Mock implements GetUsers {}

void main() {
  // creating an instance of GetUsers and CreateUser use case
  late CreateUser _createUser;
  late GetUsers _getUsers;
  late AuthenticationCubit _authCubit;

  // Creating an empty instance of createUserParams since we need to register
  // it as a fallback for createUser useCase
  const tCreateUserParam = CreateUserParams.empty();

  // instance to be used for testing ApiFailure case
  const tApiFailure = ApiFailure(message: "Error", statusCode: 400);

  // using the setUp() method to initialize the instances of CreateUser,GetUsers
  // and _authCubit
  setUp(() {
    _createUser = MockCreateUserUseCase();
    _getUsers = MockGetUsersUseCase();
    _authCubit = AuthenticationCubit(
      createUser: _createUser,
      getUsers: _getUsers,
    );
    registerFallbackValue(tCreateUserParam);
  });

  // using the test() method to test that the initial state of the block should
  // be AuthenticationInitial
  test("Initial state of the bloc should be [AuthenticationInitial]", () async {
    // using the expect() method and passing the _authCubit.state as first input
    // and instance of AuthenticationInitial as second input to check that the
    // initial state of the _auth cubit should be AuthenticationInitial
    expect(_authCubit.state, AuthenticationInitial());
  });

  // The code below is used to create a group to test the createUser useCase
  group("CreateUser", () {
    // using the blocTest() method to write a test for the bloc to createUser

    // NOTE: For both bloc and Cubit we use only bloc test

    // the blocTest() method takes the Cubit on which we are doing the test and
    // the state as two generic inputs
    blocTest<AuthenticationCubit, AuthenticationState>(
        "should emit [LoadingStateForCreatingUser,UserCreatedSuccessfully] state when successful",
        build: () {
          // using the when() bloc to create an assumption that whenever the createUser
          // use case is called then what should happen

          // passing any() as input to the createUser() use case and this any
          // will be replaced internally by the tCreateUserParam value that
          // we have registered using the registerFallbackValue() method inside
          // the setup() method
          when(() => _createUser(any()))
              .thenAnswer((_) async => const Right(null));
          return _authCubit; // we need to return this _authCubit since this will
          // used to build the rest of the functionality
        },
        // using the act property to actually mock the createUser use case using the
        // cubit to create the user
        act: (cubit) => cubit.createUser(
              name: tCreateUserParam.name,
              avatar: tCreateUserParam.avatar,
              createdAt: tCreateUserParam.createdAt,
            ),
        // using the expect property and passing the list of states that we expect
        // to be returned or emitted by the bloc if everything is successful
        expect: () => [
              const LoadingStateForCreatingUser(),
              const UserCreatedSuccessfully(),
            ],
        // using the verify property to confirm that actually the createUser use
        // case is called
        verify: (_) {
          verify(() => _createUser(tCreateUserParam)).called(1);
          verifyNoMoreInteractions(_createUser);
        });

    // The code below is used to create a test for the failure condition
    blocTest<AuthenticationCubit, AuthenticationState>(
        "should emit [LoadingStateForCreatingUser,ErrorState] state when unsuccessful",
        build: () {
          // using the when() bloc to create an assumption that whenever the createUser
          // use case is called then what should happen

          // passing any() as input to the createUser() use case and this any
          // will be replaced internally by the tCreateUserParam value that
          // we have registered using the registerFallbackValue() method inside
          // the setup() method
          when(() => _createUser(any())).thenAnswer(
            (_) async => const Left(tApiFailure),
          );
          return _authCubit;
        },
        // using the act property to actually mock the createUser use case using the
        // cubit to create the user
        act: (cubit) => cubit.createUser(
              name: tCreateUserParam.name,
              avatar: tCreateUserParam.avatar,
              createdAt: tCreateUserParam.createdAt,
            ),
        // using the expect property and passing the list of states that we expect
        // to be returned or emitted by the bloc if everything is successful
        expect: () => [
              const LoadingStateForCreatingUser(),
              ErrorState(
                  "${tApiFailure.statusCode}\tError:${tApiFailure.message}"),
            ],
        // using the verify property to confirm that actually the createUser use
        // case is called
        verify: (_) {
          verify(() => _createUser(tCreateUserParam)).called(1);
          verifyNoMoreInteractions(_createUser);
        });
  });

  // The code below is used to create a group using the group() method to test
  // the getUsers functionality
  group("getUsers", () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        "should emit [LoadingStateForGettingUser,UsersLoaded] state when successful",
        build: () {
          // using the when() bloc to create an assumption that whenever the createUser
          // use case is called then what should happen

          // passing any() as input to the createUser() use case and this any
          // will be replaced internally by the tCreateUserParam value that
          // we have registered using the registerFallbackValue() method inside
          // the setup() method
          when(() => _getUsers()).thenAnswer((_) async => const Right([]));
          return _authCubit; // we need to return this _authCubit since this will
          // used to build the rest of the functionality
        },
        // using the act property to actually mock the createUser use case using the
        // cubit to create the user
        act: (cubit) => cubit.getUsersHandler(),
        // using the expect property and passing the list of states that we expect
        // to be returned or emitted by the bloc if everything is successful
        expect: () => [
              const LoadingStateForGettingUsers(),
              const UsersLoaded([]),
            ],
        // using the verify property to confirm that actually the createUser use
        // case is called
        verify: (_) {
          verify(() => _getUsers()).called(1);
          verifyNoMoreInteractions(_getUsers);
        });

    // The code below is used to create a test for the failure condition
    blocTest<AuthenticationCubit, AuthenticationState>(
        "should emit [LoadingStateForGettingUser,ErrorState] state when unsuccessful",
        build: () {
          // using the when() bloc to create an assumption that whenever the createUser
          // use case is called then what should happen

          // passing any() as input to the createUser() use case and this any
          // will be replaced internally by the tCreateUserParam value that
          // we have registered using the registerFallbackValue() method inside
          // the setup() method
          when(() => _getUsers()).thenAnswer(
            (_) async => const Left(tApiFailure),
          );
          return _authCubit;
        },
        // using the act property to actually mock the createUser use case using the
        // cubit to create the user
        act: (cubit) => cubit.getUsersHandler(),
        // using the expect property and passing the list of states that we expect
        // to be returned or emitted by the bloc if everything is successful
        expect: () => [
              const LoadingStateForGettingUsers(),
              ErrorState(
                "${tApiFailure.statusCode}\tError:${tApiFailure.message}",
              ),
            ],
        // using the verify property to confirm that actually the createUser use
        // case is called
        verify: (_) {
          verify(() => _getUsers()).called(1);
          verifyNoMoreInteractions(_getUsers);
        });
  });

  // using the tearDown() method and passing the _authCubit.close() as input
  // to the anonymous method to destroy the instance of cubit after the test has
  // been done
  tearDown(() {
    _authCubit.close();
  });
}
