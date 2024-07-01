import 'package:flutter/material.dart';
import 'package:uas_mobile/models/makeup_model.dart';
import 'package:uas_mobile/providers/makeup_provider.dart';

class MakeupListViewModel extends ChangeNotifier {
  final MakeupProvider _makeupProvider = MakeupProvider();
  List<Makeup> _makeups = [];

  List<Makeup> get makeups => _makeups;

  Future<void> fetchMakeups() async {
    try {
      await _makeupProvider.fetchMakeups();
      _makeups = _makeupProvider.makeups;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch makeups');
    }
  }

  Future<void> searchMakeups(String query) async {
    try {
      await _makeupProvider.searchMakeups(query);
      _makeups = _makeupProvider.makeups;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to search makeups');
    }
  }

  void clearSearch() {
    _makeupProvider.clearSearch();
    _makeups = [];
    notifyListeners();
  }
}
