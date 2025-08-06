import 'package:cloud_firestore/cloud_firestore.dart';

class TrendingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getTrendingNews() {
    return _firestore
        .collection('trending')
        .where('description', isNotEqualTo: 'null')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
