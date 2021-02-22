import 'package:scoped_model_tutorial/enums/view_states.dart';
import 'package:scoped_model_tutorial/services/storage_service.dart';

import '../service_locator.dart';
import 'base_model.dart';

class HomeModel extends BaseModel {
  StorageService storageService = locator<StorageService>();

  String title = "HomeModel";

  ViewState _state;
  ViewState get state => _state;

  Future<bool> saveData() async {
    setState(ViewState.Busy);
    title = "Saving Data";
    await storageService.saveData();
    title = "Data Saved";
    setState(ViewState.Retrieved);
    return true;
  }

  // void _setState(ViewState newState) {
  //   _state = newState;
  //   notifyListeners();
  // }
}
