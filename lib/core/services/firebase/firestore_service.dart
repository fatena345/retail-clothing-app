import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _col(String path) =>
      _db.collection(path);

  // ---------------- Create ----------------
  Future<void> setDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
    bool merge = false,
  }) =>
      _col(collectionPath).doc(documentId).set(data, SetOptions(merge: merge));

  /// إضافة document بـ id تلقائي، بترجع الـ id
  Future<String> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    final ref = await _col(collectionPath).add(data);
    return ref.id;
  }

  // ---------------- Read ----------------
  Future<Map<String, dynamic>?> getDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    final snap = await _col(collectionPath).doc(documentId).get();
    return snap.data();
  }

  Future<List<Map<String, dynamic>>> getCollectionData({
    required String collectionPath,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> q)? query,
  }) async {
    Query<Map<String, dynamic>> q = _col(collectionPath);
    if (query != null) q = query(q);
    final snap = await q.get();
    return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
  }

  Stream<Map<String, dynamic>?> watchDocument({
    required String collectionPath,
    required String documentId,
  }) =>
      _col(collectionPath).doc(documentId).snapshots().map((s) => s.data());

  // ---------------- Update ----------------
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) =>
      _col(collectionPath).doc(documentId).update(data);

  // ---------------- Delete ----------------
  Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  }) =>
      _col(collectionPath).doc(documentId).delete();


Stream<List<Map<String, dynamic>>> watchCollection({
  required String collectionPath,
  Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> q)? query,
}) {
  Query<Map<String, dynamic>> q = _col(collectionPath);
  if (query != null) q = query(q);
  return q.snapshots().map(
        (snap) => snap.docs.map((d) => {'id': d.id, ...d.data()}).toList(),
      );
}


Future<void> deleteDocuments({
  required String collectionPath,
  required List<String> documentIds,
}) async {
  final batch = _db.batch();
  for (final id in documentIds) {
    batch.delete(_col(collectionPath).doc(id));
  }
  await batch.commit();
}
}