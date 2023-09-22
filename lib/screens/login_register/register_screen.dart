import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../providers/providers.dart';
import '../../services/services.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key, required this.initialPage, this.emailInit}) : super(key: key);
  final int initialPage;
  final String? emailInit;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegisterLoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavigationStepsProvider(initialPage),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
      ],
      builder: (context, child) {
        final navigationStepsProvider =
            Provider.of<NavigationStepsProvider>(context);
        return Scaffold(
          backgroundColor: AppTheme.white,
          
          appBar: AppBar(
            backgroundColor: AppTheme.white,
            leadingWidth: 25.sp + 16,
            leading:initialPage>0? Padding(
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
            ):const SizedBox(),
            elevation: 0,
          ) ,
          body: SafeArea(
            top: false,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: navigationStepsProvider.pageController,
              children:  [
                const _StepEmail(),
                const _StepPassword(),
                const _StepUsername(),
                _StepSendCode(initEmail: emailInit,),
                const _StepVerifyEmail()
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StepVerifyEmail extends StatefulWidget {
  const _StepVerifyEmail({
    super.key,
  });

  @override
  State<_StepVerifyEmail> createState() => __StepVerifyEmailState();
}

class __StepVerifyEmailState extends State<_StepVerifyEmail>
  with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final registerProvider = Provider.of<RegisterLoginProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
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
                titleTop: 'We need you to',
                titleBot: 'Check your email and click on the link',
              ),
              const SizedBox(
                height: 24,
              ),
              Text('Here you have an example:',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontWeight: AppTheme.fontRegular,
                    color: AppTheme.black,
                    fontSize: 14.sp,
                  )),
              const SizedBox(
                height: 8,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/example.jpg',
                  width: Adaptive.w(100),
                ),
              ),
              SizedBox(
                height: 54.sp,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              textBtn: "Verify email",
              onPress: () async {
                authService.isLoading = true;
                authService.jwt = await authService.readTokenStorage();
                await authService
                    .verifyCodeVerify(jwt: authService.jwt)
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
                              transitionDuration: const Duration(seconds: 0)));
                  } else {
                    Toast.show(
                        msg:
                            'Please verify your email.',
                        succes: false,
                        context: context);
                  }
                  authService.isLoading = false;
                }).catchError((err) {
                  authService.isLoading = false;
                  Toast.show(
                      msg:
                          'It is not possible to create an account at this time, please try again later.',
                      succes: false,
                      context: context);
                });
                authService.isLoading = false;
              },
              width: double.infinity,
              height: 28.sp,
              enable: registerProvider.enableaVerify,
              fontSize: 16.sp,
              border: false,
              color: AppTheme.red,
              textColor: AppTheme.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _StepSendCode extends StatefulWidget {
  const _StepSendCode({
    super.key, this.initEmail,
  });
  final String? initEmail;

  @override
  State<_StepSendCode> createState() => _StepSendCodeState();
}

class _StepSendCodeState extends State<_StepSendCode>
    with AutomaticKeepAliveClientMixin {
  //final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final registerProvider = Provider.of<RegisterLoginProvider>(context);
    final navigationStepsProvider =
        Provider.of<NavigationStepsProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
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
                titleTop: 'We need you to',
                titleBot: 'Verify your email',
              ),
              const SizedBox(
                height: 24,
              ),
              Text('Email:',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontWeight: AppTheme.fontRegular,
                    color: AppTheme.black,
                    fontSize: 14.sp,
                  )),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: Adaptive.w(100),
                height: 28.sp,
                padding:
                    EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.grayUltraLigth,
                ),
                child: Center(
                  child: Text(
                    widget.initEmail?? registerProvider.email,
                    style: GoogleFonts.poppins(
                      fontWeight: AppTheme.fontRegular,
                      color: AppTheme.black.withOpacity(.2),
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 54.sp,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              textBtn: "Send Verification",
              onPress: () async {
                authService.isLoading = true;
                authService.jwt = await authService.readTokenStorage();
                await authService
                    .sendCodeVerify(jwt: authService.jwt)
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
                            'It is not possible to verify your account at this time, please try again later.',
                        succes: false,
                        context: context);
                  } else if (value['email'] != "" && value['email'] != null) {
                    navigationStepsProvider.actualPage = 4;
                  } else {
                    Toast.show(
                        msg:
                            'It is not possible to verify your account at this time, please try again later.',
                        succes: false,
                        context: context);
                  }
                  authService.isLoading = false;
                }).catchError((err) {
                  authService.isLoading = false;
                  Toast.show(
                      msg:
                          'It is not possible to create an account at this time, please try again later.',
                      succes: false,
                      context: context);
                });
                authService.isLoading = false;
              },
              width: double.infinity,
              height: 28.sp,
              enable: registerProvider.enableaVerify,
              fontSize: 16.sp,
              border: false,
              color: AppTheme.red,
              textColor: AppTheme.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _StepUsername extends StatefulWidget {
  const _StepUsername({
    super.key,
  });

  @override
  State<_StepUsername> createState() => _StepUsernameState();
}

