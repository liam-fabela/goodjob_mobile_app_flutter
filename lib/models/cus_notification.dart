class CustomerNotification{
  String wid;
  String cid;
  String workId;
  String lname;
  String fname;
  String sent;
  String profile;
  String catType;
  String catId;
  String uid;

  CustomerNotification({
    this.wid,
    this.cid,
    this.workId,
    this.lname,
    this.fname,
    this.sent,
    this.profile,
    this.catType,
    this.catId,
    this.uid,
  });

  factory CustomerNotification.fromJson(Map<String, dynamic>jsonData){
    return CustomerNotification(
      wid: jsonData['wid'],
      cid: jsonData['cid'],
      workId: jsonData['workId'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      sent: jsonData['sent'],
      profile: "https://goodjob-mobile-app.000webhostapp.com/worker_profile/"+jsonData['profile'],
      catType: jsonData['catType'],

    );
}
}