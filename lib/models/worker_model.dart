class Worker {
  String workerId;
  String workerLastname;
  String workerFirstname;
  String workerBirthdate;
  String workerZone;
  String workerBarangay;
  String workerCity;
  String workerPortrait;
  String workerFrontID;
  String workerBackID;
  String workerDocID;
  String workerReqr;
  String workerUsername;
  String workerEmail;
  String workerPassword;


  Worker({
    this.workerId,
    this.workerLastname,
    this.workerFirstname,
    this.workerBirthdate,
    this.workerZone,
    this.workerBarangay,
    this.workerCity,
    this.workerDocID,
    this.workerUsername,
    
   

  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      workerId: json['worker_id'] as String,
      workerLastname: json['worker_lname'] as String,
      workerFirstname: json['worker_fname'] as String,
      workerBirthdate: json['worker_dob'] as String,
      workerZone: json['worker_zone'] as String,
      workerBarangay: json['worker_barangay'] as String,
      workerCity: json['worker_city'] as String,
    );
  }
}
