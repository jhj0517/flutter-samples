import '../data_source/localdb/daos/memo_dao.dart';
import '../models/local/memo.dart';

class MemoRepository{

  MemoRepository({
    required this.memoDao
  });

  final MemoDao memoDao;

  Future<List<Memo>> readMemos() => memoDao.getAllMemos();

  Future<void> addMemo(Memo memo) => memoDao.insertMemo(memo);

  Future<void> deleteMemo(Memo memo) => memoDao.deleteMemo(memo);

  Future<void> updateMemo(Memo memo) => memoDao.updateMemo(memo);

}