//@dart=2.9

import 'package:flutter/cupertino.dart';

class Job{
  Job({@required this.id,@required this.name, @required this.rateperhour});
  final String id;
  final String name;
  final int rateperhour;

  factory Job.formMap(Map<String, dynamic> data, String documentId){
    if(data == null){
      return null;
    }
    final String name = data['name'];
    final int rateperhoure = data['rateperhour'];
    return Job(
        id: documentId,
        name: name,
        rateperhour: rateperhoure);
  }

  Map<String, dynamic> toMapp(){
    return{
      'name': name,
      'rateperhour': rateperhour,
    };
  }
}