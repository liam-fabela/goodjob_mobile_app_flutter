class SearchResults{
  String id;
  String lname;
  String fname;
  String zone;
  String barangay;
  String city;
  String docImg;
  String profile;
  String uid;
  String catId;
  String catType;
  
  SearchResults({
    this.id,
    this.lname,
    this.fname,
    this.zone,
    this.barangay,
    this.city,
    this.docImg,
    this.profile,
    this.uid,
    this.catId,
    this.catType,
    
    });

    factory SearchResults.fromJson(Map<String, dynamic>jsonData){
      return SearchResults(
        id: jsonData['id'],
        lname: jsonData['lname'],
        fname: jsonData['fname'],
        zone: jsonData['zone'],
        barangay: jsonData['barangay'],
        city: jsonData['city'],
        //https://goodjob-mobile-app.000webhostapp.com/
        //http://192.168.18.69/system/template/mobile-web-images/
        //http://192.168.18.69/system/db_php/
        docImg: "https://goodjob-mobile-app.000webhostapp.com/doc_img/"+jsonData['doc_img'],
        profile: "https://goodjob-mobile-app.000webhostapp.com/worker_profile/"+jsonData['display_photo'],
        uid: jsonData['uid'],
        catId: jsonData['catId'],
        catType: jsonData['catType'],

      );

    }
}