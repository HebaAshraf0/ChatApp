//import 'dart:html';

import 'package:chat_app/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegisterationScreen> {
   final _auth = FirebaseAuth.instance;
   late String email;
   late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              child: Image.asset('images/chat.png'),
            ),
            SizedBox(height: 50),
            TextField(
              onChanged: (value){
                email = value;

              },
              decoration: InputDecoration(
                hintText: 'Enter your E-mail',
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),

              ),
            ),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              onChanged: (value){
                password = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Password',
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),

              ),
            ),
            SizedBox(height: 12),
            MyButton(color: Colors.blue[800]!, title: 'Register', onPressed:() async{
             // print(email);
              // print(password);


             try{
               final newuser = await _auth.createUserWithEmailAndPassword(
                   email: email, password: password);
               Navigator.pushNamed(context, 'chat_screen');

             }
             catch(e){
               print(e);

             }

            }),
          ],
        ),
      ),

    );
  }
}
