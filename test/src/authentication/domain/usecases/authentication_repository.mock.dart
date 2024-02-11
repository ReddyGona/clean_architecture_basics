// the class below extends from the Mock class and implements from the
// AuthenticationRepository class to create a Mock class named MockAuthRepository
// having the mock methods defined in the AuthenticationRepository class
import 'package:clean_architecture_basics/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository {}
