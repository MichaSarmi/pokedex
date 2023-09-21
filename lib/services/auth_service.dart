import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../environments/enviroment.dart';

class AuthService extends ChangeNotifier{
  final String _baseUrl=Enviroment.baseUrl;
  final String _firebaseToken=Enviroment.firebaseToken;

  bool _isLoadding = false;
  bool get isLoading => _isLoadding;
  set isLoading(bool value) {
    _isLoadding = value;
    notifyListeners();
  }

  Future<String?> createUser({required String email, required String password}) async{
    final Map<String,dynamic> authData = {
      'email':email,
      'password':password
    };

    final url = Uri.https(_baseUrl,'/v1/accounts:signUp',{
      'key':_firebaseToken
    });
    final resp = await http.post(url,body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(resp);
  }

}