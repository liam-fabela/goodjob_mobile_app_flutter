class CustomerProfile {
  String id;
  String lname;
  String fname;
  String zone;
  String barangay;
  String city;

  CustomerProfile({
    this.id,
    this.lname,
    this.fname,
    this.zone,
    this.barangay,
    this.city,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic>jsonData) {
    return CustomerProfile(
      id: jsonData['id'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      zone: jsonData['zone'],
      barangay: jsonData['barangay'],
      city: jsonData['city'],
    );
  }
}