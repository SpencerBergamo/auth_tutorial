import 'package:auth_tutorial/data/models/user_model.dart';
import 'package:auth_tutorial/data/repositories/storage_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _user;
  UserModel? get user => _user;

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<String> completeProfile({
    required String uid,
    required String email,
    required String name,
    required String username,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String res = 'error';
    try {
      String photoUrl = await StorageMethods()
          .uploadImageStorage('profilePicture', file, false);

      UserModel userModel = UserModel(
        uid: uid,
        email: email,
        name: name,
        username: username,
        avatarUrl: photoUrl,
        friends: [],
        photos: [],
      );

      await _firestore.collection('users').doc(uid).set(userModel.toMap());
      return res = 'success';
    } catch (e) {
      debugPrint("COMPLETE PROFILE ERROR: $e");
    }
    return res;
  }

  Future<String> loadProfile() async {
    String res = 'error';
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot docSnap =
          await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (docSnap.exists) {
        _user = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
        notifyListeners();
        res = 'success';
      } else {
        res = 'no_user';
      }
    }
    return res;
  }
}
