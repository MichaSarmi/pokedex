import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../theme/app_theme.dart';


class AlertWidget extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String description;
  final String? secondaryDescription;
  final String nameButtonRight;
  final String nameButtonLeft;
  final bool colorOrder;
  final Function onActionAlert;

  const AlertWidget(
      {super.key,
      this.icon,
      required this.title,
      required this.description,
      required this.nameButtonRight,
      required this.nameButtonLeft,
      required this.colorOrder,
      required this.onActionAlert,
      this.secondaryDescription});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
          backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(16.sp)),
            elevation: 5,
            title: Column(
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 32,
                    color: Colors.white,
                  ),
                if (icon != null) const SizedBox(height: 16),
                Text(title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: AppTheme.fontSemiBold,
                      color: AppTheme.black,
                      fontSize: 18.sp,
                    )),
              ],
            ),
            content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 15),
              Center(
                child: Text(description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: AppTheme.fontRegular,
                      color: AppTheme.black,
                      fontSize: 16.sp,
                    )),
              ),
              if (secondaryDescription != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(secondaryDescription!,
                        style: GoogleFonts.poppins(
                          fontWeight: AppTheme.fontRegular,
                          color: AppTheme.white,
                          fontSize: 16.sp,
                        )),
                  ),
                ),
            ]),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(nameButtonLeft,
                      style: GoogleFonts.poppins(
                        fontWeight: AppTheme.fontRegular,
                        color: colorOrder ? AppTheme.red : AppTheme.blue,
                        fontSize: 16.sp,
                      ))),
              TextButton(
                  onPressed: () {
                    onActionAlert();
                    //Navigator.pop(context);
                  },
                  child: Text(nameButtonRight,
                      style: GoogleFonts.poppins(
                        fontWeight: AppTheme.fontRegular,
                        color: !colorOrder ? AppTheme.red : AppTheme.blue,
                        fontSize: 16.sp,
                      ))),
            ],
          )
        : 
        CupertinoAlertDialog(
            title: Column(
              children: [
                icon!=null?
                Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ):const SizedBox(),
                icon!=null? const SizedBox(height: 16):const SizedBox(),
                Text(title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: AppTheme.fontSemiBold,
                      color: AppTheme.white,
                      fontSize: 18.sp,
                    )),
              ],
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(height: 15),
              Center(
                child: Text(description,
                    style: GoogleFonts.poppins(
                      fontWeight: AppTheme.fontRegular,
                      color: AppTheme.white,
                      fontSize: 16.sp,
                    )),
              ),
              const SizedBox(height: 15),
            ]),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(nameButtonLeft,
                      style: GoogleFonts.poppins(
                        fontWeight: AppTheme.fontRegular,
                        color: colorOrder ? AppTheme.red : AppTheme.blue,
                        fontSize: 16.sp,
                      ))),
              TextButton(
                  onPressed: () {
                    onActionAlert();
                    //Navigator.pop(context);
                  },
                  child: Text(nameButtonRight,
                      style: GoogleFonts.poppins(
                        fontWeight: AppTheme.fontRegular,
                        color: !colorOrder ? AppTheme.red : AppTheme.blue,
                        fontSize: 16.sp,
                      ))),
            ],
          );
  }
}
