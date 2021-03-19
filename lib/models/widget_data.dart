import 'package:flutter/material.dart';
import 'work_category.dart';
import 'cust_profile.dart';

const CATEGORY_DATA = const [
  WorkCategory(
    id: '1',
    title: 'House Chores',
    img: 'assets/images/good_job.png',
  ),
  WorkCategory(
    id: '2',
    title: 'Personal Errands',
    img: 'assets/images/errand.jpg',
  ),
  WorkCategory(
    id: '3',
    title: 'Beauty&Grooming',
    img: 'assets/images/beauty.jpg',
  ),
  WorkCategory(
    id: '4',
    title: 'Home Repair',
    img: 'assets/images/home_repair.jpg',
  ),
];

const PROFILE_GRID = const [
  CustomerProfileGrid(id: 1, title: 'My Job Posts', icon: Icons.sticky_note_2),
  CustomerProfileGrid(id: 2, title: 'My Requests', icon: Icons.article_rounded),
  CustomerProfileGrid(id: 3, title: 'Settings', icon: Icons.settings),
  CustomerProfileGrid(id: 4, title: 'Sign out', icon: Icons.logout),
];