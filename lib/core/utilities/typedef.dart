// this file contains all the custom types

// creating a type to get a Future Result
import 'package:clean_architecture_basics/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

// here T is the Custom type that we want to return to the user
typedef ResultFuture<T> = Future<Either<Failure, T>>;

// creating a type to either return Failure or void
typedef ResultVoid = ResultFuture<void>;

// creating a type for Map<String,dynamic>
typedef DataMap = Map<String, dynamic>;
