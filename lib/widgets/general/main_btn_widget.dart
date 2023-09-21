
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../theme/app_theme.dart';
import '../widgets.dart';



class MainBtn extends StatelessWidget {
  final bool isLoading;
  final String? textBtn;
  final double? width;
  final double height;
  final Function onPress;
  final double? paddingHorizonat;
  final double? fontSize;
  final bool enable;
  final Color color;
  final Color textColor;
  final bool border;
  final double? sizeIcon;
  final double? radiusBorder;
  final FontWeight? fontWeight;
  final Widget? iconWidget;

  const MainBtn({
    Key? key,
    required this.isLoading,
    this.textBtn,
    this.width,
    required this.onPress,
    required this.height,
    this.paddingHorizonat,
    this.fontSize,
    required this.enable,
    required this.color,
    required this.textColor,
    required this.border,
    this.sizeIcon, 
    this.radiusBorder, this.fontWeight, this.iconWidget, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
           height: height,
            constraints: BoxConstraints(
              minWidth: width ?? 80,
                ),
          decoration: BoxDecoration(
            color:color==Colors.transparent?Colors.transparent :AppTheme.white,
            borderRadius: BorderRadius.circular(radiusBorder??12.sp)
          ),
        ),
        Container(
            height: height,
            constraints: BoxConstraints(
              minWidth: width ?? 80,
                ),
            decoration: isLoading == true
                ? BoxDecoration(borderRadius: BorderRadius.circular(radiusBorder??12.sp), color:enable&&!isLoading? color:color.withOpacity(0.5) )
                :border
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusBorder??12.sp), 
                            color:enable? color:color.withOpacity(0.5), 
                            border: Border.all(color: AppTheme.red))
                        : BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusBorder??12.sp),color:enable? color:color.withOpacity(0.5)),
            child: isLoading == true
                ? LoadingLogin(
                    size: height - 16.sp,
                  )
                : TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: paddingHorizonat ?? 16)),
                    ),
                    onPressed: isLoading || !enable
                        ? null
                        : () {
                            onPress();
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        if (textBtn != null)
                    
                        Text(textBtn!,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontWeight:fontWeight?? AppTheme.fontMedium,
                                  color:textColor,
                                  fontSize: fontSize ?? 18.sp,
                                  
                                ))
                        
                      ],
                    ))),
      ],
    );
  }
}
