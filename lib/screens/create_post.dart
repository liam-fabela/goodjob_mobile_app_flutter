import 'package:flutter/material.dart';

import '../styles/style.dart';

class CreatePostModal extends StatefulWidget {
  static const routeName = '/post_job';
  @override
  _CreatePostModalState createState() => _CreatePostModalState();
}

class _CreatePostModalState extends State<CreatePostModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: appBarSign(context, 'Create Job Post'),
              body: SingleChildScrollView(
               child: Card(
                elevation: 5,
                child: Container(

                   padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 15,
               // bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
           // height: MediaQuery.of(context).size.height * 0.40,
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                           TextFormField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              decoration:
                                textFieldInputDecoration('Create a Job Posting...'),
                              ),
                               Divider(),
                               Container(
                                 alignment: Alignment.bottomRight,
                                 child: GestureDetector(
                                        onTap: (){
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of

(context).size.width * 0.3,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(62, 135, 148, 

1),
                                            borderRadius: BorderRadius.circular

(10),
                                          ),
                                          child: Text(
                                            'Post',
                                            style: TextStyle(color: 

Colors.white, fontFamily: 'Raleway' , fontWeight: FontWeight.bold),
                                          ),
                                        ),
                           ),
                               ),       
            ],),
            
        ),
      ),
              ),
          );
    
  }
}