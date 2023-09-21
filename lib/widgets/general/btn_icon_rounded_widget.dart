import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../theme/app_theme.dart';
class IconButtonRounded extends StatelessWidget {
  const IconButtonRounded({
    super.key, required this.size, required this.icon, required this.iconSize, required this.onPress, this.rounded, this.color, this.iconColor, this.isShadow,
  });
  final double size;
  final double iconSize;
  final IconData icon;
  final Function onPress;
  final double? rounded;
  final Color? color;
  final Color? iconColor;
  final  bool? isShadow;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(rounded??200),
      onTap: (){
       onPress(); 
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rounded??200),
          color: color??Colors.transparent,
        ),
        width: size,
        height: size,
        child:   Icon(
          icon, color: iconColor??AppTheme.white,
          size: iconSize>size?20.sp:iconSize,
          shadows: isShadow==true?AppTheme.shadow:[],
        )
        )
    );
  }
}