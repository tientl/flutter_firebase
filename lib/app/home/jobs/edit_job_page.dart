//@dart=2.9
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app/CutomizeControl/show_alert_Dialog.dart';
import 'package:untitled/app/home/models/Job.dart';
import 'package:untitled/app/service/database.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key, @required this.database, this.job})
      : super(key: key);
  final Database database;
  final Job job;

  static Future<void> show(BuildContext context, {Job job}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditJobPage(database: database, job: job,),
          fullscreenDialog: true,
        )
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _rateperhour;

  @override
  void initState(){
    super.initState();
    if(widget.job != null){
      _name = widget.job.name;
      _rateperhour = widget.job.rateperhour;
    }
  }
  bool _validateAndSaveForm(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async{
    if(_validateAndSaveForm()){
      try{
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job)=> job.name).toList();
        if(widget.job != null){
          allNames.remove(widget.job.name);
        }
        if(allNames.contains(_name)){
          showAlertDialog(context,
              title: 'Name already used',
              content: 'Please choose a different job name',
              defaultActionText: 'Ok');
        }
        else{
          final id = widget.job?.id?? documentIdFromCurrentDate();
          final job = Job(id: id, name: _name, rateperhour:_rateperhour);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
        }
      }on FirebaseException catch(e)
    {
      if(e.code != 'permission denied'){
        showAlertDialog(context,
            title: 'Operation failed',
            content: e.toString(),
            defaultActionText: 'OK');
      }
      else{
        showAlertDialog(context,
            title: 'Denied',
            content: 'You don\'t have to permission to access',
            defaultActionText: 'OK');
      }
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(widget.job == null? 'New job': 'Edit job'),
        actions: [
          ElevatedButton(onPressed: _submit, child: Text('Save'))
        ],
      ),
      body: _buildConTents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildConTents(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildForm(),
          )
        ),
      ),
    );
  }

  Widget _buildForm(){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      )
    );
  }

  List<Widget> _buildFormChildren(){
    return[
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Job name',
        ),
        initialValue: _name,
        validator: (value)=>value.isNotEmpty? null : 'Name can\'t be empty!',
        onSaved: (value)=> _name = value,
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Rate per hour'
        ),
        initialValue: _rateperhour != null? '$_rateperhour': null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value)=> _rateperhour = int.tryParse(value)??0,
      )
    ];
  }
}


