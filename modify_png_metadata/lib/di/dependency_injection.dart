import 'package:get_it/get_it.dart';

import 'modules/local_db_module.dart';
import 'modules/network_module.dart';
import 'modules/repository_module.dart';

final locator = GetIt.I;

final class DependencyInjection{

  static Future<void> register() async {
    for (final module in [
      LocalDBModule(),
      NetworkModule(),
      RepositoryModule(),
    ]) {
      await module.register();
    }
  }

}