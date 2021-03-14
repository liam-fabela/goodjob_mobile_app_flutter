import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/worker_model.dart';
import '../models/http_exception.dart';
class Services {
  static const url = 'https://goodjob-mobile-app.000webhostapp.com/db_actions.php';
  static const url2 = 'https://goodjob-mobile-app.000webhostapp.com/login.php';
  

  static const _ADD_WORKER_ACTION = 'ADD_WORKER';
  static const _ADD_CUSTOMER_ACTION = 'ADD_CUSTOMER';
  static const _GET_WORKER_ACTION =  'GET_WORKER';

  static Map loginData;
  

  static Future<List<Worker>> getWorker(String email) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_WORKER_ACTION;
      map['searchKey'] = email;
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
      
     
     
    }
      
   }

   static Future<Map> loginUser(String user, String password) async {
     try{
       print("gisulod dne");
       var map = Map<String, dynamic>();
        map["searchEmail"] = user;
        map["searchPassword"] = password;

        
       http.Response response = await http.post(url2, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
       print('Login Response: ${response.body}');
      if (200 == response.statusCode) {
        print(response.body);
        var data = json.decode(response.body);
       
        if(data["error"] && data["error2"]){
          print("NARA KO");
          if(data["message"] == "No email or username found." && data["message2"] ==  "No email or username found." ){
            loginData["loginError"] = data["message"];
            print(data["message"]);
            return loginData["loginError"];
          } 
          if(data["message"] == "No email or username found." && data["message2"] ==   "Your Password is incorrect."){
            loginData["loginError"] = data["message2"];
            print(data["message2"]);
            return loginData["loginError"];
          }
          if(data["message"] == "Your Password is incorrect." && data["message2"] == "No email or username found.") {
            loginData["loginError"] = data["message"];
            print(data["message"]);
            return loginData["loginError"];
          }

        
        }
        loginData["utype"] = data["usertype"];
        loginData["valid"] = data["validate"];
        loginData["userID"] = data["uid"];
        loginData["lname"] = data["lastname"];
        loginData["fname"] = data["firstname"];
        loginData["bday"] = data["birthdate"];
        loginData["zon"] = data["zone"];
        loginData["brgy"] = data["barangay"];
        loginData["cty"] = data["city"];
        loginData["usrname"] = data["username"];
        return loginData;
       
      } else {
       return loginData["error"];
    }
     }catch(e){
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

}