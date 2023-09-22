import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../navigator/navigator.dart';
import '../../providers/register_provider.dart';
import '../../services/services.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegisterLoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
      ],
      builder: (context, child) {
        final loginProvider = Provider.of<RegisterLoginProvider>(context);
        final authService = Provider.of<AuthService>(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.white,
            leadingWidth: 25.sp + 16,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  SizedBox(height: 32.sp),
                  IconButtonRounded(
                      size: 25.sp,
                      icon: Icons.arrow_back_ios_new_rounded,
                      iconColor: AppTheme.black,
                      iconSize: 20.sp,
                      onPress: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
            elevation: 0,
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const TitleForms(
                    titleTop: 'Please, enter your',
                    titleBot: 'Credentials',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Form(
                    key: loginProvider.formKeySteLogin,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email:',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                              fontWeight: AppTheme.fontRegular,
                              color: AppTheme.black,
                              fontSize: 14.sp,
                            )),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          enabled: true,
                          autocorrect: false,
                          autofocus: true,
                          initialValue: loginProvider.email,
                          focusNode: loginProvider.focusEmail,
                          keyboardType: TextInputType.emailAddress,
                          style:
                              TextStyle(color: AppTheme.black, fontSize: 18.sp),
                          decoration: InputDecoration(
                              hintText: 'user@example.com',
                              labelText: 'user@example.com',
                              labelStyle: GoogleFonts.poppins(
                                  color: AppTheme.grayLigth, fontSize: 18.sp)),
                          /**
                     * Validate format is empty and format email
                     */
                          validator: (value) {
                            if (loginProvider.email == '') {
                              return 'Invalid format';
                            } else {
                              value = value == null ? '' : value.trim();
                              value = value.trim();
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = RegExp(pattern);
                              return regExp.hasMatch(value)
                                  ? null
                                  : 'Invalid format';
                            }
                          },
                          onChanged: ((value) {
                            loginProvider.email = value;
                            loginProvider.validFormatEmail =
                                loginProvider.isValidFormEmail();
                          }),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text('Password:',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                              fontWeight: AppTheme.fontRegular,
                              color: AppTheme.graySemiDark,
                              fontSize: 14.sp,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          enabled: true, //todo
                          autocorrect: false,
                          autofocus: true,
                          keyboardAppearance: Brightness.light,
                          focusNode: loginProvider.focusPassword,
                          keyboardType: TextInputType.text,
                          obscureText: !loginProvider.viewPass,
                          style:
                              TextStyle(color: AppTheme.black, fontSize: 18.sp),
                          decoration: InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              labelStyle: GoogleFonts.poppins(
                                  color: AppTheme.grayLigth, fontSize: 18.sp),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  loginProvider.viewPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppTheme.graySemiDark,
                                ),
                                onPressed: () => loginProvider.viewPass =
                                    !loginProvider.viewPass,
                              )),
                          /**
                         * Validate format password
                         */
                          validator: (value) {
                            value = value == null ? '' : value.trim();
                            if (value.isEmpty) {
                              return "Invalid format";
                            }
                            return null;
                          },
                          onChanged: ((value) {
                            loginProvider.password = value;
                            loginProvider.validPassword =
                                loginProvider.isValidFormEmail();
                          }),
                        ),
                        SizedBox(
                          height: 54.sp,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 54.sp,
                  )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: EdgeInsets.only(bottom: 16.sp),
            width: double.infinity,
            height: Adaptive.h(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainBtn(
                  isLoading: authService.isLoading,
                  textBtn: "LOG IN",
                  onPress: () async {
                    //usernameService.isLoading = true;
                    if (loginProvider.isValidFormLogin()) {
                      authService.isLoading = true;
                      await authService
                          .loginUser(
                              email: loginProvider.email,
                              password: loginProvider.password)
                          .then((value) async {
                        print(value);
                        if (value['error'] == 'internet') {
                          Toast.show(
                              msg:
                                  'Error. Check your internet connection, reset the app and try again',
                              succes: false,
                              context: context);
                        } else if (value['error'] == 'timeOut') {
                          Toast.show(
                              msg:
                                  'Error. Check your internet connection, reset the app and try again',
                              succes: false,
                              context: context);
                        } else if (value['error'] == 'generalError') {
                          Toast.show(
                              msg:
                                  'It is not possible to create an account at this time, please try again later.',
                              succes: false,
                              context: context);
                        } else if (value['idToken'] != "" && value['idToken'] != null) {

                          await authService.createTokenStorage(value['idToken'] ?? '');
                          await authService.createIdUserStorage(value['localId'] ?? '');
                          await authService
                              .verifyCodeVerify(jwt: value['idToken'])
                              .then((value) {
                                print(value);
                            if (value['error'] == 'internet') {
                              Toast.show(
                                  msg:
                                      'Error. Check your internet connection, reset the app and try again',
                                  succes: false,
                                  context: context);
                            } else if (value['error'] == 'timeOut') {
                              Toast.show(
                                  msg:
                                      'Error. Check your internet connection, reset the app and try again',
                                  succes: false,
                                  context: context);
                            } else if (value['error'] == 'generalError') {
                              Toast.show(
                                  msg:
                                      'It is not possible to verify your account at this time, please try again later.',
                                  succes: false,
                                  context: context);
                            } else if (value['emailVerified'] == true) {
                              //go to home
                              Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          const HomeScreen(),
                                      transitionDuration:
                                          const Duration(seconds: 0)));
                            } else {
                              Toast.show(
                                  msg: 'Please complete your information.',
                                  succes: false,
                                  context: context);

                                  Navigator.push(
                                    context,
                                    createRoute(page:  RegisterScreen(initialPage: 2,emailInit: loginProvider.email,)),
                                  );


                            }
                          }).catchError((err) {
                            Toast.show(
                                msg:
                                    'It is not possible to log in at this time, please try again later.',
                                succes: false,
                                context: context);
                          });
                        } else {
                          Toast.show(
                              msg: 'Incorrect username or password.',
                              succes: false,
                              context: context);
                        }
                        authService.isLoading = false;
                      }).catchError((err) {
                        Toast.show(
                            msg:
                                'It is not possible to log in at this time, please try again later.',
                            succes: false,
                            context: context);
                      });
                    }
                    authService.isLoading = false;
                  },
                  width: double.infinity,
                  height: 28.sp,
                  enable: loginProvider.isValidFormLogin(),
                  fontSize: 16.sp,
                  textColor: AppTheme.white,
                  border: false,
                  color: AppTheme.red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
