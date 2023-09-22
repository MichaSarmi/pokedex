import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../theme/app_theme.dart';
class ItemListPokemon extends StatelessWidget {
  const ItemListPokemon({
    super.key,
    required this.number,
    required this.name,
    required this.field,
    required this.image,
    required this.onPress,
  });
  final String number;
  final String name;
  final String field;
  final String image;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {onPress();} ,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -32.sp,
              bottom: -32.sp,
              child: Image.asset(
                'assets/images/ball_back.png',
                width: Adaptive.w(45),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 35.sp,
                      child: Image.network(
                        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png',
                        loadingBuilder: (context, child, loadingProgress) {
                          return Image.asset('assets/images/whopokemon.png');
                        },
                        errorBuilder: (context, error, stackTrace) {
                           return Image.asset('assets/images/whopokemon.png');
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                      child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.red,
                        borderRadius: BorderRadius.circular(100)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text('#001',
                        style: GoogleFonts.poppins(
                          fontWeight: AppTheme.fontSemiBold,
                          color: AppTheme.white,
                          fontSize: 14.sp,
                        )),
                  )),
                  Center(
                    child: Text('Bulbasaur',
                        style: GoogleFonts.poppins(
                          fontWeight: AppTheme.fontSemiBold,
                          color: AppTheme.graySemiDark,
                          fontSize: 14.sp,
                        )),
                  ),
                  Center(
                    child: Text('Grass   ·   Posion',
                        style: GoogleFonts.poppins(
                          fontWeight: AppTheme.fontSemiBold,
                          color: AppTheme.greenpoke,
                          fontSize: 14.sp,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
