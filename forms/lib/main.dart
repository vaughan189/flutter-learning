import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Field Focus',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  MyCustomForm({Key key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Text Field Focus'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              TextField(
                autofocus: true,
              ),
              // The second text field is focused on when a user taps the
              // FloatingActionButton.
              TextField(
                focusNode: myFocusNode,
              ),
            ])),
        floatingActionButton: FloatingActionButton(
          // When the button is pressed,
          // give focus to the text field using myFocusNode.
          onPressed: () => myFocusNode.requestFocus(),
          tooltip: 'Focus Second Text Field',
          child: Icon(Icons.edit),
        ));
  }
}
