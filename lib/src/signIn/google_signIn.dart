import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  Map userData = {};

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(Function setUserData) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('users').get();
      String id = (snapshot.children.isEmpty
              ? 0
              : int.parse(snapshot.children.last.key.toString()) + 1)
          .toString();

      if (snapshot.exists) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref("users/" + id);

        await userRef.set({
          "userid": id,
          "name": googleUser.displayName!,
          "email": googleUser.email!,
        });
        setUserData({
          "userid": id,
          "name": googleUser.displayName!,
          "email": googleUser.email!,
        });
      } else {
        print('No data available.');
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
