import 'package:get_it/get_it.dart';

import 'scoped_model/home_model.dart';
import 'scoped_model/error_model.dart';
import 'scoped_model/success_model.dart';

import 'services/storage_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<StorageService>(() => StorageService());

  // Register models
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<SuccessModel>(() => SuccessModel());
  locator.registerFactory<ErrorModel>(() => ErrorModel());
}
