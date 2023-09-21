import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/screens/screens.dart';

class CheckAuthScreen extends StatelessWidget {
   
  const CheckAuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return const HomeScreen();
        }else{
          return const WelcomeScreen();
        }
        //todo retunr load screen
        
      },
    ),
      );
  }
}