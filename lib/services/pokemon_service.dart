import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../environments/enviroment.dart';

class PokemonService extends ChangeNotifier {
  final String _baseUrl = Enviroment.baseUrlPokemon;

  bool _isLoadding = false;
  bool get isLoading => _isLoadding;
  set isLoading(bool value) {
    _isLoadding = value;
    notifyListeners();
  }

  /**
   * Registrar a un usuariio con firbase
   */
  Future<dynamic> getPokemonList(
      {required int pageSize, required int page}) async {
    final url = Uri.https(_baseUrl, '/api/v1/digimon', {
      'page': page,
      'pageSize': pageSize,
    });
    dynamic resp;
    Map<String, dynamic> decodeResp;
    try {
      //todo list add
      resp = await http.get(url);
      decodeResp = json.decode(resp.body);
    } on TimeoutException catch (_) {
      decodeResp = {'error': 'timeOut'};
    } on SocketException catch (_) {
      decodeResp = {'error': 'internet'};
    } on Error catch (_) {
      decodeResp = {'error': 'generalError'};
    }
    return decodeResp;
  }
}
