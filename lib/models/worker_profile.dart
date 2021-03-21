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
  String rating;

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
    this.rating,
  });

  factory WorkerProfiles.fromJson(Map<String,dynamic>jsonData) {
    return WorkerProfiles(
      id: jsonData['id'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      zone: jsonData['zone'],
      barangay: jsonData['barangay'],
      city: jsonData['city'],
      badge: jsonData['doc_img'],
      profile: "http://192.168.43.152/db_php/worker_profile/"+jsonData['display_photo'],
      catType: jsonData['category_type'],
      rating: jsonData['rating'],
    );
  }
}