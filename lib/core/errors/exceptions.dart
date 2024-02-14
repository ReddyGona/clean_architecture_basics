import 'package:equatable/equatable.dart';

// The code below is used to create the various custom exceptions that we are
// going to throw if an api call fails in our app

// The class below extends from the Equatable class to check that if two
// ServerException objects are different or same

// the class below implements from the Exception class to create custom exception
class ApiException extends Equatable implements Exception {
  // The properties below is used to get the errorMessage and the status code
  // for the error
  final String message;
  final int statusCode;

  const ApiException({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
