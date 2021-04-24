class WorkerChatroom{
   String workerId;
  String lname;
  String fname;
  String profile;
  String uid;
  String update;

  WorkerChatroom({
    this.workerId,
    this.lname,
    this.fname,
    this.profile,
    this.uid,
    this.update,
  });

  factory WorkerChatroom.fromJson(Map<String, dynamic>jsonData){
    return WorkerChatroom(
      workerId: jsonData['id'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      //https://goodjob-mobile-app.000webhostapp.com/
      //http://192.168.18.69/system/template/mobile-web-images/
      profile: "https://goodjob-mobile-app.000webhostapp.com/customer_profile/"+jsonData['profile'],
      uid: jsonData['chatId'],
      update: jsonData['update'],
    );
  }
}