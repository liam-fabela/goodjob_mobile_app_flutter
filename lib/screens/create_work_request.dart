import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles/style.dart';
import 'address_screen.dart';

class CreateWorkRequest extends StatefulWidget {
  @override
  _CreateWorkRequestState createState() => _CreateWorkRequestState();
}

class _CreateWorkRequestState extends State<CreateWorkRequest> {
  int _choice2;
  var _perHour = false;
  var _perWork = false;
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;
  final formKey = GlobalKey<FormState>();
  String formatted;

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
      _choice2 = 1;
    } else if (state && option == 'work') {
      _choice2 = 2;
    } else {
      _choice2 = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Create Request'),
      body: SingleChildScrollView(
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
              child: Column(
                children: [
                  TextFormField(
                    controller: _dateController,
                    decoration: inputDeco('Date:'),
                    readOnly: true,
                    onTap: _presentDatePicker,
                  ),
                  TextFormField(
                    decoration: inputDeco('Time:'),
                  ),
                  TextFormField(
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: inputDeco('Enter Job details:'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
                              label: Text('hour', style: addressStyle2()),
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
                              selectedColor: Color.fromRGBO(62, 135, 148, 1),
                            ),
                            ChoiceChip(
                              label: Text('work', style: addressStyle2()),
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
                                        _getBudget(_perHour, 'work');
                                      });
                                    }
                                  : null,
                              selectedColor: Color.fromRGBO(62, 135, 148, 1),
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
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (ctx) => AddressScreen(),
                              ),
                            );
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 20,
                                  color: Color.fromRGBO(62, 135, 148, 1),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Add your location',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Raleway',
                                        color: const Color.fromRGBO(
                                            62, 135, 148, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.3,
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
