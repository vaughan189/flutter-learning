import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snack Bar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SnackBar Demo App'),
        ),
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
      onPressed: () {
        final snackBar = SnackBar(
          content: Text('Yay! A SnackBar!'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Text('Show SnackBar'),
    ));
  }
}
