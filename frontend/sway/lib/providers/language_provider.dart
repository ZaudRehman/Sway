//frontend\sway\lib\providers\language_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String _language = 'English';

  String get language => _language;

  LanguageProvider() {
    _loadLanguagePreference();
  }

  void setLanguage(String lang) async {
    _language = lang;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', _language);
  }

  void _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language') ?? 'English';
    notifyListeners();
  }
}
