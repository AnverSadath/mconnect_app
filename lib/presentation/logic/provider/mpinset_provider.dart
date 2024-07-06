import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MpinSetProvider extends ChangeNotifier {
  bool _isMpinSet = false;

  bool get isMpinSet => _isMpinSet;

  Future<void> checkMpinStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isMpinSet = prefs.getString('pin') != null;
    notifyListeners();
  }

  Future<void> setMpin(String pin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pin', pin);
    _isMpinSet = true;
    notifyListeners();
  }

  Future<void> removeMpin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('pin');
    _isMpinSet = false;
    notifyListeners();
  }
}
