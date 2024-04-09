import '../localdb/my_db.dart';

class User{
  final int? id;
  final String userId;
  final String name;
  final String profileUrl;
  final bool isSubscribed;

  const User({
    this.id,
    required this.userId,
    required this.name,
    required this.profileUrl,
    required this.isSubscribed,
  });

  Map<String, Object?> toMap() => {
    MyDB.userColumnId: id,
    MyDB.userColumnUserId: userId,
    MyDB.userColumnUserName: name,
    MyDB.userColumnProfileURL: profileUrl,
    MyDB.userColumnIsSubscribed: isSubscribed ? 1 : 0,
  };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map[MyDB.userColumnId] as int?,
      userId: map[MyDB.userColumnUserId] as String,
      name: map[MyDB.userColumnUserName] as String,
      profileUrl: map[MyDB.userColumnProfileURL] as String,
      isSubscribed: map[MyDB.userColumnIsSubscribed] == 1,
    );
  }
}