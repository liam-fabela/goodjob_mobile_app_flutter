class WorkerDocu{
  String workerId;
  String docId;
  String docType;
  String docu;


  WorkerDocu({
    this.workerId,
    this.docId,
    this.docType,
    this.docu,
  });

 factory  WorkerDocu.fromJson(Map<String, dynamic>jsonData){
   return WorkerDocu(
     workerId: jsonData['workerId'],
    docId: jsonData['docId'],
    docType: jsonData['docType'],
    docu: "https://goodjob-mobile-app.000webhostapp.com/worker_requirements/" +jsonData['docu'],
   );
  }
}