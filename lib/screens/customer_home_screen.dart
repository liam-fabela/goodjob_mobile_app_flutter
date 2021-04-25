import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';


import '../pages/cus_home_page.dart';
import '../pages/cus_profile_page.dart';
import '../pages/cus_request_page.dart';
import '../pages/cus_message_page.dart';
//import '../helper/shared_preferences.dart';


class CustomerHomeScreen extends StatefulWidget {
  static const routeName = '/customer_home';
  
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  
   List<Map<String, Object>> _pages = [
    {
     'page': CustomerHomePage(),
     'title': 'Home',
    },
    {
    'page': CustomerProfilePage(),
    'title': 'Profile',
    },
    {
    'page': CustomerRequestPage(),
    'title': 'My Requests',
    },
    {
    'page': CustomerMessagePage(),
    'title': 'Messages',
    },
  ];

  

  int _selectedPageIndex = 0;
  int userOfApp;
 



   void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
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
              icon: Icon(Icons.notifications),
              title: Text('Notifications'),
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