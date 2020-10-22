import 'package:flutter/material.dart';
import 'package:fluro_tutorial/router.dart';

void main() {
  runApp(MyApp());
  RouterClass.setupRouter();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fluro Tutorial',
        // Initial Page set to Login Page
        initialRoute: 'login',
        // Use the generator provided by Fluro package
        onGenerateRoute: RouterClass.router.generator);
  }
}
