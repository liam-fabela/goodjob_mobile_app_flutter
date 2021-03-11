import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;


class CustomerImageInput1 extends StatefulWidget {

  final Function onSelectImage;


  CustomerImageInput1(this.onSelectImage);
  @override
  _CustomerImageInput1State createState() => _CustomerImageInput1State();
}

class _CustomerImageInput1State extends State<CustomerImageInput1> {
  
  File _pickedImage;
  //File _storedImage;
  String filePhoto;

  

 


  Future<void> _takePicture() async {
    var imageFile;
  
     imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
  
    if (imageFile == null) {
      return;
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
   final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    setState(() {
      _pickedImage = savedImage;
    });
   widget.onSelectImage(savedImage,fileName);
   //Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return 
        Column(
          children: <Widget>[
            GestureDetector(
               onTap: () => _takePicture(),
                child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 1, color: Theme.of(context).primaryColor),
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
         // SizedBox(height: 5),
          Container(
          padding: EdgeInsets.all(20),

          child: FlatButton.icon(
            icon: Icon(Icons.person_outline),
            label: Text('Front view photo.'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {},//_takePicture,
          ),
        ),
      ],
    );
  }
}
