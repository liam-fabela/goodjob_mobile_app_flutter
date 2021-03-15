import 'package:flutter/material.dart';

import '../pages/worker_home_page.dart';
import '../pages/worker_message_page.dart';
import '../pages/worker_profile_page.dart';
import '../pages/worker_work_page.dart';

import '../styles/style.dart';


class WorkerHomeScreen extends StatefulWidget {
  static const routeName = '/worker_home';
  @override
  _WorkerHomeScreenState createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
   List<Map<String, Object>> _pages = [
    {
     'page': WorkerHomePage(),
     'title': 'Home',
    },
    {
    'page': WorkerProfilePage(),
    'title': 'Profile',
    },
    {
    'page': WorkerWorkPage(),
    'title': 'My Work',
    },
    {
    'page': WorkerMessagePage(),
    'title': 'Messages',
    },
  ];

  int _selectedPageIndex = 0;

   void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar:  appBarSign(
       // context, _pages[_selectedPageIndex]['title']
     // ),
      body:
       _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          backgroundColor:  Color.fromRGBO(75, 210, 178, 1),//Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
             BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.work),
              title: Text('My Work'),
            ),
             BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.message),
              title: Text('Messages'),
            ),
          ]),
      
    );
  }
}