class _StepUsernameState extends State<_StepUsername>
    with AutomaticKeepAliveClientMixin {
  //final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final registerProvider = Provider.of<RegisterLoginProvider>(context);
    final navigationStepsProvider =
        Provider.of<NavigationStepsProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: registerProvider.formKeySteName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const TitleForms(
                  titleTop: 'Please, complete your',
                  titleBot: 'Name',
                ),
                const SizedBox(
                  height: 24,
                ),
                Text('Name:',
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
                  initialValue: registerProvider.name,
                  focusNode: registerProvider.focusName,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: AppTheme.black, fontSize: 18.sp),
                  decoration: InputDecoration(
                      hintText: 'name',
                      labelText: 'name',
                      labelStyle: GoogleFonts.poppins(
                          color: AppTheme.grayLigth, fontSize: 18.sp)),
                  /**
                   * Validate format is empty and format email
                   */
                  validator: (value) {
                    if (registerProvider.name == '') {
                      return 'Invalid format';
                    } else {
                      return null;
                    }
                  },
                  onChanged: ((value) {
                    registerProvider.name = value;
                    registerProvider.validFormatName =
                        registerProvider.isValidFormName();
                  }),
                ),
                SizedBox(
                  height: 54.sp,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              textBtn: "Next",
              onPress: () async {
                authService.isLoading = true;
                authService.jwt = await authService.readTokenStorage();
                authService.localId = await authService.readIdStorage();
                print(authService.jwt);
                print(authService.localId);
                await authService
                    .updateNameUser(
                        displayName: registerProvider.name,
                        jwt: authService.jwt,
                        localId: authService.localId)
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
                  } else if (value['localId'] != "" &&
                      value['localId'] != null) {
                    await authService
                        .createIdUserStorage(value['localId'] ?? '');
                    // ignore: use_build_context_synchronously
                    FocusScope.of(context).unfocus();
                    navigationStepsProvider.actualPage = 3;
                  } else {
                    Toast.show(
                        msg:
                            'It is not possible to create an account at this time, please try again later.',
                        succes: false,
                        context: context);
                  }
                  authService.isLoading = false;
                }).catchError((err) {
                  authService.isLoading = false;
                  Toast.show(
                      msg:
                          'It is not possible to create an account at this time, please try again later.',
                      succes: false,
                      context: context);
                });
                authService.isLoading = false;
              },
              width: double.infinity,
              height: 28.sp,
              enable: registerProvider.isValidFormName(),
              fontSize: 16.sp,
              border: false,
              color: AppTheme.red,
              textColor: AppTheme.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _StepPassword extends StatefulWidget {
  const _StepPassword();

  @override
  State<_StepPassword> createState() => _StepPasswordState();
}

