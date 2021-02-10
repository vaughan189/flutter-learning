import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'my_screen_viewmodel.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyScreenViewModel>.reactive(
      viewModelBuilder: () => MyScreenViewModel(),
      onModelReady: (model) => model.loadData(),
      builder: (context, model, child) => myTopWidget(
          // your widget tree
          ),
    );
  }
}

Widget myTopWidget() {
  return Text('Top widget');
}
