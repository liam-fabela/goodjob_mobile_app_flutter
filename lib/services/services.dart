import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/worker_profile.dart';
import '../models/worker_individual.dart';
//import '../models/worker_model.dart';
//import '../models/http_exception.dart';
class Services {
 // static const url = 'https://goodjob-mobile-app.000webhostapp.com/db_actions.php';
 // static const url2 = 'https://goodjob-mobile-app.000webhostapp.com/login.php';

  static const url = 'http://192.168.43.152/db_php/db_actions.php';
  static const url2 = 'http://192.168.43.152/db_php/login.php';
  static const url3 = 'http://192.168.43.152/db_php/insert_category.php';
   static const url4 = 'http://192.168.43.152/db_php/worker_list.php';
   static const url5 = 'http://192.168.43.152/db_php/profile.php';
  
  
  
  

  static const _ADD_WORKER_ACTION = 'ADD_WORKER';
  static const _ADD_CUSTOMER_ACTION = 'ADD_CUSTOMER';
 // static const _GET_WORKER_ACTION =  'GET_WORKER';

  static Map loginData;
  

  //static Future<List<Worker>> getWorker(String email) async {
  //  try {
  //    var map = Map<String, dynamic>();
  //    map['action'] = _GET_WORKER_ACTION;
  //    map['searchKey'] = email;
  //    final response = await http.post(url, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
  //    print('Get worker response: ${response.body}');
  //    if (200 == response.statusCode) {
  //      List<Worker> list = parseResponse(response.body);
  //      return list;
  //    }else{
  //     return List<Worker>(); 
  //    }
  //  }catch(e) {
  //    return List<Worker>();
  //  }

 // }
  //static List<Worker> parseResponse(String responseBody) {
  //  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //  return parsed.map<Worker>((json) => Worker.fromJson(json)).toList();
 // }

  static Future<void> addWorker(String lname, String fname, String bdate, String street, String brgy, String photo, String base64Photo,String front, String base64Front, String back, String base64Back, int docuId, String rqr, String base64Doc,String usrname, String eml, String pass) async{
      String name = lname;
      String mapVal;
      var testMap = Map<String, dynamic>();
      print('muaagi sa dire');
    try{
      print('gisulod dne');
      var map = Map<String, dynamic>();

      map['action'] =  _ADD_WORKER_ACTION;
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
      throw(e);
      
     
     
    }
  }

   static Future<void> addCustomer(String lname, String fname, String bdate, String street, String brgy, String usrname, String eml, String pass) async{
     try{

      var map = Map<String, dynamic>();
      map['action'] =  _ADD_CUSTOMER_ACTION;
      map["lastname"] = lname;
      map["firstname"] = fname;
      map["birthdate"] = bdate;
      map["zone"] = street;
      map["barangay"] = brgy;
      map["username"] = usrname;
      map["email"] = eml;
      map["password"] = pass;

       http.Response response = await http.post(url, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
      print('Add worker Response: ${response.body}');
      if (200 == response.statusCode) {
        print(response.body);
      } else {
       return "error";
    }
    } catch (e) {
      print(e);
      throw(e);
      
     
     
    }
      
   }

  

 // static void _printVal(String val) {
  //  print('ang sulod: $val');
  //}

  //static void _isEmp(Map map) {
   // if(map.isEmpty){
   //   print('true');
  //  }else{
  //    print('NAAY SULOD!');
  //  }
  //}

  static Future<void> insertCategory(int workerId, int cat, int cat2, int cat3, int cat4) async{
     var map = Map<String, dynamic>();
     try{
       map["id"] = workerId;
       map["cat"] = cat;
       map["cat2"] = cat2;
       map["cat3"] = cat3;
       map["cat4"] = cat4;
      print(map["id"]);
      print(map["cat"]);
      print(map["cat2"]);
       print(map["cat3"]);
       print(map["cat4"]);
      http.Response response = await http.post(url3, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
      print('Add category Response: ${response.body}');
      if (200 == response.statusCode) {
        print(response.body);
      } else {
       return "error";
    }

     }catch(e){
       print(e);
       throw(e);
     }
    
  }

static Future<List<WorkerProfiles>> getWorker(int cat) async {
   var map = Map<String, dynamic>();
    try{
    map['category'] = cat;
   final response = await http.post(url4, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get worker response: ${response.body}');

   if(response.statusCode == 200) {
     List workerProfiles = json.decode(response.body);
     return workerProfiles
     .map((workerProfiles) => new WorkerProfiles.fromJson(workerProfiles))
     .toList();
   }else{
     print("error");
   }

    }catch(e){
      print(e);
      throw(e);

    }
  
}


 static Future<List<WorkerIndividual>> getProfile(int wid) async{
    var map = Map<String, dynamic>();
   try{
   map['wid'] = wid;
  final response = await http.post(url5, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get profile response: ${response.body}');
   if(response.statusCode == 200) {
    List workerIndividual = json.decode(response.body);
    return workerIndividual
      .map((workerIndividual)=> new WorkerIndividual.fromJson(workerIndividual))
      .toList();
   }else{
     print("error");
   }
   }catch(e){
     print(e);
     throw(e);
   }

 }

}

