import 'package:clean_architecture_basics/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';
// creating a abstract class for the project to return the failures to the users

// using the Equatable class since we need to check that if one Failure
// object is similar to the other Failure object or not
abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  // The code below means that we will compare the objects of this Failure
  // class based on the message and the statusCode values and if both are
  // same for two different objects of this class that means that objects are
  // same else not
  @override
  List<Object> get props => [message, statusCode];
}

// creating a class that will be used by the app if there is some failure that
// we get from the api

// the class below extends from the Failure class so we need to pass
// the values of message and statusCode to the super constructor i.e. the
// constructor of the Failure class
class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  // creating a named constructor to get the message and status code from an
  // api exception
  ApiFailure.fromException(ApiException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
