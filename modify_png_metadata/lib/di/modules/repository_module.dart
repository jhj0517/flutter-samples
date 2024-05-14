import '../dependency_injection.dart';
import 'base_module.dart';
import '../../repositories/chunk_repository.dart';
import '../../repositories/exif_repository.dart';

final class RepositoryModule extends BaseModule {

  @override
  Future<void> register() async {
    locator.registerFactory(() => ChunkRepository());
    locator.registerFactory(() => ExifRepository());
  }

}