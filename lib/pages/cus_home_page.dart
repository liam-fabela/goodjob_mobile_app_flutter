import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/widget_data.dart';
import '../widget/category_item.dart';
import '../screens/create_post.dart';
import '../helper/firebase_user.dart';
import '../helper/shared_preferences.dart';
import '../screens/search_screen.dart';

class CustomerHomePage extends StatefulWidget {
  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int cid;
  Future<int> tem;

  @override
  void initState() {
     tem = SharedPrefUtils.getUser('userId');
    _getData();
    _getCustId();

    super.initState();
  }

  _getData() {
    var user = FirebaseAuth.instance.currentUser.uid;
    UserProfile.currentUser = user;
    print('LOGGED IN USER $user');
  }

  _getCustId() async {
    var id = await SharedPrefUtils.getUser('userId');
    String cus = id.toString();
    cid = int.parse(cus);
    UserProfile.dbUser = cid;
  }

  void _createPost(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => CreatePostModal(id),
      ),
    );
    // Navigator.of(context).pushNamed(
    // CreatePostModal.routeName,

    //);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
            future: tem,
              builder: (context, snapshot){
                        if(snapshot.connectionState != ConnectionState.done){
                           return Padding(
                             padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                             child: Center(
                              child: SpinKitSquareCircle(
                                  color: Color.fromRGBO(62, 135, 148, 1),
                                  size: 50.0),
                          ),
                           );
                        }
                        final cust = snapshot.data.toString();
                        final custId = int.parse(cust);
                        UserProfile.dbUser = custId;
              return  Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => SearchScreen(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.white,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Search Worker...',
                                  style: TextStyle(
                                      color: Colors.grey, fontFamily: 'Raleway'),
                                ),
                              ),
                              Icon(
                                Icons.search,
                                color: Color.fromRGBO(62, 135, 148, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _createPost(context, custId);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(62, 135, 148, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wysiwyg_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Create Job Posting',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              //  SizedBox(height: 5),
              Center(
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                // color: Colors.grey,
                child: GridView(
                  padding: const EdgeInsets.all(10),
                  children: CATEGORY_DATA
                      .map(
                        (catData) => CategoryItem(
                          catData.id,
                          catData.title,
                          catData.img,
                        ),
                      )
                      .toList(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                ),
              ),
            ],
          ),
        );
       }
      ),
    );
  }
}
