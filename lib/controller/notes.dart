import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firePath = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection('notes');

Future addNote(Map<String, dynamic> data) async {
  //save to firebase
  await firePath.add(data);
}

Future<QuerySnapshot<Object?>> getData() async {
  return await firePath.orderBy('created').get();
}

Future deleteNote(String dataUrl) async {
  await firePath.doc(dataUrl).delete();
}
