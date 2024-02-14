import 'package:clean_architecture_basics/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_basics/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:clean_architecture_basics/src/authentication/presentation/pages/widgets/add_user_dialog.dart';
import 'package:clean_architecture_basics/src/authentication/presentation/pages/widgets/loading_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _nameTextEditingController;

  // NOTE: The blockBuilder is used when we want to listen to the changes
  // and update UI accordingly and bloc listener is used when we just
  // need to listen to the changes and does not need to update the UI
  //
  // The Bloc cosumer consists of both BLoc builder and bloc listener
  //
  // Bloc listener can be used in cases when we need to show a snackbar
  // in case there is some error

  // method to get the list of users from the api
  void _getUsers() {
    context.read<AuthenticationBloc>().add(const GetUsersEvent());
  }

  Future<void> _floatingButtonPressed(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AddUserDialog(
          nameTextEditingController: _nameTextEditingController,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _nameTextEditingController = TextEditingController();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // if there is some error then showing the snackbar
        if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));

          // if the state is UserCreatedSuccessfully then again calling the
          // _getUsers() method to get the updated list of users
        } else if (state is UserCreatedSuccessfully) {
          _getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is LoadingStateForGettingUsers
              ? const LoadingColumn(message: "Getting users")
              : state is LoadingStateForCreatingUser
                  ? const LoadingColumn(message: "Creating User")
                  : state is UsersLoaded
                      ? Center(
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              User user = state.users[index];
                              return ListTile(
                                leading: Image.network(user.avatar),
                                title: Text(user.name),
                                subtitle: Text(user.createdAt),
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _floatingButtonPressed(context),
            icon: const Icon(Icons.add),
            label: const Text("Add User"),
          ),
        );
      },
    );
  }
}
