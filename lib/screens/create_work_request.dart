import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../styles/style.dart';
//import 'address_screen.dart';
import '../services/services.dart';
import 'package:ntp/ntp.dart';
//import 'worker_profile_details.dart';

class CreateWorkRequest extends StatefulWidget {
  final int wid;
  final int cid;
  final int cat;
  CreateWorkRequest(this.wid, this.cid, this.cat);
  @override
  _CreateWorkRequestState createState() => _CreateWorkRequestState();
}

class _CreateWorkRequestState extends State<CreateWorkRequest> {
  String _choice2;
  var _perHour = false;
  var _perWork = false;
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;
  final formKey = GlobalKey<FormState>();
  String formatted;
  final TextEditingController _time = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _details = TextEditingController();
  final TextEditingController _budget = TextEditingController();
  var _isLoading = false;

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
      _choice2 = 'per hour';
    } else if (state && option == 'work') {
      _choice2 = 'per work';
    } else {
      _choice2 = null;
    }
    print(_choice2);
  }

  void _clearFields(){
    _dateController.clear();
    _time.clear();
    _location.clear();
    _budget.clear();
    _details.clear();
  }

  _sendRequest(int wid, int cid, int cat, String date, String time,
      String location, String details, String budg, String choice) async {
        String id = wid.toString();
    setState(() {
      _isLoading = true;
    });
    try {
      double bud = double.parse(_budget.text);
      String stat = 'pending';
      var req = await NTP.now();
      String rd = req.toString();

      await Services.createWorkRequest(
              wid,
              cid,
              cat,
              formatted,
              _time.text,
              _location.text,
              _details.text,
              bud,
              _choice2,
              stat,
              rd)
          .then((value) {
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
                Text(
                    'Your request is already sent. Please await for the worker\'s response.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Create Request'),
      body: SingleChildScrollView(
        child: _isLoading
            ? Container(
              height: MediaQuery.of(context).size.height,
              child: 
            Column(
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
                          'Sending Request',
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
              ),
        )
            : Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 0,
                    left: 15,
                    right: 15,
                    bottom: 15,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _dateController,
                          decoration: inputDeco('Date:'),
                          readOnly: true,
                          onTap: _presentDatePicker,
                        ),
                        TextFormField(
                          controller: _time,
                          decoration: inputDeco('Time:'),
                        ),
                        TextFormField(
                          controller: _location,
                          decoration: inputDeco('Location:'),
                        ),
                        TextFormField(
                          controller: _details,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: inputDeco('Enter Job details:'),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
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
                        Divider(),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            //                  Expanded(
                            //                    child: GestureDetector(
                            //                      onTap: () {
                            //                        Navigator.of(context).push(
                            //                          MaterialPageRoute(
                            //                            fullscreenDialog: true,
                            //                            builder: (ctx) => AddressScreen(),
                            //                          ),
                            //                        );
                            //                      },
                            //                      child: Container(
                            //                        child: Column(
                            //                          children: [
                            //                            Icon(
                            //                              Icons.location_pin,
                            //                              size: 20,
                            //                              color: Color.fromRGBO(62, 135, 148, 1),
                            //                            ),
                            //                            Row(
                            //                              mainAxisAlignment: MainAxisAlignment.center,
                            //                              children: [
                            //                                Text(
                            //                                  'Add your location',
                            //                                  style: TextStyle(
                            //                                    fontSize: 10,
                            //                                    fontFamily: 'Raleway',
                            //                                    color: const Color.fromRGBO(
                            //                                        62, 135, 148, 1),
                            //                                  ),
                            //                                ),
                            //                              ],
                            //                            ),
                            //                         ],
                            //                       ),
                            //                    ),
                            //                  ),
                            //                ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    _sendRequest(
                                        widget.wid,
                                        widget.cid,
                                        widget.cat,
                                        formatted,
                                        _time.text,
                                        _location.text,
                                        _details.text,
                                        _budget.text,
                                        _choice2);
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
                                      'Send',
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
