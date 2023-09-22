import 'package:flutter/material.dart';
import 'package:pokedex/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../navigator/navigator.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/general/toast_widget.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AuthService(),
      ),
    ], child: const CheckAuthScreenBody());
  }
}

class CheckAuthScreenBody extends StatefulWidget {
  const CheckAuthScreenBody({Key? key}) : super(key: key);

  @override
  State<CheckAuthScreenBody> createState() => _CheckAuthScreenBodyState();
}

class _CheckAuthScreenBodyState extends State<CheckAuthScreenBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authService = Provider.of<AuthService>(context, listen: false);
      authService.jwt = await authService.readTokenStorage();
   
      if (authService.jwt == '') {
       
        await authService.deleteTokenStorage();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const WelcomeScreen(),
                transitionDuration: const Duration(seconds: 0)));
      } else {
           //verificar si existe un token de firebase
        await authService.verifyCodeVerify(jwt: authService.jwt).then((value) {
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
                    pageBuilder: (_, __, ___) => const HomeScreen(),
                    transitionDuration: const Duration(seconds: 0)));
          } else {
            
            Toast.show(
                msg: 'Please complete your information.',
                succes: false,
                context: context);
            //enviar al usario a completar su información
            Navigator.push(
              context,
              createRoute(
                  page: RegisterScreen(
                initialPage: 2,
                emailInit: value['email'],
              )),
            );
          }
        }).catchError((err) {
            Toast.show(msg: 'Expired Session', succes: false, context: context);
           Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const WelcomeScreen(),
                transitionDuration: const Duration(seconds: 0)));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  // load mientras carga el app
    return Container(
      color: AppTheme.white,
      width: Adaptive.w(100),
      height: Adaptive.h(100),
      child: Stack(alignment: Alignment.center, children: [
        Image.asset(
          'assets/images/pokeball.png',
          width: 42.sp,
        ),
      ]),
    );
  }
}
