import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../navigator/navigator.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: AppTheme.gradienteLine),
            width: Adaptive.w(100),
            height: Adaptive.h(100),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: Adaptive.h(100),
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 32.sp),
                      child: Column(
                        children: [
                          Text('Welcome to',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontWeight: AppTheme.fontRegular,
                                color: AppTheme.white,
                                fontSize: 24.sp,
                              )),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text('your Pokédex',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontWeight: AppTheme.fontBold,
                                  color: AppTheme.white,
                                  fontSize: 28.sp,
                                )),
                            ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight: Adaptive.h(42),
                              maxHeight: Adaptive.h(65)
                            ),
                            child: Image.asset(
                              'assets/images/pikachu.png',
                              width: Adaptive.w(90),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        MainBtn(
                          isLoading: false,
                          textBtn: "CREATE NEW ACCOUNT",
                          onPress: () {
                            Navigator.push(
                                context,
                                createRoute(page: const RegisterScreen()),
                              );
                          },
                          width: double.infinity,
                          height: 28.sp,
                          enable: true,
                          fontSize: 16.sp,
                          //color: AppTheme.primaryPrurple,
                          textColor: AppTheme.white,
                          color: AppTheme.red,
                          border: false,
                          fontWeight: AppTheme.fontSemiBold,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        MainBtn(
                          isLoading: false,
                          textBtn: "LOG IN",
                          onPress: () {
                            Navigator.push(
                                context,
                                createRoute(page: const LoginScreen()),
                              );
                          },
                          width: double.infinity,
                          height: 28.sp,
                          enable: true,
                          fontSize: 16.sp,
                          textColor: AppTheme.red,
                          color: Colors.transparent,
                          border: true,
                          fontWeight: AppTheme.fontSemiBold,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
