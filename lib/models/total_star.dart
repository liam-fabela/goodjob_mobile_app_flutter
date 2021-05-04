class TotalStar{
  String rating;

  TotalStar({this.rating});

    factory TotalStar.fromJson(Map<String, dynamic>jsonData){
    return TotalStar(
      rating: jsonData['rating'],
    );
    }
}