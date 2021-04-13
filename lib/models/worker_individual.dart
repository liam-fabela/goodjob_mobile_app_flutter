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
      profile:  "http://192.168.43.152/db_php/worker_profile/" + jsonData['profile'],
      about: jsonData['bio'],
      badge:  "http://192.168.43.152/db_php/doc_img/" + jsonData['docImg'],
      rating: jsonData['rating'],
      review: jsonData['review'],
      docId: jsonData['docId'],
      uid: jsonData['uid'],
    );
  }
}