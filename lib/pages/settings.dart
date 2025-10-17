import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/sign_in_bloc/sign_in_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Settings Page"),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<SignInBloc>().add(const SignOutRequired());
                }, 
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
              )
            ],
          ),
        ),
      ),
    );
  }
}