class WorkerFinishedRequests {
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
  String updated;
  String status;
  String time;

  WorkerFinishedRequests ({
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
    this.updated,
    this.status,
    this.time,
  });

  factory WorkerFinishedRequests.fromJson(Map<String,dynamic>jsonData) {
     return WorkerFinishedRequests(
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
       updated: jsonData['updated'],
       status: jsonData['status'],
       time: jsonData['time'],
      
     );
   }

}