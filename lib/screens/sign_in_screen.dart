import 'package:chat_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
            MyButton(color: Colors.yellow[800]!, title: 'Sign In', onPressed: () async{
             try{
               final user = await _auth.signInWithEmailAndPassword(
                   email: email, password: password);
               if(user!= null){
                 Navigator.pushNamed(context, 'chat_screen');

               }
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
