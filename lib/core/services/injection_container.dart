// This file contains the code to inject the dependencies in the project using
// the get_it package
import 'package:clean_architecture_basics/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:clean_architecture_basics/src/authentication/data/dataSources/dataSourcesImpl/authentication_remote_data_source_impl.dart';
import 'package:clean_architecture_basics/src/authentication/data/repositoryImpl/authentication_repository_impl.dart';
import 'package:clean_architecture_basics/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_architecture_basics/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture_basics/src/authentication/domain/usecases/get_users.dart';
import 'package:clean_architecture_basics/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// The code below is to initialize the get_it service locator
final sl = GetIt.instance;

// The code below is used to create a method to initialize all the dependencies
// in the project
Future<void> init() async {
  // in the code below the dependency injection flow is working from top to bottom

  // // NOTE:
  // // The registerFactory() method from the sl instance is used to register the app
  // // logic or the base of the app and since the AuthenticationCubit is at the top
  // // so we will use registerFactory() method to initialize it
  //
  // // passing the sl() i.e service locator method as input to find and initialize
  // // the dependencies for the createUser and getUsers useCase
  // sl.registerFactory(() => AuthenticationCubit(createUser: sl(), getUsers: sl()));
  //
  // // The code below is to use the registerLazySingleton() method from the sl instance
  // // to register the dependencies for AuthenticationCubit
  // sl.registerLazySingleton(() => CreateUser(sl()));
  // sl.registerLazySingleton(() => GetUsers(sl()));

  // using the cascading operation to register the AuthenticationCubit and
  // its dependencies rather than calling sl again and again

  // Dependency for application logic
  sl
    ..registerFactory(
        () => AuthenticationCubit(createUser: sl(), getUsers: sl()))
    // Dependencies for Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    // Dependency for Repositories

    // NOTE: Abstract classes can't be instantiated

    // The below code tells that since AuthenticationRepository is an abstract
    // class so whenever we are looking for the AuthenticationRepository as a
    // dependency using the service locator so we will get the instance of
    // AuthenticationRepositoryImpl class that implements AuthenticationRepository
    // class

    // The below code means that now our domain layer is depending on the data
    // layer (since we need the AuthenticationRepository as dependency) without
    // actually depending on the data layer
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(sl()))
    // Dependency for Data Sources

    // now again since we have a contract or abstract class for the data source
    // i.e. AuthenticationRemoteDataSource abstract class so whenever the user
    // needs to find a dependency for the AuthenticationRemoteDataSource class
    // the service locator will give the AuthenticationRemoteDataSourceImpl class
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(sl()))
    // External dependencies

    // the code below is used to inject / provide the http.Client dependency
    ..registerLazySingleton(() => http.Client()); // this http.Client() here is
  // the final dependency which is required and since http.Client is also an
  // external dependency so we can initialize it here
}
