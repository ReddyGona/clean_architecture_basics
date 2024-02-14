import 'package:clean_architecture_basics/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameTextEditingController;

  const AddUserDialog({super.key, required this.nameTextEditingController});

  void _createUserHandler(BuildContext context) {
    final name = nameTextEditingController.text.trim();
    // using the read<AuthenticationBloc>() method to call the add() method and
    // pass the CreateUserEvent() with name, avatar and createdAt value to add a
    // new user using authentication bloc.
    context.read<AuthenticationBloc>().add(CreateUserEvent(
          name: name,
          avatar:
              "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/679.jpg",
          createdAt: DateTime.now().toString(),
        ));
    // closing the popUp dialog
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameTextEditingController,
                decoration: const InputDecoration(labelText: "UserName"),
              ),
              ElevatedButton(
                onPressed: () => _createUserHandler(context),
                child: const Text("Create User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
