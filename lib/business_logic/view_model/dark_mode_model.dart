import 'package:flutter/cupertino.dart';

class DarkModeModel extends ChangeNotifier {

  bool _isDark = false;

  bool get isDark => _isDark;

  void toggleDarkMode(){
    _isDark = !_isDark;
    notifyListeners();
  }
}