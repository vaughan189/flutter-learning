import 'package:flutter/material.dart';
import 'package:counter_bloc_app/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_bloc_app/bloc/counter_event.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterBloc? counterBloc;
  int counter = 0;

  @override
  void dispose() {
    counterBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => counterBloc?.add(CounterEvent.increment),
      ),
      appBar: AppBar(
        title: const Text('Bloc Counter Example'),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Text(
              '$state',
              style: const TextStyle(fontSize: 50.0),
            );
          },
        ),
      ),
    );
  }
}
