import 'package:clean_architecture_basics/src/authentication/data/models/user_model.dart';

// NOTE:
// in dataSources we do not use the entities rather we use the models

// The code below is used to create the signatures of the method that will
// actually talk to the deployed server to get the details based on the
// request made by the user

// The code below is used to create an abstract class that will contain the
// signatures of the method that will talk to the server to get the data
abstract class AuthenticationRemoteDataSource {
  // The code below is used to create the signature of the method to create
  // the user
  Future<void> createUserAtRemote({
    required String name,
    required String avatar,
    required String createdAt,
  });

  // The code below is used to create the signature of the method to get the
  // users
  Future<List<UserModel>> getUsersFromRemote();
}

