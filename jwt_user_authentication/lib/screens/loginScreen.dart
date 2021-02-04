import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'homeScreen.dart';

import '../secret.dart';
import '../storage.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log In")),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            FlatButton(
              child: Text("Log In"),
              onPressed: () async {
                final username = _usernameController.text;
                final password = _passwordController.text;
                var jwt = await attemptLogIn(username, password);
                if (jwt != null) {
                  storage.write(key: "jwt", value: jwt);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen.fromBase64(jwt)));
                } else {
                  displayDialog(context, "An Error Occurred",
                      "No account was found matching that username and password");
                }
              },
            ),
            FlatButton(
              child: Text("Sign Up"),
              onPressed: () async {
                var username = _usernameController.text;
                var password = _passwordController.text;

                if (username.length < 4)
                  displayDialog(context, "Invalid Username",
                      "The username should be at least 4 characters long");
                else if (password.length < 4)
                  displayDialog(context, "Invalid Password",
                      "The password should be at least 4 characters long");
                else {
                  var res = await attemptSignUp(username, password);
                  if (res == 201)
                    displayDialog(context, "Success",
                        "The user was created. Log in now.");
                  else if (res == 409)
                    displayDialog(
                        context,
                        "That username is already registered",
                        "Please try to sign up using another username or log in if you already have an account.");
                  else {
                    displayDialog(
                        context, "Error", "An unknown error occurred.");
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String> attemptLogIn(String username, String password) async {
    var res = await http.post("$apiEndpoint/auth/login",
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<int> attemptSignUp(String username, String password) async {
    var res = await http.post('$apiEndpoint/auth/signup',
        body: {"username": username, "password": password});
    return res.statusCode;
  }
}
