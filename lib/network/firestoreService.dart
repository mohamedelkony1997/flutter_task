import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_task/network/abstract/baseFireStoreService.dart';

class fireStoreServices extends BaseFireStoreService {
  final _firestoreInstance = FirebaseFirestore.instance;
  @override
  Future addDataToFireStore(
      Map<String, dynamic> data, String coolectionName, String docName) async {
    // TODO: implement addDataToFireStore
    try {
      await _firestoreInstance
          .collection(coolectionName)
          .doc(docName)
          .set(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future updateDataToFireStore(
      Map<String, dynamic> data, String coolectionName, String docName) async{
    try {
     await _firestoreInstance
          .collection(coolectionName)
          .doc(docName)
          .update(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future getUserdatafromFirestore(String collectionname, String docname) async {
    // TODO: implement getUserdatafromFirestore
    try {
      final userData = await _firestoreInstance
          .collection(collectionname)
          .doc(docname)
          .get();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
