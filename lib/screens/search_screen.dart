import 'package:flutter/material.dart';

import '../services/services.dart';
import '../models/searchResult.dart';
import '../styles/style.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _search = TextEditingController();
  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle = Text('Search worker...');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: [
          IconButton(icon: actionIcon, onPressed: (){
            setState(() {
              if(this.actionIcon.icon == Icons.search){
                this.actionIcon = Icon(Icons.close);
                this.appBarTitle = TextField(
                  controller: _search,
                  onSubmitted: (text){
                    print('Controller: $text');
                  },
                  style: TextStyle(color:Colors.white,),
                  decoration: InputDecoration(prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.white),
                  ),
                );
                print('okay');
              }else{
                this.actionIcon = Icon(Icons.search);
                this.appBarTitle = Text('Search worker...');
              }
            });
          
          }),
        ],
      ),
      body: Container(),
      
      
    );
  }
}