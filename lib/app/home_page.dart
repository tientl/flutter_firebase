//@dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app/home/jobs/empty_content.dart';
import 'package:untitled/app/service/auth_base.dart';
import 'package:untitled/app/service/database.dart';
import 'CutomizeControl/show_alert_Dialog.dart';
import 'home/jobs/edit_job_page.dart';
import 'home/jobs/job_list_title.dart';
import 'home/models/Job.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.onSignOut, @required this.auth})
      : super(key: key);
  final VoidCallback onSignOut;
  final AuthBase auth;

  Future<void> signOut() async {
    try {
      //await FirebaseAuth.instance.signOut();
      await auth.SignOut();
      onSignOut();
    }
    catch (e) {
      print(e.toString());
    }
  }
  Future<void> _confirmSignOut(BuildContext context) async{
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Log Out',
        content: 'you want to sign out?',
        cancelActionText: 'Cancel',
        defaultActionText: 'LogOut');
    if(didRequestSignOut == true){
      signOut();
    }
}
  // Future<void> _createJob(BuildContext context) async {
  //   final database = Provider.of<Database>(context, listen: false);
  //   await database.setJob(Job(
  //     name: 'Tien test',
  //     rateperhour: 22,
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          actions: [
            ElevatedButton(
              child: Text('Sign out'),
              onPressed:() {_confirmSignOut(context);},
            )
          ],
        ),
        body: _buildContents(context),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => EditJobPage.show(context),
        ),
      ),
    );
  }
}
Future<void> _delete(BuildContext context, Job job)async {
  final database = Provider.of<Database>(context, listen: false);
  await database.deleteJob(job);

}


Widget _buildContents(BuildContext context) {
  final database = Provider.of<Database>(context, listen: false);
  return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          if(jobs.isNotEmpty){
            final children = jobs.map((job) => Dismissible(
                    key: Key('job-${job.id}'),
                    background: Container(
                      color: Colors.red,
                    ),
                    direction: DismissDirection.endToStart,
                confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("DELETE"),
                          content: const Text(
                              "Are you sure want DELETE this?"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("Cancel")),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: ( direction) =>  _delete(context, job),
                    child: JobListTitle(
                      job: job,

                      onTap: () => EditJobPage.show(context, job: job),
                    )
                )).toList();
            return ListView(children: children);
        }
        return EmptyContent();
      }
      if(snapshot.hasError){
        return Center(child: Text('Some error occurred'));
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}


