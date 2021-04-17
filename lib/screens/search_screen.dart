import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

import '../services/services.dart';
import '../models/searchResult.dart';
import '../styles/style.dart';

class SearchScreen extends StatelessWidget {

  Widget searchResultTile(BuildContext context, SearchResults searchResults){
    return Container(
      padding: EdgeInsets.all(15),
      child: ListTile(
        leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(searchResults.profile), 
                        backgroundColor:  Color.fromRGBO(75, 210, 178, 1),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                        ),
                      ),
         title: Row(children: [
                          Text(searchResults.fname, style: profileName()),
                          SizedBox(width: 10),
                           Text(searchResults.lname, style: profileName()),

                  ],),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(children: [
                          Text(searchResults.zone, style:  TextStyle(
                                        color: Color.fromRGBO(62, 135, 148, 1),
                                        fontSize: 12,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        ),),
                          SizedBox(width: 10),
                           Text(searchResults.barangay, style: addressStyle()),
                           
                  ],),
                   Text(searchResults.city, style: addressStyle()),

                  ]),
                  trailing: 
                      Stack(
                        children: [
                          Container(
                            //padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: Image.network(searchResults.docImg),
                            
                          ),
                            Positioned(
                    bottom: 10,
                    right: 5,
                    child: Container(
                     // width: MediaQuery.of(context).size.width * 0.6,
                      color: Color.fromRGBO(29, 171, 145, 0.7),
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal:5),
                      child: Text(
                        'credibility',
                        style: TextStyle(
                         fontSize: 8,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                        ],
                      ),
        onTap: (){
        
        },
       
      
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    
    Future<List<SearchResults>> search(String search)async{
      var searchResults = await Services.searchWorker(search);
      return searchResults;
    }
    return Scaffold(
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SearchBar<SearchResults>(
        onSearch: search,
        onItemFound: (SearchResults searchResults, int index){
            return searchResultTile(context, searchResults);
        },
      ),
      ),
      
    );
  }
}