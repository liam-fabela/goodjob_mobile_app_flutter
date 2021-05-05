class CustomerEdits{
  String cid;
  String profile;
  String zone;
  String barangay;
  String password;


  CustomerEdits({
    this.cid,
    this.profile,
    this.zone,
    this.barangay,
    this.password,
  });

  factory CustomerEdits.fromJson(Map<String,dynamic>jsonData){
    return CustomerEdits(
      cid: jsonData['workerId'],
      profile: "https://goodjob-mobile-app.000webhostapp.com/worker_profile/" + jsonData['profile'],
      zone: jsonData['zone'],
      barangay: jsonData['barangay'],
      password: jsonData['password'],
    );
  }

}