import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task/network/abstract/baseFirebaseServices.dart';

class fireBaseAuth extends BaseFirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void signOutUser() {
    auth.signOut();
  }

  @override
  Future<UserCredential> signUpUserwithFirebase(
      String name, String email, String password) {
    final userCredential =
        auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  Future<UserCredential> loginUserwithFirebase(String email, String password) {
    final userCredential =
        auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  bool isUserLogin() {
    // TODO: implement isUserLogin
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
