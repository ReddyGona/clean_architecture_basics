import 'package:bloc/bloc.dart';
import 'package:clean_architecture_basics/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_basics/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture_basics/src/authentication/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

// The code below is used to create a cubit to add authentication business logic

// NOTE: A Cubit is a simplified version of the bloc

class AuthenticationCubit extends Cubit<AuthenticationState> {
  // The code below is used to create the instance of the CreateUser use-case and
  // getUsers useCase since our bloc depends on only these two use-cases
  final CreateUser _createUser;
  final GetUsers _getUsers;

  // passing the instance of CreateUser and GetUsers use case as input to the
  // constructor below to get access to the methods defined inside the
  // CreateUser and GetUsers use case using dependency injection
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser =
            createUser, // initializing the _createUser private variable
        _getUsers = getUsers, // initializing the _getUsers private variable
        super(AuthenticationInitial());

  // The code below is used to create a method to create a new user

  // the method takes name, avatar and createdAt of type string as input
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    // using the emit() method to emit the Loading state
    emit(const LoadingStateForCreatingUser());
    // Since we are already getting the name, avatar and createdAt details of the
    // user in the CreateUserEvent so we are using those details from the event
    // property of type CreateUserEvent
    CreateUserParams userDetails = CreateUserParams(
      name: name,
      avatar: avatar,
      createdAt: createdAt,
    );
    // since our CreateUser use case contains the call() method so we can use
    // the instance of the CreateUser class as a method so calling that method
    // to create a user and storing the result
    final result = await _createUser(userDetails);
    // using the fold() method from the result instance to get either Failure
    // if there is some failure while creating the user in the left value and
    // success response if the user is created successfully in the right value
    // of the fold() method as input
    result.fold((l) {
      // since l is for Failure so in case of Failure we are emitting the ErrorState
      // with message as input
      emit(ErrorState("${l.statusCode}\tError:${l.message}"));
    }, (r) {
      // emitting the UserCreatedSuccessfully() state since in case of right
      // there is success in creating the user
      emit(const UserCreatedSuccessfully());
    });
  }

  // The code below is used to create a method to get the list of the users
  Future<void> getUsersHandler() async {
    // using the emit() method to emit the loading state
    emit(const LoadingStateForGettingUsers());
    // since our GetUsers use case contains the call() method so we can use
    // the instance of the GetUsers class as a method so calling that method
    // to create a user and storing the result
    final result = await _getUsers();
    result.fold((failure) {
      // since l is for Failure so in case of Failure we are emitting the ErrorState
      // with message as input
      emit(ErrorState("${failure.statusCode}\tError:${failure.message}"));
    }, (users) {
      // using the emit() method to emit the UsersLoaded() state having list of
      // users as input
      emit(UsersLoaded(users));
    });
  }
}
