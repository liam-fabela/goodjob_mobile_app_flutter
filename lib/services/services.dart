import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/worker_profile.dart';
import '../models/worker_individual.dart';
//import '../models/worker_model.dart';
//import '../models/http_exception.dart';
import '../models/customer_reviews.dart';
import '../models/cus_display_profile.dart';
import '../helper/shared_preferences.dart';
//import '../models/job_posting_model.dart';
import '../models/cus_chat_model.dart';
import '../models/searchResult.dart';
import '../models/worker_display_profile.dart';
import '../models/wor_chat_model.dart';
import '../models/customer_request_display.dart';
import '../models/wor_request_display.dart';
import '../models/wor_accepted.dart';
import '../models/wor_finished.dart';
import '../models/event_model.dart';
import '../models/display_post.dart';
import '../models/worker_earning.dart';
import '../models/worker_edit.dart';
import '../models/get_worker_docu.dart';
import '../models/total_star.dart';
import '../models/cus_notification.dart';
import '../models/customer_edits.dart';


class Services {


static const url = 'https://goodjob-mobile-app.000webhostapp.com/db_actions.php';
static const url2 = 'https://goodjob-mobile-app.000webhostapp.com/login.php';
static const url3 = 'https://goodjob-mobile-app.000webhostapp.com/insert_category.php';
static const url4= 'https://goodjob-mobile-app.000webhostapp.com/worker_list.php';
static const url5 = 'https://goodjob-mobile-app.000webhostapp.com/profile.php';
static const url6 = 'https://goodjob-mobile-app.000webhostapp.com/customer_reviews.php';
static const url7 = 'https://goodjob-mobile-app.000webhostapp.com/customer_profile.php';
static const url8 = 'https://goodjob-mobile-app.000webhostapp.com/create_chat.php';
static const url9 = 'https://goodjob-mobile-app.000webhostapp.com/customer_chatrooms.php';
static const url10 = 'https://goodjob-mobile-app.000webhostapp.com/update_chat.php';
static const url11 = 'https://goodjob-mobile-app.000webhostapp.com/create_work_request.php';
static const url12 = 'https://goodjob-mobile-app.000webhostapp.com/create_post.php';
static const url13 = 'https://goodjob-mobile-app.000webhostapp.com/search_worker.php';
static const url14 = 'https://goodjob-mobile-app.000webhostapp.com/worker_display.php';
static const url15 = 'https://goodjob-mobile-app.000webhostapp.com/worker_chatrooms.php';
static const url16 = 'https://goodjob-mobile-app.000webhostapp.com/display_customer_request.php';
static const url17 = 'https://goodjob-mobile-app.000webhostapp.com/display_worker_request.php';
static const url18 = 'https://goodjob-mobile-app.000webhostapp.com/update_accept_request.php';
static const url19 = 'https://goodjob-mobile-app.000webhostapp.com/accepted_worker_request.php';
static const url20 = 'https://goodjob-mobile-app.000webhostapp.com/finished_worker_request.php';
static const url21 = 'https://goodjob-mobile-app.000webhostapp.com/worker_schedule.php';
static const url22 = 'https://goodjob-mobile-app.000webhostapp.com/all_customer_request.php';
static const url23 = 'https://goodjob-mobile-app.000webhostapp.com/update_payment.php';
static const url24 = 'https://goodjob-mobile-app.000webhostapp.com/display_work_post.php';
static const url25 = 'https://goodjob-mobile-app.000webhostapp.com/insert_post_notif.php';
static const url26 = 'https://goodjob-mobile-app.000webhostapp.com/get_worker_earning.php';
static const url27 = 'https://goodjob-mobile-app.000webhostapp.com/insert_worker_complaints.php';
static const url28 = 'https://goodjob-mobile-app.000webhostapp.com/get_worker_edit.php';
static const url29 = 'https://goodjob-mobile-app.000webhostapp.com/update_worker_bio.php';
static const url30 = 'https://goodjob-mobile-app.000webhostapp.com/add_worker_review.php';
static const url31 = 'https://goodjob-mobile-app.000webhostapp.com/update_worker_bio2.php';
static const url32 = 'https://goodjob-mobile-app.000webhostapp.com/get_worker_docu.php';
static const url33 = 'https://goodjob-mobile-app.000webhostapp.com/upgrade_credibility.php';
static const url34 = 'https://goodjob-mobile-app.000webhostapp.com/star_rating.php';
static const url35 = 'https://goodjob-mobile-app.000webhostapp.com/worker_del_work.php';
static const url36 = 'https://goodjob-mobile-app.000webhostapp.com/customer_post.php';
static const url37 = 'https://goodjob-mobile-app.000webhostapp.com/cus_post_notif.php';
static const url38 = 'https://goodjob-mobile-app.000webhostapp.com/get_customer_edit.php';
static const url39 = 'https://goodjob-mobile-app.000webhostapp.com/update_profile.php';
static const url40 = 'https://goodjob-mobile-app.000webhostapp.com/update_profile2.php';
static const url41 = 'https://goodjob-mobile-app.000webhostapp.com/worker_delete_chat.php';











//  static const url = 'http://192.168.18.69/system/db_php/db_actions.php';
//  static const url2 = 'http://192.168.18.69/system/db_php/login.php';
//  static const url3 = 'http://192.168.18.69/system/db_php/insert_category.php';
//  static const url4 = 'http://192.168.18.69/system/db_php/worker_list.php';
//  static const url5 = 'http://192.168.18.69/system/db_php/profile.php';
//  static const url6 = 'http://192.168.18.69/system/db_php/customer_reviews.php';
//  static const url7 = 'http://192.168.18.69/system/db_php/customer_profile.php';
//  static const url8 = 'http://192.168.18.69/system/db_php/create_chat.php';
//  static const url9 = 'http://192.168.18.69/system/db_php/customer_chatrooms.php';
//  static const url10 = 'http://192.168.18.69/system/db_php/update_chat.php';
//  static const url11 = 'http://192.168.18.69/system/db_php/create_work_request.php';
//  static const url12 = 'http://192.168.18.69/system/db_php/create_post.php';
//  static const url13 = 'http://192.168.18.69/system/db_php/search_worker.php';
//  static const url14 = 'http://192.168.18.69/system/worker_display.php';
//  static const url15 = 'http://192.168.18.69/system/worker_chatrooms.php';
//  static const url16 = 'https://192.168.18.69/system/display_customer_request.php';

  
  
