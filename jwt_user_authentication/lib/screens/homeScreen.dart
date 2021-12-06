import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../secret.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.jwt, this.payload);

  factory HomeScreen.fromBase64(String jwt) => HomeScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Secret Data Screen")),
        body: Center(
          child: FutureBuilder(
            future: http.read('$apiEndpoint/user', headers: {"auth": jwt}),
            builder: (context, snapshot) => snapshot.hasData
                ? Column(
                    children: <Widget>[
                      Text("${payload['username']}, here's the data:"),
                      Text(snapshot.data,
                          // ignore: deprecated_member_use
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  )
                : snapshot.hasError
                    ? Text("An error occurred")
                    : CircularProgressIndicator(),
          ),
        ),
      );
}
