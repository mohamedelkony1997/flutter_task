import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseFirebaseServices {
  bool isUserLogin();
  Future<UserCredential> signUpUserwithFirebase(
      String name, String email, String password);
  Future<UserCredential> loginUserwithFirebase(String email, String password);
  void LogOutUser();
  
}
