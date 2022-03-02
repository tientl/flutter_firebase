
class APIPath{
  static String job(String uid,String jobId) => '/User/$uid/Job/$jobId';
  static String jobs(String uid)=> '/User/$uid/Job';
}