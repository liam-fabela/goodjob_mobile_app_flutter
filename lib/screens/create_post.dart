import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geocoding/geocoding.dart';

import '../styles/style.dart';
import '../widget/category_choices.dart';
import '../services/services.dart';

class CreatePostModal extends StatefulWidget {
  static const routeName = '/post_job';
  final int id;
  CreatePostModal(this.id);
  @override
  _CreatePostModalState createState() => _CreatePostModalState();
}

class _CreatePostModalState extends State<CreatePostModal> {
  int _choice;
  String _choice2;
  var _perHour = false;
  var _perWork = false;
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;
  final formKey = GlobalKey<FormState>();
  String formatted;
  final TextEditingController _time1 = TextEditingController();
  final TextEditingController _time2 = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _details = TextEditingController();
  final TextEditingController _budget = TextEditingController();
  var _isLoading = false;
  String formattedStartTime;
  String formattedEndTime;
  TimeOfDay t1;
  TimeOfDay t2;
  //Position _currentPosition;
  //String _currentAddress;

  _presentTimePicker(int source) async {
    final now = DateTime.now();
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      if (source == 1) {
        setState(() {
          t1 = pickedTime;
          var time = '${t1.format(context)}';
          _time1.text = time;
        });
      }
      if (source == 2) {
        setState(() {
          t2 = pickedTime;
          var time = '${t2.format(context)}';
          _time2.text = time;
        });
      }
    });
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), //DateTime(1901, 1),
      lastDate: DateTime(2300, 1),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        var date = '${DateFormat.yMd().format(_selectedDate)}';
        _dateController.text = date;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        formatted = formatter.format(_selectedDate);
        print(formatted);
      });
    });
  }

  void _getBudget(bool state, String option) {
    if (state && option == 'hour') {
      _choice2 = 'per Hour';
    } else if (state && option == 'work') {
      _choice2 = 'per Work';
    } else {
      _choice2 = null;
    }
  }

  void getState(bool state, String option) {
    if (state && option == 'House chore') {
      _choice = 1;
    } else if (state && option == 'Personal errand') {
      _choice = 2;
    } else if (state && option == 'Beauty&Grooming') {
      _choice = 3;
    } else if (state && option == 'House repair') {
      _choice = 4;
    } else {
      _choice = null;
    }
    print('choice from main screen: $_choice');
  }

  void _clearFields() {
    _dateController.clear();
    _time1.clear();
    _time2.clear();
    _location.clear();
    _budget.clear();
    _details.clear();
  }

  _sendPost(int cid, int cat, String date, String time, String time2,
      String location, String details, String budget, String type) async {
    try {
      setState(() {
        _isLoading = true;
      });
      double bud = double.parse(_budget.text);
      String stat = 'posted';
      var req = await NTP.now();
      String createdOn = req.toString();
      await Services.createWorkPost(cid, cat, date, time, time2, location,
              details, bud, type, createdOn, stat)
          .then((val) {
        _clearFields();
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'Success!',
              style: TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                Text('Job posting is successfully created.'),
              ],
            )),
            actions: <Widget>[
              TextButton(
                child: Center(
                  child: Text(
                    'Ok',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Connection Error.',
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
              child: ListBody(
            children: [
              Text('Please check your connection and try again.'),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: Center(
                child: Text(
                  'Ok',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

//   _getCurrentLocation(){
  //   Geolocator
//    .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
//    .then((Position position){
//      setState((){
//        _currentPosition = position;
//        _getAddressFromLatLng();
//      });
//    }).catchError((e){
//      print (e);
//    });
//  }

  // _getAddressFromLatLng() async{
  //   try{
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       _currentPosition.latitude,
  //       _currentPosition.longitude,
  //     );
  //     Placemark place = placemarks[0];

//      setState((){
//        _currentAddress = '${place.name},${place.subLocality},${place.locality}, ${place.postalCode}, ${place.country}';
//      });
//    }catch(e){
//      print(e);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Create Job Post'),
      body: _isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SpinKitSquareCircle(
                      color: Color.fromRGBO(62, 135, 148, 1), size: 50.0),
                ),
                SizedBox(height: 35),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Creating Job Posting...',
                        style: TextStyle(
                          color: Colors.white54,
                          fontFamily: 'Raleway',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 0,
                    left: 15,
                    right: 15,
                    bottom: 15,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Choose a Date' : null;
                          },
                          controller: _dateController,
                          decoration: inputDeco('Date:'),
                          readOnly: true,
                          onTap: _presentDatePicker,
                        ),
                        TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Choose a Time' : null;
                          },
                          controller: _time1,
                          decoration: inputDeco('*Start Time:'),
                          readOnly: true,
                          onTap: () {
                            _presentTimePicker(1);
                          },
                        ),
                        TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Choose a Time' : null;
                          },
                          controller: _time2,
                          decoration: inputDeco('End Time:'),
                          readOnly: true,
                          onTap: () {
                            _presentTimePicker(2);
                          },
                        ),
                        TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Enter Address' : null;
                          },
                          controller: _location,
                          decoration: inputDeco('Complete Address:'),
                        ),
                        TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Enter Details' : null;
                          },
                          controller: _details,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: inputDeco('*Enter Job details:'),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (val) {
                                  return val.isEmpty
                                      ? 'Please Enter Budget'
                                      : null;
                                },
                                controller: _budget,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: inputDeco('Budget:'),
                              ),
                            ),
                            Text(
                              'per',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: 'Raleway'),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Wrap(
                                spacing: 2,
                                // runSpacing: 2,
                                children: [
                                  ChoiceChip(
                                    label: Text('hour', style: addressStyle3()),
                                    selected: _perHour,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(62, 135, 140, 0.5),
                                    onSelected: !_perWork
                                        ? (val) {
                                            setState(() {
                                              _perHour = !_perHour;
                                              _getBudget(_perHour, 'hour');
                                            });
                                          }
                                        : null,
                                    selectedColor:
                                        Color.fromRGBO(62, 135, 148, 1),
                                  ),
                                  ChoiceChip(
                                    label: Text('work', style: addressStyle3()),
                                    selected: _perWork,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(62, 135, 140, 0.5),
                                    onSelected: !_perHour
                                        ? (val) {
                                            setState(() {
                                              _perWork = !_perWork;
                                              _getBudget(_perWork, 'work');
                                            });
                                          }
                                        : null,
                                    selectedColor:
                                        Color.fromRGBO(62, 135, 148, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('Choose a Category: ',
                            style: addressStyle(), textAlign: TextAlign.left),
                        CategoryChoices(getState),
                        Divider(),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            //                   Expanded(
                            //                     child: Column(
                            //                       children: [
                            //                          Icon(
                            //                            Icons.location_pin,
                            //                            size: 20,
                            //                            color: Color.fromRGBO(62, 135, 148, 1),
                            //                          ),
                            //                          Row(
                            //                            mainAxisAlignment: MainAxisAlignment.center,
                            //                            children: [
                            //                              Text(
                            //                                'Add your location',
                            //                                style: TextStyle(
                            //                                  fontSize: 10,
                            //                                 fontFamily: 'Raleway',
                            //                                  color:
                            //                                      const Color.fromRGBO(62, 135, 148, 1),
                            //                                ),
                            //                              ),
                            //                               SizedBox(width: 2),
                            //                              Text(
                            //                                '(optional)',
                            //                                style: TextStyle(
                            //                                  fontSize: 8,
                            //                                  fontFamily: 'Raleway',
                            //                                  color: Colors.black54,
                            //                                ),
                            //                              ),
                            //                            ],
                            //                          ),
                            //                        ],
                            //                      ),
                            //                    ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (formKey.currentState.validate()) {
                                      if (_choice == null) {
                                        Fluttertoast.showToast(
                                            msg: "Please choose a category.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                            fontSize: 14);
                                            return;
                                      }
                                      if(_choice2 == null){
                                         Fluttertoast.showToast(
                                            msg: "Please choose a work type.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                            fontSize: 14);
                                             return;
                                      }
                                      await _sendPost(
                                          widget.id,
                                          _choice,
                                          formatted,
                                          _time1.text,
                                          _time2.text,
                                          _location.text,
                                          _details.text,
                                          _budget.text,
                                          _choice2);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(62, 135, 148, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Post',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