  static var cid;
  static int id;
  static String cus;
   
  
  
  
  
  
  
  
  

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

  static Future<void> addWorker(String joined,String lname, String fname, String bdate, String street, String brgy, String photo, String base64Photo,String front, String base64Front, String back, String base64Back, int docuId, String rqr, String base64Doc,String usrname, String eml, String pass, String uid) async{

      print('muaagi sa dire');
    try{
      print('gisulod dne');
      var map = Map<String, dynamic>();

      map['action'] =  _ADD_WORKER_ACTION;
      map['joined'] = joined;
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
      map["uid"] = uid;
     
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

   static Future<void> addCustomer(String lname, String fname, String bdate, String street, String brgy, String usrname, String eml, String pass, String uid, String joined) async{
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
      map["uid"] = uid;
      map["joined"] = joined;

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

 static Future<List<CustomerReviews>> getReviews(int wid) async{

    var map = Map<String, dynamic>();
   try{
    map['wid'] = wid;
    final response = await http.post(url6, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get reviews response: ${response.body}');
   if(response.statusCode == 200) {
    List customerReviews = json.decode(response.body);
    return customerReviews
      .map((customerReviews)=> new CustomerReviews.fromJson(customerReviews))
      .toList();
   }else{
     print("error");
   }
   }catch(e){
     print(e);
     throw (e);
   }
 }



static getData()async{
    cid = await SharedPrefUtils.getUser('userId');
    cus = cid.toString();
    id = int.parse(cus);
    print('FROM GET DATA: $id');
   
  }
 static Future<List<CustomerProfile>> getCustomerDisplay(int id) async{
  
   var map = Map<String, dynamic>();
   try{
    map['cid'] = id;
    print ('FROM SERVICES: $id');
    final response = await http.post(url7, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get customer response: ${response.body}');
   if(response.statusCode == 200) {
    List customerProfile = json.decode(response.body);
    return customerProfile
      .map((customerProfile)=> new CustomerProfile.fromJson(customerProfile))
      .toList();
   }else{
     print("error");
   }

   }catch(e){
     print(e);
     throw (e);
   }
 }


 static Future<List<CustomerEdits>> getCustomerEdit(int cid) async{

    var map = Map<String, dynamic>();
   try{
      map['cid'] = cid;
       final response = await http.post(url38, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get worker response: ${response.body}');
   if(response.statusCode == 200) {
    List customerEdits = json.decode(response.body);
    return customerEdits
      .map((customerEdits)=> new CustomerEdits.fromJson(customerEdits))
      .toList();
   }else{
     print("error");
   }

   }catch(e){

   }

 }


static Future<void> createChat(int custId, int workId, String firebaseMessage) async{

 var map = Map<String, dynamic>();
 try{
   map["user1"] = custId;
   map["user2"] = workId;
   map["firebase"] = firebaseMessage;

   final response = await http.post(url8, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get chatroom response: ${response.body}');
   if(response.statusCode == 200) {
    print(response.body);
   }else{
     print("error");
   }



 }catch(e){
   throw(e);
 }

}

static Future<List<CustomerChatroom>> getCusChat(int cid) async{
   var map = Map<String, dynamic>();
   try{
      map['userId'] = cid;
       final response = await http.post(url9, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get customer response: ${response.body}');
   if(response.statusCode == 200) {
    List customerChat = json.decode(response.body);
    return customerChat
      .map((customerChat)=> new CustomerChatroom.fromJson(customerChat))
      .toList();
   }else{
     print("error");
   }

   }catch(e){

   }

}

static Future<List<WorkerChatroom>> getWorChat(int wid) async{
   var map = Map<String, dynamic>();
   try{
      map['userId'] = wid;
       final response = await http.post(url15, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get worker response: ${response.body}');
   if(response.statusCode == 200) {
    List workerChat = json.decode(response.body);
    return workerChat
      .map((workerChat)=> new WorkerChatroom.fromJson(workerChat))
      .toList();
   }else{
     print("error");
   }

   }catch(e){

   }

}

static Future<void> updateChat(String fid, DateTime updated) async{
  try{
     var map = Map<String, dynamic>();
     String date = updated.toString();
     map['fid'] = fid;
     map['date'] = date;
   final response = await http.post(url10, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get UPDATE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Updated successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}


static Future<void> createWorkRequest(int wid, int cid, int cat, String date, String time, String time2, String location,
String details, double budget, String type, String status, String reqDate) async{
 
  try{
     var map = Map<String, dynamic>();

     map['wid'] = wid;
     map['cid'] = cid;
     map['cat'] = cat;
     map['date'] = date;
     map['time'] = time;
     map['time2'] = time2;
     map['location'] = location;
     map['details'] = details;
     map['budget'] = budget;
     map['type'] = type;
     map['status'] = status;
     map['requestedDate'] = reqDate;

   final response = await http.post(url11, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get insert response: ${response.body}');
   if(response.statusCode == 200) {
    print('work request sent successfully');
   }else{
     print("error");
   }



  }catch(error){
    throw(error);
  }
}


static Future<void> createWorkPost(int cid,int cat,String date, String time1, String time2, String location, String details, 
double budget, String type, String createdOn, String status) async{
  try{
     var map = Map<String, dynamic>();
     map['cid'] = cid;
     map['cat'] =cat;
     map['date'] = date;
     map['time1'] =time1;
     map['time2'] = time2;
     map['location'] = location;
     map['details'] = details;
     map['budget'] = budget;
     map['type'] = type;
     map['createdOn'] = createdOn;
     map['status'] = status;

    final response = await http.post(url12, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get create post response: ${response.body}');
   if(response.statusCode == 200) {
    print('work post created successfully');
   }else{
     print("error");
   }



  }catch(error){
    print(error);
    throw(error);

  }

}

static Future<List<SearchResults>> searchWorker(String search, String filter)async{
  try{
    var map = Map<String, dynamic>();
    map['searchKey'] = search;
     map['filter'] = filter;

    final response = await http.post(url13, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get search response: ${response.body}');
   if(response.statusCode == 200) {
    List searchResults = json.decode(response.body);
    return searchResults
    .map((searchResults)=> new SearchResults.fromJson(searchResults))
    .toList();
   }else{
     print("error");
    
   }


  }catch(error){
    print(error.toString());
     throw(error);

  }

}


static Future<List<WorkerProfile>> getWorkerDisplay(int wid) async{
  try{
    var map = Map<String, dynamic>();
    map['wid'] = wid;

    final response = await http.post(url14, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get worker display: ${response.body}');
    if(response.statusCode == 200){
      List workerProfile = json.decode(response.body);
      return workerProfile
        .map((workerProfile)=> new WorkerProfile.fromJson(workerProfile))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }


}

static Future<List<CustomerRequests>> getCustomerRequest(int cid) async{
  try{
    var map = Map<String, dynamic>();
    map['cid'] = cid;

    final response = await http.post(url16, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get worker display: ${response.body}');
    if(response.statusCode == 200){
      List customerRequest= json.decode(response.body);
      return customerRequest
        .map((customerRequest)=> new CustomerRequests.fromJson(customerRequest))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }


}


static Future<List<WorkerRequests>> getWorkerRequest(int wid) async{
  try{
    var map = Map<String, dynamic>();
    map['wid'] = wid;

    final response = await http.post(url17, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get worker display: ${response.body}');
    if(response.statusCode == 200){
      List workerRequest= json.decode(response.body);
      return workerRequest
        .map((workerRequest)=> new WorkerRequests.fromJson(workerRequest))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }


}



static Future<void> updateAcceptRequest(int jobId, String stat, int time ,String reason,String updated) async{
  try{
     var map = Map<String, dynamic>();
     map['jobId'] = jobId;
     map['stat'] = stat;
    map['time'] = time;
     map['reason'] = reason;
     map['updated'] = updated;
   final response = await http.post(url18, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get UPDATE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Updated successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}

static Future<List<WorkerAcceptedRequests>> getWorkerAcceptedRequest(int wid) async{
  try{
    var map = Map<String, dynamic>();
    map['wid'] = wid;

    final response = await http.post(url19, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get worker display: ${response.body}');
    if(response.statusCode == 200){
      List workerAcceptedRequest= json.decode(response.body);
      return workerAcceptedRequest
        .map((workerAcceptedRequest)=> new WorkerAcceptedRequests.fromJson(workerAcceptedRequest))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }


}

static Future<List<WorkerFinishedRequests>> getWorkerFinishedRequest(int wid) async{
  try{
    var map = Map<String, dynamic>();
    map['wid'] = wid;

    final response = await http.post(url20, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get worker display: ${response.body}');
    if(response.statusCode == 200){
      List workerFinishedRequest= json.decode(response.body);
      return workerFinishedRequest
        .map((workerFinishedRequest)=> new WorkerFinishedRequests.fromJson(workerFinishedRequest))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }
}

static Future<List<EventModel>> getEvent(int workerId) async{
    var map = Map<String, dynamic>();
    try{
      map['id'] = workerId;

      final response = await http.post(url21, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get event response: ${response.body}');

   if(response.statusCode == 200) {
     List eventModel = json.decode(response.body);
     return eventModel
     .map((eventModel) => new EventModel.fromJson(eventModel))
     .toList();
   }else{
     print("error");
   }

    }catch(error){
      print(error);
      throw(error);
    }
  }


static Future<List<CustomerRequests>> getAllCustomerRequest(int cid) async{
  try{
    var map = Map<String, dynamic>();
    map['cid'] = cid;

    final response = await http.post(url22, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get worker display: ${response.body}');
    if(response.statusCode == 200){
      List customerRequest= json.decode(response.body);
      return customerRequest
        .map((customerRequest)=> new CustomerRequests.fromJson(customerRequest))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }


}


static Future<void> updatePayment(int jobId, String stat,String update,  double earning) async{
  try{
     var map = Map<String, dynamic>();
     map['jobId'] = jobId;
     map['stat'] = stat;
     map['update'] = update;
      map['earning'] = earning;
   final response = await http.post(url23, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get UPDATE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Updated successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}


static Future<List<DisplayPost>> getPost(int wid) async{
  try{
    var map = Map<String, dynamic>();
    map['wid'] = wid;

    final response = await http.post(url24, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get post: ${response.body}');
    if(response.statusCode == 200){
      List displayPost= json.decode(response.body);
      return displayPost
        .map((displayPost)=> new DisplayPost.fromJson(displayPost))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }


}

static Future<List<DisplayPost>> getPost2(int cid) async{
  try{
    var map = Map<String, dynamic>();
    map['cid'] = cid;

    final response = await http.post(url36, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get post: ${response.body}');
    if(response.statusCode == 200){
      List displayPost= json.decode(response.body);
      return displayPost
        .map((displayPost)=> new DisplayPost.fromJson(displayPost))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }


}



static Future<void> insertNotif(int workPostId,int cid, int wid, String sent) async{
 
  try{
    print("FORM SERVICES" + workPostId.toString());
     var map = Map<String, dynamic>();
    map['wip'] = workPostId;
    map['cid'] = cid;
     map['wid'] = wid;
     map['sent'] = sent;

   final response = await http.post(url25, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get insert response: ${response.body}');
   if(response.statusCode == 200) {
    print('notification sent successfully');
   }else{
     print("error");
   }



  }catch(error){
    throw(error);
  }
}


static Future<List<WorkerEarning>> getEarning(int wid) async{
  try{
    var map = Map<String, dynamic>();
    map['wid'] = wid;

    final response = await http.post(url26, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get earning: ${response.body}');
    if(response.statusCode == 200){
      List workerEarning= json.decode(response.body);
      return workerEarning
        .map((workerEarning)=> new WorkerEarning.fromJson(workerEarning))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }


}

static Future<void> insertComplaints(int wid, String com, String date) async{
 
  try{
    //print("FORM SERVICES" + workPostId.toString());
     var map = Map<String, dynamic>();
    map['wid'] = wid;
     map['comp'] = com;
     map['date'] = date;

   final response = await http.post(url27, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get insert response: ${response.body}');
   if(response.statusCode == 200) {
    print('complaint sent successfully');
   }else{
     print("error");
   }



  }catch(error){
    throw(error);
  }
}


static Future<List<WorkerEdits>> getWorkerEdit(int wid) async{
  try{
    var map = Map<String, dynamic>();
    map['wid'] = wid;

    final response = await http.post(url28, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get worker edit: ${response.body}');
    if(response.statusCode == 200){
      List workerEdit= json.decode(response.body);
      return workerEdit
        .map((workerEdit)=> new WorkerEdits.fromJson(workerEdit))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }
}


static Future<void> updateBio(int wid, String bio, String profile ,String base64photo, String zone, String brgy, String pass) async{
  try{
     var map = Map<String, dynamic>();
     map['wid'] = wid;
     map['bio'] = bio;
     map['profile'] = profile;
      map['real'] = base64photo;
      map['zon'] = zone;
      map['brgy'] = brgy;
      map['pass'] = pass;
   final response = await http.post(url29, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get UPDATE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Updated successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}

static Future<void> updateBio2(int wid, String bio, String zone, String brgy, String pass) async{
  try{
     var map = Map<String, dynamic>();
     map['wid'] = wid;
     map['bio'] = bio;
      map['zon'] = zone;
      map['brgy'] = brgy;
      map['pass'] = pass;
   final response = await http.post(url31, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get UPDATE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Updated successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}

static Future<void> addReview(int cid,int wid, double star,String review, String date) async{
 
  try{
    //print("FORM SERVICES" + workPostId.toString());
     var map = Map<String, dynamic>();
    map['cid'] = cid;
     map['wid'] = wid;
     map['star'] = star;
     map['rev'] = review;
     map['rdate'] = date;



   final response = await http.post(url30, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get insert response: ${response.body}');
   if(response.statusCode == 200) {
    print('notification sent successfully');
   }else{
     print("error");
   }



  }catch(error){
    throw(error);
  }
}

static Future<List<WorkerDocu>> getWorkeDocu(int wid) async{
  try{
    var map = Map<String, dynamic>();
    map['wid'] = wid;

    final response = await http.post(url32, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get worker edit: ${response.body}');
    if(response.statusCode == 200){
      List workerDocu= json.decode(response.body);
      return workerDocu
        .map((workerDocu)=> new WorkerDocu.fromJson(workerDocu))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }
}

static Future<void> updateDocu(int wid, int doc, String docu ,String base64) async{
  try{
     var map = Map<String, dynamic>();
     map['wid'] = wid;
     map['docId'] = doc;
     map['docu'] = docu;
      map['real'] = base64;

   final response = await http.post(url33, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get UPDATE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Updated successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}

static Future<List<TotalStar>> getTotalRating(int wid) async{
  try{
    var map = Map<String, dynamic>();
    map['wid'] = wid;

    final response = await http.post(url34, body: jsonEncode(map), headers: {'Content-type': 'application/json'});
    print('get worker display: ${response.body}');
    if(response.statusCode == 200){
      List totalStar= json.decode(response.body);
      return totalStar
        .map((totalStar)=> new TotalStar.fromJson(totalStar))
        .toList();
    }else{
      print('error');
    }

  }catch(error){
    print(error);
    throw(error);
  }


}

static Future<void> deletWorkerWork(int jobId,String update) async{
  try{
     var map = Map<String, dynamic>();
     map['id'] = jobId;
     map['date'] = update;
   final response = await http.post(url35, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get DELETE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Deleted successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}

static Future<List<CustomerNotification>> getCusNotif(int cid) async{
   var map = Map<String, dynamic>();
   try{
      map['cid'] = cid;
       final response = await http.post(url37, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get customer response: ${response.body}');
   if(response.statusCode == 200) {
    List customerNotif = json.decode(response.body);
    return customerNotif
      .map((customerNotif)=> new CustomerNotification.fromJson(customerNotif))
      .toList();
   }else{
     print("error");
   }

   }catch(e){

   }

}

static Future<void> updateProfile(int cid,String profile ,String base64photo, String zone, String brgy) async{
  try{
     var map = Map<String, dynamic>();
     map['cid'] = cid;
     map['profile'] = profile;
      map['real'] = base64photo;
      map['zon'] = zone;
      map['brgy'] = brgy;
     
   final response = await http.post(url39, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get UPDATE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Updated successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}

static Future<void> updateProfile2(int cid,String zone, String brgy) async{
  try{
     var map = Map<String, dynamic>();
     map['cid'] = cid;
      map['zon'] = zone;
      map['brgy'] = brgy;
     
   final response = await http.post(url40, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get UPDATE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Updated successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}

static Future<void> deletWorkerWorkChat(int id,String update) async{
  try{
     var map = Map<String, dynamic>();
     map['id'] = id;
     map['date'] = update;
   final response = await http.post(url41, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
   print('Get DELETE response: ${response.body}');
   if(response.statusCode == 200) {
    print('Deleted successfully');
   }else{
     print("error");
   }

  }catch(error){
    print(error);
  }
}

}





