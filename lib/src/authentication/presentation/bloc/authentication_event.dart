part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// creating an event to create a new user
class CreateUserEvent extends AuthenticationEvent {
  // creating the name, avatar and createdAt properties since we need these properties
  // to create a new user
  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserEvent({
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  @override
  List<Object> get props => [name, avatar, createdAt];
}

// the code below is used to create an event to get the list of users
class GetUsersEvent extends AuthenticationEvent {
  const GetUsersEvent();
}