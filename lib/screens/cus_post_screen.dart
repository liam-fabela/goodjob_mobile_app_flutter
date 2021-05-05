import 'package:flutter/material.dart';

import '../services/services.dart';
import '../models/display_post.dart';
import '../styles/style.dart';

class CustomerWorkPost extends StatefulWidget {
  final int cid;
  CustomerWorkPost(this.cid);
  @override
  _CustomerWorkPostState createState() => _CustomerWorkPostState();
}

class _CustomerWorkPostState extends State<CustomerWorkPost> {

  Widget postWidget(BuildContext context, DisplayPost displayPost) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 5,
      ),
     
      child: Container(
         height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
                flex: 85,
             child:
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(displayPost.profile),
                backgroundColor: Color.fromRGBO(75, 210, 178, 1),
                child: Padding(
                  padding: EdgeInsets.all(6),
                ),
              ),
              title: Text(displayPost.fname + " " + displayPost.lname,
                  style: profileName()),
              subtitle:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Category: " + displayPost.catType, style: addressStyle()),
                    Text("What: " + displayPost.details, style: addressStyle()),
                    Text("Where: " + displayPost.location, style: addressStyle()),
                    Text("When: " + displayPost.date, style: addressStyle()),
                    Row(
                      children: [
                        Text(displayPost.startTime, style: addressStyle()),
                        Text(
                          displayPost.endTime == null
                              ? " "
                              : " - " + displayPost.endTime,
                          style: addressStyle(),
                        ),
                      ],
                    ),
                    Text(
                        "Budget: " + displayPost.budget == null
                            ? "Not specified"
                            : displayPost.budget + "/" + displayPost.type,
                        style: addressStyle()),
                  ],
                  
                ),
              ),
             
            ),
            Divider(),
            Expanded(
              flex: 10,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(displayPost.respond + " responds",  style: addressStyle()),
                  Text(displayPost.createdOn, style: extraTinyFont()),
                ],
              ),
            ),
          ],
        ),
         
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'My Work Posts'),
      body: FutureBuilder<List<DisplayPost>>(
                        future: Services.getPost2(widget.cid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<DisplayPost> displayPost = snapshot.data;
                            if (displayPost.isEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wysiwyg_rounded, size: 50, color: Colors.white),
                                  SizedBox(height: 10),
                                  Text('No work posts yet',
                                      style: addressStyle()),
                                ],
                              );
                            } else {
                              List<DisplayPost> displayPost = snapshot.data;
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.4,
                                child: ListView.builder(
                                  itemCount: displayPost.length,
                                  itemBuilder: (context, int index) {
                                    if(displayPost[index].workPostId== null){
                                       return Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wysiwyg_rounded, size: 50, color: Colors.white),
                                  SizedBox(height: 10),
                                  Text('No work posts yet',
                                      style: addressStyle()),
                                ],
                              );
                                    }
                                    return postWidget(context, displayPost[index]);
                                  },
                                ),
                              );
                          }
                        }else if (snapshot.hasError) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off_outlined,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Connection error.',
                                  style: TextStyle(
                                    color: Color.fromRGBO(62, 135, 148, 1),
                                    fontSize: 12,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {
                                    // _refreshData(widget.id);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(62, 135, 148, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Try Again',
                                      style: mediumTextStyle(),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                         return loadingScreen(context,'Loading work posts');
                        }
                   
                        
        ),
     
    );
  }
}