class WorkerAcceptedRequests {
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
  String profile;
  String requested;
  String uid;

  WorkerAcceptedRequests({
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
    this.profile,
    this.requested,
    this.uid,
  });

  factory WorkerAcceptedRequests.fromJson(Map<String,dynamic>jsonData) {
     return WorkerAcceptedRequests(
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
       profile: "https://goodjob-mobile-app.000webhostapp.com/customer_profile/" + jsonData['profile'],
       requested: jsonData['requested'],
       uid: jsonData['uid'],
      
     );
   }

}