import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/my_button.dart';
import '../components/text_field.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();
  final void Function()? onTap;

  Future<void> register(BuildContext context) async {
    final email = _emController.text.trim();
    final password = _pwController.text;
    final passwordConfirm = _pwConfirmController.text;

    if (email.isEmpty || password.isEmpty || passwordConfirm.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (password != passwordConfirm) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    try {
      final repo = FirebaseUserRepo();
      var myUser = const MyUser(userID: '', name: '', email: '');
      myUser = await repo.signUp(myUser.copyWith(email: email), password);
      await repo.setUserData(myUser);
      // On success, AuthenticationBloc or app logic should pick up auth change
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? e.code)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }

  RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/profile.png', height: 90),
              Text(
                "Let's create an account!",
                style: TextStyle(
                  color: Colors.deepPurple.shade200,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 20),
              BeautifulTextField(
                hintText: "E-mail",
                prefixIcon: Icons.email,
                controller: _emController,
              ),
              SizedBox(height: 20),
              BeautifulTextField(
                hintText: "Password",
                controller: _pwController,
                prefixIcon: Icons.lock,
                suffixIcon: Icons.visibility,
                obscureText: true,
              ),
              SizedBox(height: 20),
              BeautifulTextField(
                hintText: "Confirm password",
                controller: _pwConfirmController,
                prefixIcon: Icons.lock,
                suffixIcon: Icons.visibility,
                obscureText: true,
              ),
              SizedBox(height: 20),
              MyButton(text: "Register", onTap: () => register(context)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register now!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
