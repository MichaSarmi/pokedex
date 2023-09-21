
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class LoadingLogin extends StatelessWidget {
  const LoadingLogin({
    Key? key, required this.size, this.color,
  }) : super(key: key);
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        //padding: const EdgeInsets.symmetric(horizontal: 52),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle
        ),
        child: CircularProgressIndicator(color:color?? AppTheme.white,),
      ),
    );
  }
}