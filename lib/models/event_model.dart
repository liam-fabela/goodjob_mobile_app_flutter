class EventModel {
  String eventId;
  String date;
  String time;
  String time2;

  EventModel({
    this.eventId,
    this.date,
    this.time,
    this.time2,
  });

  factory EventModel.fromJson(Map<String, dynamic>jsonData){
    return EventModel(
      eventId: jsonData['eventId'],
      date: jsonData['date'],
      time: jsonData['time'],
      time2: jsonData['time2'],
    );
  }
}
