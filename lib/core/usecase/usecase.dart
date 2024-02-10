import 'package:clean_architecture_basics/core/utilities/typedef.dart';

// creating an abstact class UseCase<T> that has a signature of the method call()
// which whenever called on instance any class extending this class will perform
// the code written inside the method named call() of that class
abstract class UseCase<T> {
  ResultFuture<T> call();
}
