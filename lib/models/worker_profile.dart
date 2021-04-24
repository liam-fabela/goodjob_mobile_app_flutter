class WorkerProfiles {
  String id;
  String lname;
  String fname;
  String zone;
  String barangay;
  String city;
  String badge;
  String profile;
  String catType;
  String bio;
  String email;
  String uid;
  String catId;
 // String rating;

  WorkerProfiles ({
    this.id,
    this.lname,
    this.fname,
    this.zone,
    this.barangay,
    this.city,
    this.badge,
    this.profile,
    this.catType,
    this.bio,
    this.email,
    this.uid,
    this.catId,
   // this.rating,
  });

  factory WorkerProfiles.fromJson(Map<String,dynamic>jsonData) {
    return WorkerProfiles(
      id: jsonData['id'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      zone: jsonData['zone'],
      barangay: jsonData['barangay'],
      city: jsonData['city'],
      //https://goodjob-mobile-app.000webhostapp.com/
      //http://192.168.18.69/system/db_php/
      //http://192.168.18.69/system/template/mobile-web-images/
      badge: "https://goodjob-mobile-app.000webhostapp.com/doc_img/"+jsonData['doc_img'],
      profile: "https://goodjob-mobile-app.000webhostapp.com/worker_profile/"+jsonData['display_photo'],
      catType: jsonData['cat_type'],
      bio: jsonData['bio'],
      email: jsonData['email'],
      uid: jsonData['uid'],
      catId: jsonData['catId'],
     // rating: jsonData['rating'],
    );
  }
}