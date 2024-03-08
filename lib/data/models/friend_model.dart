class Friend {
  final String friendUid;
  final String friendName;
  final String friendUsername;
  final String friendAvatarUrl;
  final bool isFriend;

  const Friend({
    required this.friendUid,
    required this.friendName,
    required this.friendUsername,
    required this.friendAvatarUrl,
    required this.isFriend,
  });

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      friendUid: map['friendUid'],
      friendName: map['friendName'],
      friendUsername: map['friendUsername'],
      friendAvatarUrl: map['friendAvatarUrl'],
      isFriend: map['isFriend'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'friendUid': friendUid,
      'friendName': friendName,
      'friendUsername': friendUsername,
      'friendAvatarUrl': friendAvatarUrl,
      'isFriend': isFriend,
    };
  }
}
