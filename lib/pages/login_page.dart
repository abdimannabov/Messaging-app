import 'package:flutter/material.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/components/text_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final void Function()? onTap;

  void login(){
    
  }

  LoginPage({super.key,
  required this.onTap});

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
                "Welcome back!",
                style: TextStyle(
                  color: Colors.deepPurple.shade200,
                  fontSize: 40,
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
              SizedBox(height: 20,),
              MyButton(text: "Login",
              onTap: login,),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register now!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
