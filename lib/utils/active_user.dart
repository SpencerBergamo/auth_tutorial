import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveUser {
  final String id;
  final String name;
  final String username;
  final String email;
  final String photoUrl;
  final List followers;
  final List following;

  const ActiveUser({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "uid": id,
        "name": name,
        "username": username,
        "email": email,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following,
      };

  static ActiveUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ActiveUser(
        id: snapshot['uid'],
        name: snapshot['name'],
        username: snapshot['username'],
        email: snapshot['email'],
        photoUrl: snapshot['photoUrl'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }
}
