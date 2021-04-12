class JobPostingModel {
  String id;
  String category;
  String date;
  String time;
  String jobDetails;
  String budget;
  String location;

  JobPostingModel({
    this.id,
    this.category,
    this.date,
    this.time,
    this.jobDetails,
    this.budget,
    this.location,
  });

  factory JobPostingModel.fromJson(Map<String, dynamic>jsonData) {
    return JobPostingModel(
      id: jsonData['id'],
      category: jsonData['category'],
      date: jsonData['date'],
      time: jsonData['time'],
      jobDetails: jsonData['jobDetails'],
      budget: jsonData['budget'],
      location: jsonData['location'],
    );
  }
}