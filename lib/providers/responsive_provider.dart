import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResposiveProvider extends ChangeNotifier {

  ScreenType _screenType  = ScreenType.mobile;

  ScreenType get screenType => _screenType;
  set screenType(ScreenType valor) {
    _screenType = valor;
    notifyListeners();
  }
}
