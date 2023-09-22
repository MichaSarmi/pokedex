import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../environments/enviroment.dart';
import '../model/models.dart';

class PokemonService extends ChangeNotifier {
  final String _baseUrl = Enviroment.baseUrlPokemon;

  bool _isLoadding = true;
  bool get isLoading => _isLoadding;
  set isLoading(bool value) {
    _isLoadding = value;
    notifyListeners();
  }
   bool _isLoaddingMore = false;
  bool get isLoaddingMore => _isLoaddingMore;
  set isLoaddingMore(bool value) {
    _isLoaddingMore = value;
    notifyListeners();
  }
  int page=0;

  List<Content> listPokemon = [];
  PokemonModel pokemon = PokemonModel();
  /**
   * Obtener lista de digimons
   */
  Future<dynamic> getPokemonList({required int pageSize, required int page}) async {
    final url = Uri.https(_baseUrl, '/api/v1/digimon', {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    });
    dynamic resp;
    Map<String, dynamic> decodeResp;
    try {
      //todo list add
      resp = await http.get(url);
      decodeResp = json.decode(resp.body);
       for (var element in decodeResp['content']) {
         listPokemon.add(Content.fromMap(element));
       }
       notifyListeners();
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
   *  Obtener digimon por id
   */
  Future<dynamic> getPokemon({required String id}) async {
    final url = Uri.https(_baseUrl, '/api/v1/digimon/$id',);

    dynamic resp;
    Map<String, dynamic> decodeResp;
    try {
      //todo list add
      resp = await http.get(url);
      decodeResp = json.decode(resp.body);
      pokemon=PokemonModel.fromMap(decodeResp);
       notifyListeners();
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

  

