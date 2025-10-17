import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../blocs/sign_in_bloc/sign_in_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(const SignOutRequired());
            },
            icon: Icon(Icons.login),
          ),
        ],
        ),
        body: Center(
          child: Text("Welcome to the Home Page!"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.1),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: GNav(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                duration: Duration(milliseconds: 400),
                gap: 8,
                iconSize: 32,
                backgroundColor: Colors.white,
                tabBackgroundColor: Colors.blue.shade100,
                padding: const EdgeInsets.all(10),
                tabs: [
                  GButton(
                    icon: Icons.contact_phone,
                    text: 'Contacts',
                    textColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.chat,
                    text: 'Chats',
                    textColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Settings',
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}