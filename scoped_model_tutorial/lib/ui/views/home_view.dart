import 'package:flutter/material.dart';
import 'package:scoped_model_tutorial/enums/view_states.dart';
import 'package:scoped_model_tutorial/scoped_model/home_model.dart';
import 'package:scoped_model_tutorial/ui/widgets/busy_overlay.dart';

import 'base_view.dart';
import 'error_view.dart';
import 'success_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, child, model) => BusyOverlay(
        show: model.state == ViewState.Busy,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getBodyUi(model.state),
                Text(model.title),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var whereToNavigate = await model.saveData();
              if (whereToNavigate) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SuccessView(title: "Passed in from home"),
                  ),
                );
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ErrorView()));
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _getBodyUi(ViewState state) {
  switch (state) {
    case ViewState.Busy:
      return CircularProgressIndicator();
    case ViewState.Retrieved:
    default:
      return Text('Done');
  }
}
