import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import './db/service.dart';
import 'random_number.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  DatabaseService dbService = DatabaseService();
  int _savedNumber;
  int _randomNumber;
  int _numberInDatabase;
  int _numberInDatabaseId;
  int _numberInFile;

  @override
  void initState() {
    super.initState();
    _savedNumber = 0;
    _randomNumber = 0;
    _numberInDatabase = 0;
    _numberInDatabaseId = 0;
    _numberInFile = 0;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/randoms.txt');
  }

  void _writeNumberToFile() async {
    final file = await _localFile;
    file.writeAsString('$_randomNumber');

    setState(() {
      _numberInFile = _randomNumber;
    });
  }

  void _readNumberFromFile() async {
    try {
      final file = await _localFile;
      // Read the file.
      String contents = await file.readAsString();

      setState(() {
        _randomNumber = int.parse(contents);
      });
    } catch (e) {
      setState(() {
        _randomNumber = 0;
      });
    }
  }


  void _generateRandomNumber() {
    setState(() {
      _randomNumber = Random().nextInt(pow(2, 31));
    });
  }

  void _saveNumber() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('savedNumber', _randomNumber);

    setState(() {
      _savedNumber = _randomNumber;
    });
  }

  void _loadNumber() async {
    final SharedPreferences prefs = await _prefs;
    final savedNumber = prefs.getInt('savedNumber') ?? 0;

    setState(() {
      _randomNumber = savedNumber;
    });
  }

  void _saveNumberToDb() async {
    final number = RandomNumber.fromMap({
      "value": _randomNumber,
      "createdTime": DateTime.now()
    });
    final int id = await dbService.insertNumber(number);

    setState(() {
      _numberInDatabase = _randomNumber;
      _numberInDatabaseId = id;
    });
  }

  void _loadNumberFromDb() async {
    await dbService.getNumber(_numberInDatabaseId).then((number) => {
      setState(() {
      _randomNumber = number.value;
    })
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have generated random number:',
              ),
              Text(
                '$_randomNumber',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.display2,
              ),
              Text(
                'You saved this number in SharedPreference',
              ),
              Text(
                '$_savedNumber',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                'You saved this number in SQLite',
              ),
              Text(
                '$_numberInDatabase',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                'You saved this number in local file',
              ),
              Text(
                '$_numberInFile',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.display1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  OutlineButton(
                      onPressed: () => _loadNumber(), child: Text('Load')),
                  OutlineButton(
                      onPressed: () => _generateRandomNumber(),
                      child: Text('Random')),
                  OutlineButton(
                      onPressed: () => _saveNumber(), child: Text('Save')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  OutlineButton(
                      onPressed: () => _loadNumberFromDb(), child: Text('Load from SQLite')),
                  OutlineButton(
                      onPressed: () => _saveNumberToDb(), child: Text('Save to SQLite')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  OutlineButton(
                      onPressed: () => _readNumberFromFile(), child: Text('Read from file')),
                  OutlineButton(
                      onPressed: () => _writeNumberToFile(), child: Text('Write to file')),
                ],
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}