//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService{
  FirestoreService._();
  static final instance = FirestoreService._();
  Future<void> setData({String path, Map<String , dynamic> data}) async{
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }

  Future<void> deleteData({@required String path}) async{
    final reference = FirebaseFirestore.instance.doc((path));
    print('delete: $path');
    await reference.delete();

  }

  Stream<List<T>> collectionSteam<T>({
    @required String path,
    @required T Function(Map<String, dynamic>data, String documentID) builder,
  }){
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot)=>
        snapshot.docs.map((snapshot)=> builder(snapshot.data(), snapshot.id),).toList()
    );

  }
}