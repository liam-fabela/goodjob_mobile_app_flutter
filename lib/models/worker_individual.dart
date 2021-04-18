class WorkerIndividual {
  String id;
  String lname;
  String fname;
  String zone;
  String barangay;
  String city;
  String profile;
  String about;
  String badge;
  String rating;
  String review;
  String docId;
  String uid;

  WorkerIndividual({
    this.id,
    this.lname,
    this.fname,
    this.zone,
    this.barangay,
    this.city,
    this.profile,
    this.about,
    this.badge,
    this.rating,
    this.review,
    this.docId,
    this.uid,
  });

  factory WorkerIndividual.fromJson(Map<String,dynamic>jsonData) {
    return WorkerIndividual(
      id: jsonData['id'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      zone: jsonData['zone'],
      barangay: jsonData['barangay'],
      city: jsonData['city'],
      profile:  "https://goodjob-mobile-app.000webhostapp.com/worker_profile/" + jsonData['profile'],
      about: jsonData['bio'],
      badge:  "https://goodjob-mobile-app.000webhostapp.com/doc_img/" + jsonData['docImg'],
      rating: jsonData['rating'],
      review: jsonData['review'],
      docId: jsonData['docId'],
      uid: jsonData['uid'],
    );
  }
}