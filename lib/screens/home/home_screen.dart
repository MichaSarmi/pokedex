import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/widgets/general/btn_icon_rounded_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      Navigator.pop(context);
                    }),
              ],
            ),
          )
        ],
      ),
      backgroundColor: AppTheme.grayUltraLigth,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
            child: TextFormField(
              cursorColor: AppTheme.black,
              autocorrect: false,
              autofocus: false,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: AppTheme.black),
              decoration: InputDecoration(
                fillColor: AppTheme.white,
                prefixIcon: Icon(Icons.search,
                    color: AppTheme.grayLigth, size: 20.sp),
                hintText: "Search pokemon",
                labelText: "Search pokemon",
                labelStyle: GoogleFonts.poppins(
                                  color: AppTheme.grayLigth, fontSize: 18.sp)
              ),
              onChanged: ((value) {
                //todo iimplemet search
                //loginFormProvider.password = value;
              }),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: 10,
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Adaptive.w(50),
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                    itemBuilder: (context, index) {
                      return Container(width: 33, height: 23, color: Colors.red,);
                    },
                    
                    ),
            ),
          )

        ],
      ),
    );
  }
}
