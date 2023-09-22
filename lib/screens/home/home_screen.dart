import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/screens/screens.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../providers/responsive_provider.dart';
import '../../services/services.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollControler = ScrollController();
  @override
  void initState() {
    super.initState();
    /**
     * Listener to get more 
     */
    scrollControler.addListener(() {
      if (scrollControler.position.pixels >=
          (scrollControler.position.maxScrollExtent) - 200) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final pokemonService =
              Provider.of<PokemonService>(context, listen: false);
          if(!pokemonService.isLoaddingMore){
            pokemonService.isLoaddingMore = true;
            print("more");
            pokemonService.page++;
            print(pokemonService.page);
          await pokemonService
              .getPokemonList(pageSize: 20, page: pokemonService.page)
              .then((value) {
            print(value);
          }).catchError((err) {
            print(err);
          });
           pokemonService.isLoaddingMore = false;
          }
         
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final loginFormProvider =  Provider.of<LoginFormProvider>(context,listen: false);
      final pokemonService =
          Provider.of<PokemonService>(context, listen: false);
      pokemonService.isLoading = true;
      await pokemonService.getPokemonList(pageSize: 20, page: 0).then((value) {
        print(value);
      }).catchError((err) {
        print(err);
      });
      pokemonService.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
      ],
      builder: (context, child) {
        final authService = Provider.of<AuthService>(context);
        final pokemonService = Provider.of<PokemonService>(context);
        final resposiveProvider = Provider.of<ResposiveProvider>(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 1.5,
            backgroundColor: AppTheme.white,
            title: Text('Pokédex',
                style: GoogleFonts.poppins(
                  fontWeight: AppTheme.fontSemiBold,
                  color: AppTheme.red,
                  fontSize: 18.sp,
                )),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/pokeball.png',
                      width: 18.sp,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    IconButtonRounded(
                        size: 25.sp,
                        icon: Icons.logout_outlined,
                        iconColor: AppTheme.black,
                        iconSize: 20.sp,
                        onPress: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertWidget(
                                  title: 'Sign out of your account',
                                  description:
                                      'You are about to log out of Pokédex.',
                                  nameButtonLeft: 'Go back',
                                  nameButtonRight: 'Log out',
                                  colorOrder: false,
                                  onActionAlert: () async {
                                    print('log out');
                                    await authService.deleteTokenStorage();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                const WelcomeScreen(),
                                            transitionDuration:
                                                const Duration(seconds: 0)));
                                  },
                                );
                              });
                        }),
                  ],
                ),
              )
            ],
          ),
          backgroundColor: AppTheme.grayUltraLigth,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    !pokemonService.isLoading?
                    GridView.builder(
                      controller: scrollControler,
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 100, left: 24, right: 24),
                      itemCount: pokemonService.listPokemon.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:resposiveProvider.screenType==ScreenType.mobile? Adaptive.w(50):Adaptive.w(40),
                          childAspectRatio: 1,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16),
                      itemBuilder: (context, index) {
                        return ItemListPokemon(
                          name: pokemonService.listPokemon[index].name,
                          number: index,
                          image: pokemonService.listPokemon[index].image,
                          onPress: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return  AlertPokemon(
                                    id:pokemonService.listPokemon[index].id.toString() , 
                                    number: index,
                                    image: pokemonService.listPokemon[index].image,
                                    );
                                });
                          },
                        );
                      },
                    ):LoadingLogin(size: 24.sp, color: AppTheme.blue,),
                      if(pokemonService.isLoaddingMore)
                      Positioned(
                        bottom: 24.sp,
                       child: LoadingLogin(size: 24.sp,color: AppTheme.blue,)
                       )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
