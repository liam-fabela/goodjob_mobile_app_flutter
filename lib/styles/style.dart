import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget appBarSign(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style: mediumTextStyle(),
    ),
  );
}

Widget signUpCategory(
    BuildContext context, String category, String image, Function goToPage) {
  return InkWell(
      onTap: () {
        goToPage();
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      image,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      color: Color.fromRGBO(29, 171, 145, 0.7),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )));
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black54,
    ),
    border: InputBorder.none,
  );
}

InputDecoration inputDeco(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
       color: Colors.black54,
       fontSize: 14,
       fontFamily: 'Raleway'
    ),
    //border: InputBorder.,
  );
}

TextStyle simpleTextFieldStyle() {
  return TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Raleway');
}

TextStyle mediumTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontFamily: 'Raleway',
    fontSize: 17,
  );
}

 TextStyle profileName() {
      return TextStyle(  
        color: const Color.fromRGBO(62, 135, 148, 1),
        fontSize: 16,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.bold,
  );
 }

 TextStyle addressStyle() {
   return TextStyle(
        color: const Color.fromRGBO(62, 135, 148, 1),
         fontSize: 12,
         fontFamily: 'Raleway',
         fontWeight: FontWeight.bold,
         );
 }

 
 TextStyle addressStyle2() {
   return TextStyle(
        color: Colors.white,
         fontSize: 10,
         fontFamily: 'Raleway',
         fontWeight: FontWeight.bold,
         );
 }

 TextStyle reviewStyle() {
   return TextStyle(
        color: const Color.fromRGBO(62, 135, 148, 1),
         fontSize: 12,
         fontFamily: 'Raleway',
         fontWeight: FontWeight.bold,
         );
 }


 

Image appLogo = new Image(
  image: new ExactAssetImage('assets/images/good_job.png'),
  height: 200.0,
  width: 200.0,
  fit: BoxFit.cover,
);

Widget loadingScreen(BuildContext context, String text) {
  return Scaffold(
    backgroundColor: Color.fromRGBO(75, 210, 178, 1),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SpinKitSquareCircle(
              color: Color.fromRGBO(62, 135, 148, 1), size: 50.0),
        ),
        SizedBox(height: 35),
        Container(
          alignment: Alignment.center,
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                  text,
                  style: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'Raleway',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              
            ],
          ),
        ),
      ],
    ),
  );
}

  
