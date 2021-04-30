class WorkerEdits{
  String wid;
  String bio;
  String profile;


  WorkerEdits({
    this.wid,
    this.bio,
    this.profile,
  });

  factory WorkerEdits.fromJson(Map<String,dynamic>jsonData){
    return WorkerEdits(
      wid: jsonData['workerId'],
      bio: jsonData['bio'],
      profile: "https://goodjob-mobile-app.000webhostapp.com/worker_profile/" + jsonData['profile'],
    );
  }

}