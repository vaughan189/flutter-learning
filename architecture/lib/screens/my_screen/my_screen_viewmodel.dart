import 'package:flutter/foundation.dart';

class MyScreenViewModel extends ChangeNotifier {
  int _someValue = 0;
  int get someValue => _someValue;
  Future loadData() async {
    // do initialization...
    notifyListeners();
  }

  void doSomething() {
    // do something...
    notifyListeners();
  }
}
