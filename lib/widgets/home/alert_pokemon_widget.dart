import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../services/pokemon_service.dart';
import '../../theme/app_theme.dart';
import '../widgets.dart';

class AlertPokemon extends StatefulWidget {
  const AlertPokemon({
    super.key,
    required this.id,
    required this.number,
    required this.image,
  });
  final String id;
  final int number;
  final String image;

  @override
  State<AlertPokemon> createState() => _AlertPokemonState();
}

class _AlertPokemonState extends State<AlertPokemon> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final loginFormProvider =  Provider.of<LoginFormProvider>(context,listen: false);
      final pokemonService =
          Provider.of<PokemonService>(context, listen: false);
      pokemonService.isLoading = true;
      await pokemonService.getPokemon(id: widget.id).then((value) {
        //print(value);
      }).catchError((err) {
        //print(err);
      });
      pokemonService.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonService = Provider.of<PokemonService>(context);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: AppTheme.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(16)),
      elevation: 5,
      content: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      widget.number < 10
                          ? '#00${widget.number}'
                          : widget.number < 100
                              ? '#0${widget.number}'
                              : '#${widget.number}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: AppTheme.fontSemiBold,
                        color: AppTheme.black,
                        fontSize: 18.sp,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: SizedBox(
                        width: 35.sp,
                        height: 35.sp,
                        child: Image.network(
                          widget.image,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/whopokemon.png');
                          },
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: Adaptive.w(100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _InfoTwoColum(
                          title: 'Level',
                          subtitle: pokemonService.pokemon.levels != null &&
                                  pokemonService.pokemon.levels!.isNotEmpty
                              ? pokemonService.pokemon.levels![0].level
                              : "Unknown",
                        ),
                        _InfoTwoColum(
                          title: 'Attribute',
                          subtitle: pokemonService.pokemon.attributes != null &&
                                  pokemonService.pokemon.attributes!.isNotEmpty
                              ? pokemonService.pokemon.attributes![0].attribute
                              : "Unknown",
                        ),
                        _InfoTwoColum(
                          title: 'Type',
                          subtitle: pokemonService.pokemon.types != null &&
                                  pokemonService.pokemon.types!.isNotEmpty
                              ? pokemonService.pokemon.types![0].type
                              : "Unknown",
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                          children: [
                            Text("Fileds",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: AppTheme.fontSemiBold,
                                  color: AppTheme.black,
                                  fontSize: 16.sp,
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            pokemonService.pokemon.fields != null &&
                          pokemonService.pokemon.fields!.isNotEmpty
                      ? 
                            Center(
                              child: SizedBox(
                                  width: 16.sp,
                                  height: 16.sp,
                                  child: Image.network(
                                    pokemonService.pokemon.fields![0].image,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox(
                                        width: 24,
                                        height: 124,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                  )),
                            ):Text("Unknown",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: AppTheme.fontLigth,
                                  color: AppTheme.black,
                                  fontSize: 14.sp,
                                )),
                          ],
                        )
                     
                ]),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButtonRounded(
                size: 25.sp,
                icon: Icons.close,
                iconColor: AppTheme.black,
                iconSize: 20.sp,
                onPress: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }
}

class _InfoTwoColum extends StatelessWidget {
  const _InfoTwoColum({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: AppTheme.fontSemiBold,
              color: AppTheme.black,
              fontSize: 16.sp,
            )),
        Text(subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: AppTheme.fontRegular,
              color: AppTheme.graySemiDark,
              fontSize: 14.sp,
            )),
      ],
    );
  }
}
