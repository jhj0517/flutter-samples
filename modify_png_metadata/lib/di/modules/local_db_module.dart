import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dependency_injection.dart';
import 'base_module.dart';
import '../../data/data_source/localdb/daos/memo_dao.dart';
import '../../data/data_source/localdb/database/app_db.dart';

final class LocalDBModule extends BaseModule {

  @override
  Future<void> register() async {
    // SQLite
    locator.registerLazySingleton<AppDB>(() => AppDB());
    // SharedPreference
    locator.registerLazySingletonAsync<SharedPreferences>(() async => SharedPreferences.getInstance());
    await locator.isReady<SharedPreferences>();
    // DotEnv
    await dotenv.load(fileName: ".env");
    locator.registerLazySingleton<DotEnv>(() => dotenv);
    // DAOs
    locator.registerFactory(() => MemoDao(appDB: locator.get<AppDB>()));
  }

}