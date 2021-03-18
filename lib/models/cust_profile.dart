import 'package:flutter/material.dart';

class CustomerProfileGrid {
  final int id;
  final String title;
  final IconData icon;

  const CustomerProfileGrid({this.id, this.title, this.icon});

}

const List<CustomerProfileGrid> choices = const <CustomerProfileGrid>[
  const CustomerProfileGrid(id: 1, title: 'My Job Posts', icon: Icons.sticky_note_2),
  const CustomerProfileGrid(id: 2, title: 'My Requests', icon: Icons.article_rounded),
  const CustomerProfileGrid(id: 2, title: 'Settings', icon: Icons.settings),
 const CustomerProfileGrid(id: 2, title: 'Sign out', icon: Icons.logout),
  
  
];