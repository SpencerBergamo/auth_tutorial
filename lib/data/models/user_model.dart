import 'package:auth_tutorial/data/models/friend_model.dart';
import 'package:auth_tutorial/data/models/photo_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String username;
  final String avatarUrl;
  final List<Friend> friends;
  final List<Photo> photos;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.username,
    required this.avatarUrl,
    required this.friends,
    required this.photos,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      username: map['username'],
      avatarUrl: map['avatarUrl'],
      friends:
          List<Friend>.from(map['friends'].map((item) => Friend.fromMap(item)))
              .toList(),
      photos: List<Photo>.from(map['photos'].map((item) => Photo.fromMap(item)))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'username': username,
      'avatarUrl': avatarUrl,
      'friends': friends,
      'photos': photos,
    };
  }
}
