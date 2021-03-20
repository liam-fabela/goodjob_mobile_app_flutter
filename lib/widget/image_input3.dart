import 'package:flutter/material.dart';
import 'dart:io';

import 'signup_modal3.dart';
import 'information_modal.dart';

class ImageInput3 extends StatefulWidget {
  final Function onSelectImage;
  final Function onSelectRadio;
  ImageInput3(this.onSelectImage, this.onSelectRadio);
  @override
  _ImageInput3State createState() => _ImageInput3State();
}

class _ImageInput3State extends State<ImageInput3> {
  int selectedRadioTile;
   File _pickedImage;
   String filePhoto;

   void _selectImage(File pickedImage, String fileName) {
     filePhoto = fileName;
     setState(() {
        _pickedImage = pickedImage;
     });
     widget.onSelectImage(_pickedImage, filePhoto);
   

  }
   
  @override
  void initState() {
    selectedRadioTile = 0;
    super.initState();
  }

  _setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      print(selectedRadioTile);
      //selected = true;
    });
    widget.onSelectRadio(selectedRadioTile);
  }

 // bool activeRadioTile(bool val) {
  //  setState(() {
  //    val = !val;
  //  });
  //}

   void _startAddPhoto(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: SignUpModal3(_selectImage),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _openInfo(BuildContext ctx, String image, String title, String text){
     showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: InformationModal(image, title, text),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: 
      Column(
        children: <Widget>[
          RadioListTile(
            value: 3,
            groupValue: 
            selectedRadioTile,
            title: Text('Barangay Clearance'),
            onChanged: (val){
               _setSelectedRadioTile(val);

            },
            activeColor: Theme.of(context).primaryColor,
            secondary: IconButton(onPressed: ()=> _openInfo(context,'assets/images/bronze.png','Bronze Badge','You\'ll get a bronze badge for credibility level. Credibility level means the measure of your trustworthiness as a person. Level up your credibility level to attract more customers!'), icon: Icon(Icons.info),
            color: Color.fromRGBO(62, 135, 148, 1),
          ),
         // selected: true,
          ),
         RadioListTile(
        value: 2,
        groupValue: 
        selectedRadioTile,
        title: Text('Police Clearance'),
        onChanged: (val){
           _setSelectedRadioTile(val);

        },
        activeColor: Theme.of(context).primaryColor,
        secondary: IconButton(onPressed: ()=>_openInfo(context,'assets/images/silver.png','Silver Badge','You\'ll get a silver badge for credibility level. Credibility level means the measure of your trustworthiness as a person. Level up your credibility level to attract more customers!'), icon: Icon(Icons.info),
        color: Color.fromRGBO(62, 135, 148, 1),
      ),
      // selected: false,
      ),
       RadioListTile(
        value: 1,
        groupValue: 
        selectedRadioTile,
        title: Text('NBI Clearance'),
        onChanged: (val){
           _setSelectedRadioTile(val);

        },
        activeColor: Theme.of(context).primaryColor,
        secondary: IconButton(onPressed: ()=>_openInfo(context,'assets/images/gold.png','Gold Badge','Congrats! You\'ll get a gold badge for credibility level. This is the highest level of credibility, which means customers would most likely to choose you as their worker.Credibility level means the measure of your trustworthiness as a person.'), icon: Icon(Icons.info),
        color: Color.fromRGBO(62, 135, 148, 1),
      ),
      // selected: false,
      ),
      SizedBox(height: 5),
      GestureDetector(
        onTap: () => _startAddPhoto(context),
              child: Container(
                alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.20,
          height: MediaQuery.of(context).size.height * 0.10,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).primaryColor),
          ),

                child:  _pickedImage != null
              ? Image.file(
                  _pickedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              :Icon(Icons.add),
          
        
      ),
      ),
        ],
      ),
      
    );
  }
}