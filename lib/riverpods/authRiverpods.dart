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
      // Fetch user data from Firestore and store it
      await fetchUserData(_usercredental!.user!.uid);
      setLoader(false);
      return _usercredental;
    } catch (e) {
      setLoader(false);
      return Future.error(e);
    }
  }

  Future<void> fetchUserData(String uid) async {
    try {
      _userdata = await _services.getUserdatafromFirestore("user", uid);
      print("User Data: $_userdata");
      print("User Dataaaaaaaaaa: $userData");
      notifyListeners();
    } catch (e) {
      print("Error fetching user data: $e");
      throw Exception("Error fetching user data");
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
Future<void> logout() async {
    try {
       auth.LogOutUser();
      _usercredental = null;
      _userdata = {};
      notifyListeners();
    } catch (e) {
      print("Error during logout: $e");
      throw Exception("Error during logout");
    }
  }
  setLoader(bool loader) {
    _isLoading = loader;
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
