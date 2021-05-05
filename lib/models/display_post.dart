class DisplayPost{
  String workPostId;
  String customerId;
  String lname;
  String fname;
  String profile;
  String catId;
  String catType;
  String date;
  String startTime;
  String endTime;
  String location;
  String details;
  String budget;
  String type;
  String createdOn;
  String respond;

  DisplayPost({
    this.workPostId,
    this.customerId,
    this.lname,
    this.fname,
    this.profile,
    this.catId,
    this.catType,
    this.date,
    this.startTime,
    this.endTime,
    this.location,
    this.details,
    this.budget,
    this.type,
    this.createdOn,
    this.respond,
  });

  factory DisplayPost.fromJson(Map<String, dynamic>jsonData){
    return DisplayPost(
      workPostId: jsonData['workPostId'],
      customerId: jsonData['customerId'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      profile: "https://goodjob-mobile-app.000webhostapp.com/customer_profile/"+jsonData['profile'],
      catId: jsonData['catId'],
      catType: jsonData['catType'],
      date: jsonData['date'],
      startTime: jsonData['startTime'],
      endTime: jsonData['endTime'],
      location: jsonData['location'],
      details: jsonData['details'],
      budget: jsonData['budget'],
      type: jsonData['type'],
      createdOn: jsonData['createdOn'],
      respond: jsonData['respond'],
    );
  }
}