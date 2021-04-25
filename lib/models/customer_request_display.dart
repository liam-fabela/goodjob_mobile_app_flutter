class CustomerRequests{
  String jobId;
  String lname;
  String fname;
  String category;
  String date;
  String startTime;
  String endTime;
  String location;
  String budget;
  String type;
  String details;
  String status;
  String reason;
  String profile;
  String updated;
  String uid;

  CustomerRequests({
    this.jobId,
    this.lname,
    this.fname,
    this.category,
    this.date,
    this.startTime,
    this.endTime,
    this.location,
    this.budget,
    this.type,
    this.details,
    this.status,
    this.reason,
    this.profile,
    this.updated,
    this.uid,
  });

   factory CustomerRequests.fromJson(Map<String,dynamic>jsonData) {
     return CustomerRequests(
       jobId: jsonData['jobId'],
       lname: jsonData['lname'],
       fname: jsonData['fname'],
       category: jsonData['category'],
       date: jsonData['date'],
       startTime: jsonData['startTime'],
       endTime: jsonData['endTime'],
       location: jsonData['location'],
       budget: jsonData['budget'],
       type: jsonData['type'],
       details: jsonData['details'],
       status: jsonData['status'],
       reason: jsonData['reason'],
       profile: "https://goodjob-mobile-app.000webhostapp.com/worker_profile/"+jsonData['profile'],
       updated: jsonData['updated'],
       uid: jsonData['uid'],
     );
   }
}