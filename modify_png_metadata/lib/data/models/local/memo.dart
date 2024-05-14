import '../../data_source/localdb/localdb.dart';

class Memo{
  final int? id;
  final String content;
  final bool isImportant;

  const Memo({
    this.id,
    required this.content,
    required this.isImportant,
  });

  Map<String, Object?> toMap() => {
    AppDB.memoColumnId: id,
    AppDB.memoColumnContent: content,
    AppDB.memoColumnIsImportant: isImportant ? 1 : 0,
  };

  factory Memo.fromMap(Map<String, dynamic> map) {
    return Memo(
      id: map[AppDB.memoColumnId] as int?,
      content: map[AppDB.memoColumnContent] as String,
      isImportant: map[AppDB.memoColumnIsImportant] == 1,
    );
  }
}