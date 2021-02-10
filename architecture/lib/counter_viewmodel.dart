import 'package:flutter/foundation.dart';

class CounterViewModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  WebApi _webApi = serviceLocator<WebApi>();

  Future loadData() async {
    _counter = await _webApi.fetchValue();
    notifyListeners();
  }

  void increment() {
    _counter++;
    notifyListeners();
  }
}

WebApi serviceLocator<T>() {
  return WebApi();
}

class WebApi {
  Future<int> fetchValue() => Future.delayed(Duration(seconds: 2), () => 11);
}
