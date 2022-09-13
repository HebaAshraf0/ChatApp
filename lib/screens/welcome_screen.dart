import 'package:chat_app/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
           Column(
             children: [
               Container(
                 child: Image.asset('images/chat.png'),
                 height: 180,

               ),
               Text(
                 "Let's Chat...!",
                 style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900,color: Colors.indigo),
               ),
             ],
           ),
            SizedBox(height: 30),
           MyButton(
             color: Colors.yellow[900]!,
             title: 'Sign in',
             onPressed: () {
               Navigator.pushNamed(context,'sign_in_screen')
                   ;
             },
           ),
            MyButton(
              color: Colors.blue[900]!,
              title: 'Register',
              onPressed: () {
                Navigator.pushNamed(context,'register_screen')
                    ;

              },
            ),
          ],
        ),

      ),
    );
  }
}
