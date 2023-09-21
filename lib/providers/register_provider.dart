import 'package:flutter/material.dart';

class RegisterLoginProvider extends ChangeNotifier {

GlobalKey<FormState> formKeyStepPassword= GlobalKey<FormState>();
GlobalKey<FormState> formKeySteLogin= GlobalKey<FormState>();

  String email = '';
  String password='';
  String repeatPassword='';
  String username = '';




  bool isRegister = false;

  FocusNode focusEmail = FocusNode();
  FocusNode focusName = FocusNode();
  FocusNode focusPassword= FocusNode();


  bool _validEmail = false;
  bool _validFormatEmail = false;

  bool get validFormatEmail => _validFormatEmail;
  set validFormatEmail(bool valor) {
    _validFormatEmail = valor;
    notifyListeners();
  }

  GlobalKey<FormState> formKeyStepEmail = GlobalKey<FormState>();


  bool get validEmail => _validEmail;
  set validEmail(bool valor) {
    _validEmail = valor;
    notifyListeners();
  }
  bool _isValidName=false;
  bool get isValidName => _isValidName;
  set isValidName(bool valor) {
    _isValidName = valor;
    notifyListeners();
  }
  
  bool _viewPassRepeat=false;
  bool get viewPassRepeat => _viewPassRepeat;
  set viewPassRepeat(bool valor) {
    _viewPassRepeat = valor;
    notifyListeners();
  }

  bool _viewPass=false;
  bool get viewPass => _viewPass;
  set viewPass(bool valor) {
    _viewPass = valor;
    notifyListeners();
  }

  bool _validPassword=false;
  bool get validPassword => _validPassword;
  set validPassword(bool valor) {
    _validPassword = valor;
    notifyListeners();
  }
 


  bool isValidFormEmail() {
    return formKeyStepEmail.currentState?.validate() ?? false;
  }
 

  bool isValidPassword() {
    return formKeyStepPassword.currentState?.validate() ?? false;
  }

  bool isValidFormLogin() {
    return formKeySteLogin.currentState?.validate() ?? false;
  }


}
