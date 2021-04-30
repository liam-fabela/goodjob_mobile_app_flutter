class WorkerEarning{
  String workerId;
  String earnings;
  String updated;

  WorkerEarning({
    this.workerId,
    this.earnings,
    this.updated,
  });

  factory WorkerEarning.fromJson(Map<String,dynamic>jsonData){
    return WorkerEarning(
      workerId: jsonData['workerId'],
      earnings: jsonData['earnings'],
      updated: jsonData['updated'],
    );
  }
}