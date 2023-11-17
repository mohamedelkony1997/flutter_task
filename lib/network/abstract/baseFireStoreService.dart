abstract class BaseFireStoreService {
  Future addDataToFireStore(
      Map<String, dynamic> data, String coolectionName, String docName);

  Future updateDataToFireStore(
      Map<String, dynamic> data, String coolectionName, String docName);
  Future getUserdatafromFirestore(String collectionname, String docname);
}
