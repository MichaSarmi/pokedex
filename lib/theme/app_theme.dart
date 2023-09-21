import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTheme {
  //colors
  //red
  static const Color red = Color(0xffE63F3C);
  static const Color redDark = Color(0xff99312F);
  //blue
  static const Color blue = Color(0xff6AB1E6);
  //gray
  static const Color grayUltraLigth = Color(0xffEFEFEF);
  static const Color grayLigth = Color(0xffF1F0F1);
  static const Color graySemiLigth = Color(0xff494949);
  static const Color graySemiDark = Color(0xff2D2D2D);
  static const Color grayDark = Color(0xff1C1C1C);
  //yellow
  static const Color yellow = Color(0xffFF9539);
  //green
  static const Color green = Color(0xff0AC57A);
  //general
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);

  //font weight
  static const FontWeight fontBold = FontWeight.bold;
  static const FontWeight fontSemiBold = FontWeight.w600;
  static const FontWeight fontMedium = FontWeight.w500;
  static const FontWeight fontRegular = FontWeight.w400;
  static const FontWeight fontLigth = FontWeight.w300;
  static const FontWeight fontExtraLigth = FontWeight.w200;
  //gradinet
  static LinearGradient gradienteLine = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [blue, white]);

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    //color primario
    primaryColor: red,
    //App bartheme
    appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: white.withOpacity(0.8)),
        titleTextStyle: GoogleFonts.poppins(
          color: white,
          fontSize: 16.sp,
          fontWeight: fontRegular,
        )),
    textSelectionTheme:
        const TextSelectionThemeData().copyWith(cursorColor: black),
    checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.all(grayDark),
        /*side: const BorderSide(
            color: thirdPrurple, //your desire colour here
            width: 1.5,
          ),*/
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
    canvasColor: white,
    shadowColor: Colors.transparent,
    scaffoldBackgroundColor: white,
    //font family
    textTheme: const TextTheme().copyWith(
      labelMedium: GoogleFonts.poppins(color: white),
      headline1: GoogleFonts.poppins(color: white),
      headline2: GoogleFonts.poppins(color: white),
      headline3: GoogleFonts.poppins(color: white),
      headline4: GoogleFonts.poppins(color: white),
      headline5: GoogleFonts.poppins(color: white),
      headline6: GoogleFonts.poppins(color: white),
      subtitle1: GoogleFonts.poppins(color: white),
      subtitle2: GoogleFonts.poppins(color: white),
      bodyText1: GoogleFonts.poppins(color: white),
      bodyText2: GoogleFonts.poppins(color: white),
      caption: GoogleFonts.poppins(color: white),
      overline: GoogleFonts.poppins(color: white),
      button: GoogleFonts.poppins(color: white),
    ),

    //text buton
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        // primary: primary,
        foregroundColor: graySemiDark,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.sp),
        ),
      ),
    ),

    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: red, elevation: 8),
    //Elevated Butons'
    elevatedButtonTheme: ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(shape: const StadiumBorder(), elevation: 0),
    ),
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    //input decoration
    inputDecorationTheme: InputDecorationTheme(
       filled: true,
      fillColor: grayUltraLigth,
      //text color
      labelStyle: GoogleFonts.poppins(color: black, fontSize: 16.sp),
      errorStyle: GoogleFonts.poppins(color: red, fontSize: 12.sp),
      //padding
      contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
      hintStyle: GoogleFonts.poppins(color: grayLigth, fontSize: 18.sp),
      //titulo
      floatingLabelStyle: const TextStyle(color: grayLigth),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      //borders
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: grayUltraLigth),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      //borde focus
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: grayUltraLigth),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      //error
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: red,
          )),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: red,
          )),
    ),
  );
}
