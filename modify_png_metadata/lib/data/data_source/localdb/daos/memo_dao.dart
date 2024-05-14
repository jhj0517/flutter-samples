import '../database/app_db.dart';
import '../../../models/local/memo.dart';

class MemoDao {

  MemoDao({
    required this.appDB
  });

  final AppDB appDB;

  Future<List<Memo>> getAllMemos() async {
    final db = await appDB.database;
    final result = await db.query(AppDB.memoTable);

    return result.map((json) => Memo.fromMap(json)).toList();
  }

  Future<void> insertMemo(Memo memo) async {
    final db = await appDB.database;
    await db.insert(AppDB.memoTable, memo.toMap());
  }

  Future<void> updateMemo(Memo memo) async {
    final db = await appDB.database;
    await db.update(
      AppDB.memoTable,
      memo.toMap(),
      where: '${AppDB.memoColumnId} = ?',
      whereArgs: [memo.id],
    );
  }

  Future<void> deleteMemo(Memo memo) async {
    final db = await appDB.database;
    await db.delete(
      AppDB.memoTable,
      where: '${AppDB.memoColumnId} = ?',
      whereArgs: [memo.id],
    );
  }
}