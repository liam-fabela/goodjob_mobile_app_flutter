class CustomerChatroom{
  String workerId;
  String lname;
  String fname;
  String profile;
  String uid;

  CustomerChatroom({
    this.workerId,
    this.lname,
    this.fname,
    this.profile,
    this.uid,
  });

  factory CustomerChatroom.fromJson(Map<String, dynamic>jsonData){
    return CustomerChatroom(
      workerId: jsonData['id'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      profile: "http://192.168.43.152/db_php/customer_chatrooms.php/"+jsonData['profile'],
      uid: jsonData['chatId'],
    );
  }
}