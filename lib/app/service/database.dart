//@dart=2.9

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/app/home/models/Job.dart';
import 'package:untitled/app/service/api_path.dart';
import 'package:untitled/app/service/firestore_services.dart';

abstract class Database{
  Future<void> setJob(Job job);
  Future<void> deleteJob(Job job);
  void readJobs();
  Stream<List<Job>> jobsStream();
}

String documentIdFromCurrentDate()=> DateTime.now().toIso8601String();

class FirestoreDatabase implements Database{
  FirestoreDatabase({@required this.uid}): assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void>setJob(Job job)=>
      _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMapp(),
      );
  @override
  Future<void> deleteJob(Job job) => FirestoreService.instance.deleteData(
    path: APIPath.job(uid, job.id),
  );
  @override
  void readJobs(){
    final path = APIPath.jobs(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    snapshots.listen((snapshots){
      snapshots.docs.forEach((snapshot) {
        print(snapshot.data());
      });
    });
  }
  @override
  Stream<List<Job>> jobsStream()=>
      _service.collectionSteam(
          path: APIPath.jobs(uid),
          builder: (data, documentId) =>Job.formMap(data, documentId)
      );


}