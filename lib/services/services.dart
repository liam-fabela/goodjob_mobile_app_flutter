import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/worker_model.dart';

class Services {
  static const URL = 'https://goodjob-mobile-app.000webhostapp.com/db_actions.php';

  static const _ADD_WORKER_ACTION = 'ADD_WORKER';
  static const _GET_WORKER_ACTION = 'GET_WORKER';

  static Future<List<Worker>> getWorker() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_WORKER_ACTION;
      final response = await http.post(URL, body:map);
      print('Get worker response: ${response.body}');
      if (200 == response.statusCode) {
        List<Worker> list = parseResponse(response.body);
        return list;
      }else{
       return List<Worker>(); 
      }
    }catch(e) {
      return List<Worker>();
    }

  }
  static List<Worker> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Worker>((json) => Worker.fromJson(json)).toList();
  }

  static Future<String> addWorker (String lastname, String firstname, String birthdate, String address, String photo, String front, String back, int docId, String rqr, String username, String email, String password,) async{
      
      try{
      var map = Map<String, dynamic>();
      map['action'] =  _ADD_WORKER_ACTION;
      map['lname'] = lastname;
      map['fname'] = firstname;
      map['dob'] = birthdate;
      map['address'] = address;
      map['photo'] = photo;
      map['validIDfront'] = front;
      map['validIDback'] = back;
      map['docid'] = docId;
      map['docurqr'] = rqr;
      map['username'] = username;
      map['email'] = email;
      map['password'] = password;



      final response = await http.post(URL, body: map);
      print('Add worker Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
    }
    } catch (e) {
      return "error";
    }
  }


}