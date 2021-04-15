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
      profile: "http://192.168.43.152/db_php/worker_profile/"+jsonData['profile'],
      uid: jsonData['chatId'],
      update: jsonData['update'],
    );
  }
}