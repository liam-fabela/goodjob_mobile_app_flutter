import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geocoding/geocoding.dart';


import '../styles/style.dart';
import '../widget/category_choices.dart';

class CreatePostModal extends StatefulWidget {
  static const routeName = '/post_job';
  @override
  _CreatePostModalState createState() => _CreatePostModalState();
}

class _CreatePostModalState extends State<CreatePostModal> {
  int _choice;
  int _choice2;
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


  //Position _currentPosition;
  //String _currentAddress;


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