class _StepPasswordState extends State<_StepPassword>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final navigationStepsProvider =
        Provider.of<NavigationStepsProvider>(context);
    final registerProvider = Provider.of<RegisterLoginProvider>(context);
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
                    navigationStepsProvider.actualPage = 0;
                    registerProvider.focusEmail.requestFocus();
                  }),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: registerProvider.formKeyStepPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const TitleForms(
                    titleTop: 'Please, create your',
                    titleBot: 'Password',
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
                    focusNode: registerProvider.focusPassword,
                    keyboardType: TextInputType.text,
                    obscureText: !registerProvider.viewPass,
                    style: TextStyle(color: AppTheme.black, fontSize: 18.sp),
                    decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        labelStyle: GoogleFonts.poppins(
                            color: AppTheme.grayLigth, fontSize: 18.sp),
                        suffixIcon: IconButton(
                          icon: Icon(
                            registerProvider.viewPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppTheme.graySemiDark,
                          ),
                          onPressed: () => registerProvider.viewPass =
                              !registerProvider.viewPass,
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
                      registerProvider.password = value;
                      registerProvider.validPassword =
                          registerProvider.isValidPassword();
                    }),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text('Re-enter password:',
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
                    autofocus: false,
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !registerProvider.viewPassRepeat,
                    style: TextStyle(color: AppTheme.black, fontSize: 18.sp),
                    decoration: InputDecoration(
                        hintText: 'Re-enter password',
                        labelText: 'Re-enter password',
                        labelStyle: GoogleFonts.poppins(
                            color: AppTheme.grayLigth, fontSize: 18.sp),
                        suffixIcon: IconButton(
                          icon: Icon(
                            registerProvider.viewPassRepeat
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppTheme.graySemiDark,
                          ),
                          onPressed: () => registerProvider.viewPassRepeat =
                              !registerProvider.viewPassRepeat,
                        )),
                    /**
                 * Validate format email
                 */
                    validator: (value) {
                      value = value == null ? '' : value.trim();
                      if (value.isEmpty) {
                        return "Invalid Format";
                      }
                      return null; //AppLocalizations.of(context).formatInvalid;
                    },
                    onChanged: ((value) {
                      registerProvider.repeatPassword = value;
                      registerProvider.validPassword =
                          registerProvider.isValidPassword();
                    }),
                  ),
                  const SizedBox(
                    height: 120,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              textBtn: "Next",
              onPress: () async {
                //usernameService.isLoading = true;
                if (registerProvider.isValidPassword()) {
                  if (registerProvider.password ==
                      registerProvider.repeatPassword) {
                    authService.isLoading = true;
                    await authService
                        .createUser(
                            email: registerProvider.email,
                            password: registerProvider.password)
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
                      } else if (value['idToken'] != "" &&
                          value['idToken'] != null) {
                        await authService
                            .createTokenStorage(value['idToken'] ?? '');
                        await authService
                            .createIdUserStorage(value['localId'] ?? '');
                        print(value['localId']);
                        navigationStepsProvider.actualPage = 2;
                      } else {
                        if (registerProvider.password.length < 6) {
                          Toast.show(
                              msg:
                                  'Remember to create a password with at least 6 characters.',
                              succes: false,
                              context: context);
                        } else {
                          Toast.show(
                              msg:
                                  'It is not possible to create an account at this time, please try again later.',
                              succes: false,
                              context: context);
                        }
                      }
                      authService.isLoading = false;
                    }).catchError((err) {
                      Toast.show(
                          msg:
                              'It is not possible to create an account at this time, please try again later.',
                          succes: false,
                          context: context);
                    });
                  } else {
                    authService.isLoading = false;
                    Toast.show(
                        msg: 'Error, passwords do not match',
                        succes: false,
                        context: context);
                  }
                }
                authService.isLoading = false;
              },
              width: double.infinity,
              height: 28.sp,
              enable: registerProvider.isValidPassword(),
              fontSize: 16.sp,
              textColor: AppTheme.white,
              border: false,
              color: AppTheme.red,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _StepEmail extends StatefulWidget {
  const _StepEmail({
    super.key,
  });

  @override
  State<_StepEmail> createState() => _StepEmailState();
}

class _StepEmailState extends State<_StepEmail>
    with AutomaticKeepAliveClientMixin {
  //final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final registerProvider = Provider.of<RegisterLoginProvider>(context);
    final navigationStepsProvider =
        Provider.of<NavigationStepsProvider>(context);
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
          child: Form(
            key: registerProvider.formKeyStepEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  initialValue: registerProvider.email,
                  focusNode: registerProvider.focusEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: AppTheme.black, fontSize: 18.sp),
                  decoration: InputDecoration(
                      hintText: 'user@example.com',
                      labelText: 'user@example.com',
                      labelStyle: GoogleFonts.poppins(
                          color: AppTheme.grayLigth, fontSize: 18.sp)),
                  /**
                   * Validate format is empty and format email
                   */
                  validator: (value) {
                    if (registerProvider.email == '') {
                      return 'Invalid format';
                    } else {
                      value = value == null ? '' : value.trim();
                      value = value.trim();
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(pattern);
                      return regExp.hasMatch(value) ? null : 'Invalid format';
                    }
                  },
                  onChanged: ((value) {
                    registerProvider.email = value;
                    registerProvider.validFormatEmail =
                        registerProvider.isValidFormEmail();
                  }),
                ),
                SizedBox(
                  height: 54.sp,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              textBtn: "Next",
              onPress: () async {
                navigationStepsProvider.actualPage = 1;
                registerProvider.focusPassword.requestFocus();
              },
              width: double.infinity,
              height: 28.sp,
              enable: registerProvider.isValidFormEmail(),
              fontSize: 16.sp,
              border: false,
              color: AppTheme.red,
              textColor: AppTheme.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
