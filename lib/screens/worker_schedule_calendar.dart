import 'package:flutter/material.dart';


import 'package:table_calendar/table_calendar.dart';

import '../models/event_model.dart';
import '../services/services.dart';


class WorkerScheduleCalendar extends StatefulWidget {
  final String fname;
  final int id;
  WorkerScheduleCalendar(this.fname, this.id);
  @override
  _WorkerScheduleCalendarState createState() => _WorkerScheduleCalendarState();
}

class _WorkerScheduleCalendarState extends State<WorkerScheduleCalendar> {

  var _isLoading = false;
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  
  @override
  void initState() {
    _controller = CalendarController();
    _selectedEvents = [];
    _events = {};
    super.initState();
  }



  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> events) {
    
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      var dt = DateTime.parse(event.date);
      DateTime date = DateTime(dt.year, dt.month, dt.day, 12);
      if(data[date] == null) data[date] = [];
      data[date].add(event);
      print(data[date]);
    });
    return data;
  }

   appBarWidget(BuildContext context, String name) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.07;
    double progressBarHeight = 7;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight + progressBarHeight),
      child: AppBar(
        title: Text(name +" " + "schedules"),
        titleSpacing: 5,
        bottom: linearProgressBar(progressBarHeight),
      ),
    );
  }

  linearProgressBar(_height) {
    if (!_isLoading) {
      return null;
    }
    return PreferredSize(
      child: SizedBox(
        width: double.infinity,
        height: _height,
        child: LinearProgressIndicator(
          backgroundColor: Colors.cyanAccent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
      preferredSize: const Size.fromHeight(0),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, widget.fname),
      body: FutureBuilder(
         future: Services.getEvent(widget.id),
         builder: (BuildContext context, AsyncSnapshot<List<EventModel>> snapshot ){
           if(snapshot.connectionState == ConnectionState.done){
              List<EventModel> allEvents = snapshot.data;
              if(allEvents.isNotEmpty){
                _events = _groupEvents(allEvents);
               
              }else{
                _events = {};
                _selectedEvents = [];
                
              }
            }else if(snapshot.hasError){
              return Center(child: CircularProgressIndicator());

            }
              print("SNAPSHOT IS NOT EMPTY");
                return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                events: _events,
                calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Color.fromRGBO(45, 194, 164, 1),
                  selectedColor: Color.fromRGBO(44, 139, 148, 1),
                ),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                ),          
                onDaySelected: (date, events, holidays){
  
                  setState(() {
                    _selectedEvents = events;
                  });
                  print(date.toIso8601String());
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events){
                    return Container(
                      margin: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(44, 139, 148, 1),
                       // shape: BoxShape.circle,
                       borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(date.day.toString(), style: TextStyle(
                        color: Colors.white,
                      )),
                    );
                  },
                  todayDayBuilder: (context, date, events){
                     return Container(
                      margin: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 194, 164, 1),
                         borderRadius: BorderRadius.circular(10),
                        //shape: BoxShape.rectangle,
                      ),
                      child: Text(date.day.toString(), style: TextStyle(
                        color: Colors.white,
                      )),
                    );
                  }
                ),
                calendarController: _controller,
              ),
              ..._selectedEvents.map((e) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromRGBO(80,152,179,1),),
                child: ListTile(
                  title: Text(e.time, style: TextStyle(color: Colors.white),),
                  subtitle: Text("Task " +e.eventId, style: TextStyle(color: Colors.white),),
                ),
              )),
            ]
          ),);

         }
      ),
      
    );
  }
}