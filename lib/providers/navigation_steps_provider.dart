import 'package:flutter/cupertino.dart';

class NavigationStepsProvider extends ChangeNotifier {
  int initialRoute;
  int _actualPage = 0;
  late PageController _pageController;

  NavigationStepsProvider(this.initialRoute) {
    _actualPage = initialRoute;
    _pageController = PageController(initialPage: _actualPage);
  }

  /**
   * controll animation page when actual value change and redraw widget
   */
  int get actualPage => _actualPage;
  set actualPage(int valor) {
    _actualPage = valor;
    _pageController.animateToPage(valor, duration: const Duration(milliseconds: 400), curve: Curves.linear);
    notifyListeners();
  }

  //get page controllet
  PageController get pageController => _pageController;
}
