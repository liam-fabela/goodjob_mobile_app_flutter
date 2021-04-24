class CustomerProfile {
  String id;
  String lname;
  String fname;
  String zone;
  String barangay;
  String city;
  String profile;

  CustomerProfile({
    this.id,
    this.lname,
    this.fname,
    this.zone,
    this.barangay,
    this.city,
    this.profile,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic>jsonData) {
    return CustomerProfile(
      id: jsonData['id'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      zone: jsonData['zone'],
      barangay: jsonData['barangay'],
      city: jsonData['city'],
      //https://goodjob-mobile-app.000webhostapp.com/
      //http://192.168.18.69/system/template/mobile-web-images
      profile: "https://goodjob-mobile-app.000webhostapp.com/customer_profile/"+jsonData['profile'],
    );
  }
}