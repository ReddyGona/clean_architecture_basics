import 'package:clean_architecture_basics/core/services/injection_container.dart';
import 'package:clean_architecture_basics/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:clean_architecture_basics/src/authentication/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // calling the init() method to inject the dependencies whenever our application starts
  await init();
  runApp(const MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // NOTE: A bloc is always injected one level up i.e since we need the
  // AuthenticationBloc in the HomePage so we will use the Bloc Provider in the
  // main.dart here which is one level up the HomePage UI in the flutter widget
  // tree.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dummy TDD Project',
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          // using the sl service locator instance and passing the AuthenticatorBloc
          // as generic input to find / locate and inject the AuthenticationBloc here
          create: (context) => sl<AuthenticationBloc>(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
