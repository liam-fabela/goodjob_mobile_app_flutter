import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../widget/category_choices.dart';

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
              top: 0,
              left: 15,
              right: 15,
              bottom: 15,
            ),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: inputDeco('Date:'),
                  ),
                  TextFormField(
                    decoration: inputDeco('Time:'),
                  ),
                  TextFormField(
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: inputDeco('Enter Job details:'),
                  ),
                  TextFormField(
                    decoration: inputDeco('Budget:'),
                  ),
                  SizedBox(height: 10),
                  Text('Choose a Category: ',
                      style: addressStyle(), textAlign: TextAlign.left),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        CategoryChoices('House chores'),
                        CategoryChoices('Personal errands'),
                        CategoryChoices('Beauty&Grooming'),
                        CategoryChoices('House repair'),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                   // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 20,
                              color: Color.fromRGBO(62, 135, 148, 1),
                            ),
                            Text(
                              'Add your location',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Raleway',
                                color: const Color.fromRGBO(62, 135, 148, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.3,
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(62, 135, 148, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Post',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
