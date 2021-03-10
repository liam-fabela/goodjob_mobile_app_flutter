import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/worker_model.dart';

class Services {
  static const url = 'https://goodjob-mobile-app.000webhostapp.com/db_actions.php';

  static const _ADD_WORKER_ACTION = 'ADD_WORKER';
  static const _GET_WORKER_ACTION = 'GET_WORKER';

  static Future<List<Worker>> getWorker() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_WORKER_ACTION;
      final response = await http.post(url, body:map);
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

  static Future<void> addWorker(String lname, String fname, String bdate, String street, String brgy, String photo, String base64Photo,String front, String base64Front, String back, String base64Back, int docuId, String rqr, String base64Doc,String usrname, String eml, String pass) async{
      String name = lname;
      String mapVal;
      var testMap = Map<String, dynamic>();
      print('muaagi sa dire');
    try{
      print('gisulod dne');
      var map = Map<String, dynamic>();

      //map['action'] =  _ADD_WORKER_ACTION;
      map["lastname"] = lname;
      map["firstname"] = fname;
      map["birthdate"] = bdate;
      map["zone"] = street;
      map["barangay"] = brgy;
      map["workerImage"] = photo;
      map["frontPic"] = base64Photo;
      map["workerValidFront"] = front;
      map["frontId"] = base64Front;
      map["workerValidBack"] = back;
      map["backId"] = base64Back;
      map["docId"] = docuId;
      map["workerdocu"] = rqr;
      map["docPic"] = base64Doc;
      map["username"] = usrname;
      map["email"] = eml;
      map["password"] = pass;
      mapVal = map["password"];
      //testMap = map;
      //print(map["lastname"]);
      //print(map["firstname"]);
      //print(map["birthdate"]);

      http.Response response = await http.post(url, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
      print('Add worker Response: ${response.body}');
      if (200 == response.statusCode) {
        print(response.body);
      } else {
       return "error";
    }
    } catch (e) {
      print(e);
      
     
     
    }
  }

  static void _printVal(String val) {
    print('ang sulod: $val');
  }

  static void _isEmp(Map map) {
    if(map.isEmpty){
      print('true');
    }else{
      print('NAAY SULOD!');
    }
  }

}