import 'package:flutter/material.dart';
import 'package:whatsapp/screens/welcome_screen.dart';
import 'package:whatsapp/screens/login_screen.dart';
import 'package:whatsapp/screens/registration_screen.dart';
import 'package:whatsapp/screens/chat_screen.dart';

// import 'screens/chat_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/registration_screen.dart';
// import 'screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // theme: ThemeData.dark().copyWith(
        //   textTheme: TextTheme(
        //     body1: TextStyle(color: Colors.black54),
        //   ),
        // ),
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen()
        });
  }
}
