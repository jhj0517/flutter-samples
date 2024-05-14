import '../../data/data_source/localdb/daos/memo_dao.dart';
import '../../data/repositories/repositories.dart';
import '../dependency_injection.dart';
import '../../data/data_source/network/binance/binance_client.dart';
import 'base_module.dart';

final class RepositoryModule extends BaseModule {

  @override
  Future<void> register() async {
    locator.registerFactory(() => MemoRepository(memoDao: locator.get<MemoDao>()));
    locator.registerFactory(() => BinanceRepository(client: locator.get<BinanceClient>()));
  }

}