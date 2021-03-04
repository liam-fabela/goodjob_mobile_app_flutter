import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;


class SignUpModal3 extends StatefulWidget {

   final Function onSelectImage;

  SignUpModal3(this.onSelectImage);
  @override
  _SignUpModal3State createState() => _SignUpModal3State();
}

class _SignUpModal3State extends State<SignUpModal3> {

  var openCamera;

 // File _storedImage;

  bool _toggleSource(bool val) {
    
     return openCamera = val;
    
  }

  Future<void> _takePicture(bool toggle) async {
    var imageFile;
    if(openCamera) {
     imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
     
    }else{
      imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
         );
    }
  
    if (imageFile == null) {
      return;
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
   final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
   widget.onSelectImage(savedImage);
   //toggleSource();
   Navigator.of(context).pop();
    
 
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: FlatButton.icon(
                  icon: Icon(Icons.camera),
                  label: Text(
                    'Take Photo',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () => _takePicture(_toggleSource(true)),
                  //_takePicture,
                  
                  ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: FlatButton.icon(
                  icon: Icon(Icons.folder),
                  label: Text(
                    'Upload Photo',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed:  () => _takePicture(_toggleSource(false)), //_takePicture,
                  ),
            ),
          ],
        ),
      ),
      
    );
  }
}