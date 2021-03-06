class Worker {
  String workerId;
  String workerLastname;
  String workerFirstname;
  String workerBirthdate;
  String workerPortrait;
  String workerFrontID;
  String workerBackID;
  String workerDocID;
  String workerReqr;
  String workerUsername;
  String workerEmail;


  Worker({
    this.workerId,
    this.workerLastname,
    this.workerFirstname,
    this.workerBirthdate,
    this.workerPortrait,
    this.workerFrontID,
    this.workerBackID,
    this.workerDocID,
    this.workerReqr,
    this.workerUsername,
    this.workerEmail,

  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      workerId: json['worker_id'] as String,
      workerLastname: json['worker_lname'] as String,
      workerFirstname: json['worker_fname'] as String,
      workerBirthdate: json['worker_dob'] as String,
      workerPortrait: json['worker_photo'] as String,
      workerFrontID: json['worker_validIDfront'] as String,
      workerBackID: json['worker_validIDback'] as String,
      workerDocID: json['doc_id'] as String,
      workerReqr: json['worker_docurqr'] as String,
      workerUsername: json['worker_username'] as String,
      workerEmail: json['worker_email'] as String,
    );
  }
}
