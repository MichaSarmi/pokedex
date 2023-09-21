import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../theme/app_theme.dart';


double pos=24.sp;
class Toast {
  
  static Future<void> show(
    {
    required String msg,
    required bool succes,
    required BuildContext context,
    int? duration,
    String? bipID,
    String? pathImageBip

    }
    ) async {
    Color textColor = succes?AppTheme.green:AppTheme.red;
    Color backgroundColor = AppTheme.graySemiDark;
    if(!isVisible){
      Toast._createView(
        msg,
        succes, 
        context, 
        backgroundColor, 
        textColor,
        bipID,
        pathImageBip
      );
      pos=24.sp;
    }
     Timer( Duration(milliseconds: duration??3500), () =>  Toast.dismiss());
  }

  static OverlayEntry _overlayEntry=OverlayEntry(builder: (context) => Container(),maintainState: true);
  static bool isVisible = false;

  static void _createView(
    String msg,
    bool succes,
    BuildContext context,
    Color background,
    Color textColor,
    String? bipID,
    String? pathImageBip
 
  ) async {
    var overlayState = Overlay.of(context);
    _overlayEntry =  OverlayEntry(
      maintainState: true,
      opaque: false,
      builder: (BuildContext context) => _ToastAnimatedWidget(
        bipId: bipID,
        child: SizedBox(
          width: Adaptive.w(100),
          child: Container(
            alignment: Alignment.center,
            width: Adaptive.w(100),
            child: Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(
                    succes? Icons.check_circle:Icons.error,
                    color: succes?AppTheme.green:AppTheme.red,
                  ),
                  Expanded(
                    //todo renmder image
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        pathImageBip!=null?
                        const SizedBox(width: 16,):const SizedBox(),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: Adaptive.w(65),
                            minHeight: 28.sp
                          ),
                          child: Center(
                            child: Text(
                              msg,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: succes?AppTheme.green:AppTheme.red,
                                  fontWeight: AppTheme.fontRegular,
                                  fontSize: 14.sp,
                                  decoration: TextDecoration.none
                                ),
                            ),
                          ),
                        ),
                        pathImageBip!=null?
                        SizedBox(
                          width: 24.sp,
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.sp),
                              child: Image.file(
                                File(pathImageBip), 
                                width: double.infinity, 
                                fit: BoxFit.cover
                                )
                              ),
                          ),
                        ):const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    isVisible = true;
    overlayState.insert(_overlayEntry);
  }

  static dismiss() async {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    _overlayEntry.remove();
  }
}
class _ToastAnimatedWidget extends StatefulWidget {
   const _ToastAnimatedWidget({
    super.key,
    required this.child, this.bipId,
  
  });

  final Widget child;
  final String? bipId;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastAnimatedWidget>
    with SingleTickerProviderStateMixin {

//update this value later

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: pos,
      //opacity: _isVisible ? 1.0 : 0.0,
      child: GestureDetector(
        onTap: (() {
          
          setState(() {
            //pos=-42.sp;
          });
          if(widget.bipId!=null){
            //todo quitoar comentarios
           /* Navigator.push(
              context,
              createRoute(
                page: HubUniqueBip(
                  bipId:  widget.bipId!,
                ),
              ),
            );*/
          }
           
        }),
        onPanUpdate: (details) {
          setState(() {
            pos=-42.sp;
          });
        },
        child: widget.child
        ),
    );
  }
}