import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/worker_model.dart';

class WorkerProvider with ChangeNotifier {

  List<Worker> _person = [];
  static const url = 'https://goodjob-mobile-app.000webhostapp.com/login.php';


  List<Worker> get person {
    return [..._person];
  }

   static Future<List<Worker>> getWorker(String email, String pass) async {
    try {
      var map = Map<String, dynamic>();
     // map['action'] = _GET_WORKER_ACTION;
      map['searchEmail'] = email;
      map['searchPass'] = pass;

      final response = await http.post(url, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
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
    
     
  

}