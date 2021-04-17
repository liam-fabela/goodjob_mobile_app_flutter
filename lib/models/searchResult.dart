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
    
    });

    factory SearchResults.fromJson(Map<String, dynamic>jsonData){
      return SearchResults(
        id: jsonData['id'],
        lname: jsonData['lname'],
        fname: jsonData['fname'],
        zone: jsonData['zone'],
        barangay: jsonData['barangay'],
        city: jsonData['city'],
        docImg: "http://192.168.43.152/db_php/worker_profile/"+jsonData['doc_img'],
        profile: "http://192.168.43.152/db_php/doc_img/"+jsonData['profile'],
        uid: jsonData['uid'],


      );

    }
}