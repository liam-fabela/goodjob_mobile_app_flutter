class CustomerChatroom{
  String workerId;
  String lname;
  String fname;
  String profile;
  String uid;
  String update;

  CustomerChatroom({
    this.workerId,
    this.lname,
    this.fname,
    this.profile,
    this.uid,
    this.update,
  });

  factory CustomerChatroom.fromJson(Map<String, dynamic>jsonData){
    return CustomerChatroom(
      workerId: jsonData['id'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      //http://192.168.18.69/system/template/mobile-web-images/
      profile: "https://goodjob-mobile-app.000webhostapp.com/worker_profile/"+jsonData['profile'],
      uid: jsonData['chatId'],
      update: jsonData['update'],
    );
  }
}