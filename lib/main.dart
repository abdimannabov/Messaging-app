import 'package:flutter/material.dart';
import 'package:message_app/auth/login_or_register.dart';
import 'package:message_app/pages/login_page.dart';
import 'package:message_app/pages/register_page.dart';
import 'package:message_app/themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: LoginOrRegister(),
    );
  }
}
