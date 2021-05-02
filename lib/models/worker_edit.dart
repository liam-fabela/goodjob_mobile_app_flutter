class WorkerEdits{
  String wid;
  String bio;
  String profile;
  String zone;
  String barangay;
  String password;


  WorkerEdits({
    this.wid,
    this.bio,
    this.profile,
    this.zone,
    this.barangay,
    this.password,
  });

  factory WorkerEdits.fromJson(Map<String,dynamic>jsonData){
    return WorkerEdits(
      wid: jsonData['workerId'],
      bio: jsonData['bio'],
      profile: "https://goodjob-mobile-app.000webhostapp.com/worker_profile/" + jsonData['profile'],
      zone: jsonData['zone'],
      barangay: jsonData['barangay'],
      password: jsonData['password'],
    );
  }

}