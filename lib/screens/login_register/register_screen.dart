import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../providers/providers.dart';
import '../../services/services.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegisterLoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavigationStepsProvider(0),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
      ],
      builder: (context, child) {
        final navigationStepsProvider =
            Provider.of<NavigationStepsProvider>(context);
        return Scaffold(
          backgroundColor: Colors.red,
          body: SafeArea(
            top: false,
            child: PageView(
              controller: navigationStepsProvider.pageController,
              children: const[
                _StepEmail(),
                _StepPassword()
              ],
            ),
          ),
        );
      },
    );
  }
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
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
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
                   * Validete format password
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
                 * Validete format email
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
                        registerProvider.validPassword =  registerProvider.isValidPassword();
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
              isLoading:  authService.isLoading,
              textBtn: "Next",
              onPress: () async {
                //usernameService.isLoading = true;
                if (registerProvider.isValidPassword()) {
                  
                  if (registerProvider.password ==
                      registerProvider.repeatPassword) {
                      authService.isLoading=true;
                       await authService.createUser(email: registerProvider.email, password: registerProvider.password).then((value) {
                        //todo if
                        navigationStepsProvider.actualPage = 2;

                        }).catchError((err){
                          Toast.show(
                            msg: 'It is not possible to create an account at this time, please try again later.',
                            succes: false,
                            context: context);
                          
                        });
                    
                  } else {
                     authService.isLoading=false;
                    Toast.show(
                        msg: 'Error, passwords do not match',
                        succes: false,
                        context: context);
                  }
                }
                 authService.isLoading=false;
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
   // final emailService = Provider.of<EmailService>(context);
    final registerProvider = Provider.of<RegisterLoginProvider>(context);
    final navigationStepsProvider =
        Provider.of<NavigationStepsProvider>(context);
    // final bipProvider = Provider.of<BipProvider>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
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
                   * Validete format is empty and format email
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
                      return regExp.hasMatch(value)
                          ? null
                          : 'Invalid format';
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
              isLoading: false,
              textBtn: "Next",
              onPress: () async {
                navigationStepsProvider.actualPage=1;
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

