part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

// The code below is used to create a loading state that will be used to show
// the user that data is being loaded
class LoadingStateForCreatingUser extends AuthenticationState{
  const LoadingStateForCreatingUser();
}

// The code below is used to create a loading state for getting the list of users
class LoadingStateForGettingUsers extends AuthenticationState {
  const LoadingStateForGettingUsers();
}

// The code below is used to create a state for user created successfully
class UserCreatedSuccessfully extends AuthenticationState{
  const UserCreatedSuccessfully();
}

// The code below is used to create state to be emitted when we get the list
// of users
class UsersLoaded extends AuthenticationState {
  final List<User> users;

  const UsersLoaded(this.users);

  // the code below is to use the prop getter to equate the users that we are
  // getting based on the id of the user
  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

// The code below is used to create a state that will be used when we get some
// error
class ErrorState extends AuthenticationState {
  final String errorMessage;

  const ErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
