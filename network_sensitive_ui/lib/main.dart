import 'package:network_sensitive_ui/service/connectivity_service.dart';
import 'package:network_sensitive_ui/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'enums/connectivity_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      builder: (context) => ConnectivityService().connectionStatusController,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Connectivity Aware UI',
        theme: ThemeData(
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white)),
        home: HomeView(),
      ),
    );
  }
}
