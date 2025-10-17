import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:message_app/pages/chats.dart';
import 'package:message_app/pages/contacts.dart';
import 'package:message_app/pages/settings.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
                        'Chatty',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )
                      ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [Contacts(), Chats(), Settings()],
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
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: GNav(
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                },
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
