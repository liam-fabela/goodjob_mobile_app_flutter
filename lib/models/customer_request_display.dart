class CustomerRequests{
  String jobId;
  String lname;
  String fname;
  String category;
  String date;
  String startTime;
  String endTime;
  String status;

  CustomerRequests({
    this.jobId,
    this.lname,
    this.fname,
    this.category,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
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
       status: jsonData['status'],
     );
   }
}