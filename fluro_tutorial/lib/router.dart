import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro_tutorial/pages/home.dart';
import 'package:fluro_tutorial/pages/login.dart';

class RouterClass {
  static FluroRouter router = FluroRouter();

  static Handler _loginHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginPage());

  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomePage(username: params['username'][0]));

  static void setupRouter() {
    router.define(
      'login',
      handler: _loginHandler,
    );
    router.define(
      'home/:username',
      handler: _homeHandler,
    );
  }
}
