import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../theme/app_theme.dart';
import '../widgets.dart';

class AlertPokemon extends StatelessWidget {
  const AlertPokemon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
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
                   Text('#001',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: AppTheme.fontSemiBold,
                  color: AppTheme.black,
                  fontSize: 18.sp,
                )),
                const SizedBox(height: 16,),
                  Center(
                    child: SizedBox(
                      width: 35.sp,
                      child:Image.network(
                              'https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png',
                              loadingBuilder: (context, child, loadingProgress) {
                                return Image.asset('assets/images/whopokemon.png');
                              },
                              errorBuilder: (context, error, stackTrace) {
                                 return Image.asset('assets/images/whopokemon.png');
                              },
                              fit: BoxFit.cover,
                            )
                    ),
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                    width: Adaptive.w(100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _InfoTwoColum(
                          title: 'Level',
                          subtitle: 'Adult',
                        ),
                        _InfoTwoColum(
                          title: 'Attribute',
                          subtitle: 'Virus',
                        ),
                        _InfoTwoColum(
                          title: 'Type',
                          subtitle: 'Mutant',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Column(
                    children: [
                      Text("Fileds",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: AppTheme.fontSemiBold,
                            color: AppTheme.black,
                            fontSize: 16.sp,
                          ))
                          //todo image
                    ],
                  )
                ]),
          ),
              Positioned(
                top: 8,
                right:8,
                child: IconButtonRounded(
                        size: 25.sp,
                        icon: Icons.close,
                        iconColor: AppTheme.black,
                        iconSize: 20.sp,
                        onPress: () {
                          Navigator.pop(context);
                        }),
              )
              ,
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
