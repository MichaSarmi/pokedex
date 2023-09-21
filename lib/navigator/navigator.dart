import 'package:flutter/material.dart';
/**
 * Animacion de izqueirda a derecha para abir pantallas
 */
Route createRoute({required Widget page}){
          return PageRouteBuilder(
            pageBuilder:(context, animation, secondaryAnimation)=>  page,
            transitionDuration:const  Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final curveAnimation= CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween<Offset>(begin:const Offset(1,0.0) ,end: Offset.zero ).animate(curveAnimation),
                child: child,
                );    
            },


          );
          
      }