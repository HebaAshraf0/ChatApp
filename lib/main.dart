import 'package:chat_app/screens/chatt_screen.dart';
import 'package:chat_app/screens/registeration_screen.dart';
import 'package:chat_app/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat me',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //home: ChatScreen(),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen':(context)=> WelcomeScreen(),
        'sign_in_screen':(context)=> SignInScreen(),
        'register_screen':(context)=> RegisterationScreen(),
        'chat_screen':(context)=> ChatScreen(),
      },
    );
  }
}
