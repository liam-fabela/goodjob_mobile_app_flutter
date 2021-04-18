class WorkerProfile{
  String id;
  String lname;
  String fname;
  String zone;
  String barangay;
  String city;
  String profile;
  String uid;

  WorkerProfile({
    this.id,
    this.lname,
    this.fname,
    this.zone,
    this.barangay,
    this.city,
    this.profile,
    this.uid,
  });

  factory WorkerProfile.fromJson(Map<String, dynamic>jsonData){
     return WorkerProfile(
       id: jsonData['id'],
       lname: jsonData['id'],
       fname: jsonData['id'],
       zone: jsonData['id'],
       barangay: jsonData['barangay'],
       city: jsonData['city'],
       profile: "https://goodjob-mobile-app.000webhostapp.com/customer_profile/" + jsonData['profile'],
       uid: jsonData['uid'],

     );
  }
}