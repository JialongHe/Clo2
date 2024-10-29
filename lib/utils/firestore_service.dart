import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveCarbonData(int carbonFootprint) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _db.collection('carbonData').doc(user.uid).set({
        'carbonFootprint': carbonFootprint,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<int?> getCarbonData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _db.collection('carbonData').doc(user.uid).get();;
      if (snapshot.exists) {
        return snapshot.data()?['carbonFootprint'] as int?;
      }
    }
    return null;
  }
}
