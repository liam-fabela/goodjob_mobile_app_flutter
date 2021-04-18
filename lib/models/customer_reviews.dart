class CustomerReviews {
  String id;
  String lname;
  String fname;
  String profile;
  String rating;
  String review;
  String date;
  CustomerReviews({
    this.id,
    this.lname,
    this.fname,
    this.profile,
    this.rating,
    this.review,
    this.date,
  });

  factory CustomerReviews.fromJson(Map<String,dynamic>jsonData) {
    return CustomerReviews(
      id: jsonData['id'],
      lname: jsonData['lname'],
      fname: jsonData['fname'],
      profile: "https://goodjob-mobile-app.000webhostapp.com/customer_profile/"+jsonData['profile'],
      rating: jsonData['rating'],
      review: jsonData['review'],
      date: jsonData['date'],

    );
  }

}