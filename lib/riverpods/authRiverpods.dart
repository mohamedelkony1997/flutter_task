import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/network/firebaseAuth.dart';
import 'package:flutter_task/network/firestoreService.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  UserCredential? _usercredental;
  Map<String, dynamic> _userdata = {};
  fireBaseAuth auth = fireBaseAuth();
  fireStoreServices _services = fireStoreServices();
  UserCredential? get usercredental => _usercredental;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get userData => _userdata;
  Future<UserCredential?> loginUserWuthFirebase(
      String email, String password) async {
    setLoader(true);
    try {
      _usercredental = await auth.loginUserwithFirebase(email, password);
      setLoader(false);
      return _usercredental;
    } catch (e) {
      setLoader(false);
      return Future.error(e);
    }
  }

  Future<UserCredential?> signUpUserWithFirebase(
      String email, String password, String name) async {
    var isSucess = false;
    setLoader(true);
    _usercredental = await auth.signUpUserwithFirebase(name, email, password);
    final data = {
      "email": email,
      "name": name,
      "password": password,
      "Uid": _usercredental!.user!.uid,
      "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
    };
    String uid = _usercredental!.user!.uid;
    isSucess = await addDataTodataBase(data, "user", uid);
    if (isSucess) {
      return _usercredental;
    } else {
      throw Exception("error in signUp");
    }
  }

  Future<bool> addDataTodataBase(
      Map<String, dynamic> data, String collectionname, String docname) async {
    var value = false;
    try {
      await _services.addDataToFireStore(data, collectionname, docname);
      value = true;
    } catch (e) {
      value = false;
    }
    return value;
  }

  setLoader(bool loader) {
    _isLoading = loader;
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
