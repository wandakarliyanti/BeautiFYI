import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uas_mobile/models/makeup_model.dart';

class MakeupProvider with ChangeNotifier {
  List<Makeup> _makeups = [];

  List<Makeup> get makeups => _makeups;

  Future<void> fetchMakeups() async {
    final url = 'http://makeup-api.herokuapp.com/api/v1/products.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      _makeups = data.map((makeupData) => Makeup.fromJson(makeupData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load makeups');
    }
  }

  Future<void> searchMakeups(String query) async {
    final url = 'http://makeup-api.herokuapp.com/api/v1/products.json?brand=$query';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      _makeups = data.map((makeupData) => Makeup.fromJson(makeupData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to search makeups');
    }
  }

  void clearSearch() {
    _makeups = [];
    notifyListeners();
  }
}
