import 'package:clean_architecture_basics/core/utilities/typedef.dart';

// creating an abstact class UseCase<T> that has a signature of the method call()
// which whenever called on instance any class extending this class will perform
// the code written inside the method named call() of that class

// the usecase class below will be used in the case where we have a method
// in the class that accepts some parameters
abstract class UseCaseWithParams<ReturnType, Parameters> {
  const UseCaseWithParams();

  ResultFuture<ReturnType> call(Parameters params);
}

// the usecase class below will be used in the case where the methods in
// the class do not accept parameters
abstract class UseCaseWithoutParams<ReturnType> {
  const UseCaseWithoutParams();
  
  ResultFuture<ReturnType> call();
}
