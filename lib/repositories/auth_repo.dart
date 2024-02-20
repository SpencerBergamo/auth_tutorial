import 'dart:typed_data';

import 'package:auth_tutorial/repositories/storage_repo.dart';
import 'package:auth_tutorial/utils/active_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user details from firestore database
  Future<ActiveUser> getuserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return ActiveUser.fromSnap(snap);
  }

  // Email & Password Authentication
  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  // Email & Password Authentication
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  // Google Authentication
  Future<dynamic> signInWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();

    final googleAuth = await googleAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Finish collecting user profile data -- you can implement on a new screen
  Future<String> completeUserProfile({
    required String uid,
    required String email,
    required String name,
    required String username,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';
    try {
      String photoUrl = await StorageMethods()
          .uploadImageStorage('profilePicture', file, false);

      ActiveUser user = ActiveUser(
        id: _auth.currentUser!.uid,
        email: email,
        username: username,
        name: name,
        photoUrl: photoUrl,
        followers: [],
        following: [],
      );
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toJson());
    } catch (error) {
      throw Exception(error);
    }
    return res;
  }

  // instance.signOut();
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
