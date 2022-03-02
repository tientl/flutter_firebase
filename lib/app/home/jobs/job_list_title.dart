//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/home/models/Job.dart';
import 'edit_job_page.dart';

class JobListTitle extends StatelessWidget{
  const JobListTitle({Key key, @required this.job, this.onTap}): super(key: key);
  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
      onTap: () => EditJobPage.show(context, job: job),
    );
  }
}

