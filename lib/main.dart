import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/screens/screens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(const AppState());
  });
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pokedex',
          initialRoute: 'welcome/',
          theme: AppTheme.darkTheme, //todo change name
          routes: {
            'welcome/': ((context) => const WelcomeScreen()),
          },
        );
      },
    );
  }
}
