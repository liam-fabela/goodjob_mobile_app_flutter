class EventModel {
  String eventId;
  String date;
  String time;

  EventModel({
    this.eventId,
    this.date,
    this.time,
  });

  factory EventModel.fromJson(Map<String, dynamic>jsonData){
    return EventModel(
      eventId: jsonData['eventId'],
      date: jsonData['date'],
      time: jsonData['time'],
    );
  }
}
