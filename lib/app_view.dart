import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/auth/login_or_register.dart';
import 'package:message_app/pages/home.dart';
import 'package:message_app/themes/light_mode.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/sign_in_bloc/sign_in_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      title: 'Firebase Auth',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                userRepository: context
                    .read<AuthenticationBloc>()
                    .userRepository,
              ),
              child: Home(),
            );
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}