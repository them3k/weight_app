import 'package:flutter/cupertino.dart';

class BaseModel extends ChangeNotifier {

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value){
    if(value == _busy){
      return;
    }
    _busy = value;
    print('base_model | $runtimeType | busy: $_busy | notify');
    notifyListeners();
  }
}