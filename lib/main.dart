import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/screens/screens.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonService(),
        ),
      ],
      child: ResponsiveSizer(
        builder: (_, __, screenTypes) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pokedex',
            initialRoute: 'check/',
            theme: AppTheme.pokemonTheme,
            routes: {
              'check/': ((context) => const WelcomeScreen()),
            },
          );
        },
      ),
    );
  }
}
