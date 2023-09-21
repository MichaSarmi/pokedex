import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../theme/app_theme.dart';

class TitleForms extends StatelessWidget {
  final String titleTop;
  final String? titleBot;
  final double? sizeTitleTop;
  final double? sizeTitleBottom;

  const TitleForms(
      {Key? key,
      required this.titleTop,
      this.titleBot,
      this.sizeTitleTop,
      this.sizeTitleBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adaptive.w(100) - 12 - 32 - 36.sp - 24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/pokeball.png',
            width: 24.sp,
          ),
          const SizedBox(height: 8,),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              titleTop,
              textAlign: titleBot == null ? TextAlign.center : TextAlign.start,
              style: GoogleFonts.poppins(
                fontWeight: AppTheme.fontMedium,
                color: AppTheme.graySemiDark,
                fontSize: sizeTitleTop ?? 18.sp,
                letterSpacing: 0,
              ),
            ),
          ),
          titleBot != null
              ? Transform.translate(
                  offset: Offset(0, -10.sp),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      children: [
                        Text(
                          titleBot!,
                          style: GoogleFonts.poppins(
                            fontWeight: AppTheme.fontBold,
                            color: AppTheme.black,
                            fontSize: sizeTitleBottom ?? 24.sp,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
