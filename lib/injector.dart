
import 'package:findcaption/core/config/api.dart';
import 'package:findcaption/core/utils/navigation/navigation_utils.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// Registering api endpoint
  locator.registerSingleton(Api());

  /// Registering utils
  locator.registerLazySingleton(() => NavigationUtils());
  
  /// Registering services
}