import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../widget/notif_work_post.dart';
import '../widget/notif_work_request.dart';


class NotificationTab extends StatelessWidget {
  final int cid;
  NotificationTab(this.cid);

  


  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
  WorkRequestContainer(cid),
  WorkPostContainer(),
];
    return DefaultTabController(
        length: 2,
          child: Scaffold(
        appBar: AppBar(
      title: Text(
       'Notifications',
        style: mediumTextStyle(),
        
      ),
      automaticallyImplyLeading: false,
      bottom: TabBar(
        tabs: [
          Tab(
            text: 'Work Requests',
          ),
          Tab(
            text: 'Work Posts'
          ),
        ],
      ),
  ),
  body: TabBarView(
    children: pages,
  ),

      ),
    );
  }
}