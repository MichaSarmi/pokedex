import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../environments/enviroment.dart';

class AuthService extends ChangeNotifier{
  final String _baseUrl=Enviroment.baseUrl;
  final String _firebaseToken=Enviroment.firebaseToken;
  final storage = const FlutterSecureStorage();
  String jwt = '';
  String localId = '';
  bool _isLoadding = false;
  bool get isLoading => _isLoadding;
  set isLoading(bool value) {
    _isLoadding = value;
    notifyListeners();
  }
  /**
   * create user with api firebase
   */
  Future<dynamic> createUser({required String email, required String password}) async{
    final Map<String,dynamic> authData = {
      'email':email,
      'password':password
    };

    final url = Uri.https(_baseUrl,'/v1/accounts:signUp',{
      'key':_firebaseToken
    });
    dynamic resp ;
    Map<String, dynamic> decodeResp;
    try {
      resp = await http.post(url,body: json.encode(authData));
      decodeResp =  json.decode(resp.body);
    } on TimeoutException catch (_) {
      decodeResp = {'error': 'timeOut'};
    } on SocketException catch (_) {
      decodeResp = {'error': 'internet'};
    } on Error catch (_) {
      decodeResp = {'error': 'generalError'};
    }
    return decodeResp;
  }

  /**
   * send email verify with api firebase
   */
  Future<dynamic> sendCodeVerify({required String jwt}) async{
    final Map<String,dynamic> authData = {
      'requestType':"VERIFY_EMAIL",
      'idToken':jwt

    };

    final url = Uri.https(_baseUrl,'/v1/accounts:sendOobCode',{
      'key':_firebaseToken
    });
    dynamic resp ;
    Map<String, dynamic> decodeResp;
    try {
      resp = await http.post(url,body: json.encode(authData));
      decodeResp =  json.decode(resp.body);
    } on TimeoutException catch (_) {
      decodeResp = {'error': 'timeOut'};
    } on SocketException catch (_) {
      decodeResp = {'error': 'internet'};
    } on Error catch (_) {
      decodeResp = {'error': 'generalError'};
    }
    return decodeResp;
  }

  /**
   * verify email with api firebase
   */
  Future<dynamic> verifyCodeVerify({required String jwt}) async{
    final Map<String,dynamic> authData = {
      'oobCode':"VERIFICATION_CODE",
      'idToken':jwt

    };

    final url = Uri.https(_baseUrl,'/v1/accounts:update',{
      'key':_firebaseToken
    });
    dynamic resp ;
    Map<String, dynamic> decodeResp;
    try {
      resp = await http.post(url,body: json.encode(authData));
      decodeResp =  json.decode(resp.body);
    } on TimeoutException catch (_) {
      decodeResp = {'error': 'timeOut'};
    } on SocketException catch (_) {
      decodeResp = {'error': 'internet'};
    } on Error catch (_) {
      decodeResp = {'error': 'generalError'};
    }
    return decodeResp;
  }

  /**
   * create user with api firebase
   */
  Future<dynamic> updateNameUser({required String localId,required String jwt, required String displayName}) async{
    final Map<String,dynamic> authData = {
      'localId':localId,
      'idToken':jwt,
      'displayName':displayName

    };

    final url = Uri.https(_baseUrl,'/v1/accounts:update',{
      'key':_firebaseToken
    });
    dynamic resp ;
    Map<String, dynamic> decodeResp;
    try {
      resp = await http.post(url,body: json.encode(authData));
      decodeResp =  json.decode(resp.body);
    } on TimeoutException catch (_) {
      decodeResp = {'error': 'timeOut'};
    } on SocketException catch (_) {
      decodeResp = {'error': 'internet'};
    } on Error catch (_) {
      decodeResp = {'error': 'generalError'};
    }
    return decodeResp;
  }

  /**
   * Store de jwt in the flutter store
   * @jwt , string token from backend
   */
  Future<void> createTokenStorage(String jwt) async {
    jwt = jwt;
    await storage.write(key: 'token', value: jwt);
  }

  Future<String> readTokenStorage() async {
    jwt = await storage.read(key: 'token') ?? '';
    return jwt;
  }

  Future deleteTokenStorage() async {
    await storage.delete(key: 'token');
  }

  /**
   * Store id in the flutter store
   * @jwt , string token from backend
   */
  Future<void> createIdUserStorage(String localId) async {
    localId = localId;
    await storage.write(key: 'localId', value: localId);
  }

  Future<String> readIdStorage() async {
    localId = await storage.read(key: 'localId') ?? '';
    return localId;
  }

  Future deleteIdStorage() async {
    await storage.delete(key: 'localId');
  }


}