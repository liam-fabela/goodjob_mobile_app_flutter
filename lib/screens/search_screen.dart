import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/services.dart';
import '../models/searchResult.dart';
import '../styles/style.dart';
import '../screens/worker_profile_details.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _fname = false;
  var _lname = false;
  var _barangay = false;
  var _isLoading = false;
   final formKey = GlobalKey<FormState>();

  String _choice2;
  TextEditingController _search = TextEditingController();
  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle = Text('Search worker...');
  List<SearchResults> searchResults;

  @override
  void initState() {
   searchResults = [];
    super.initState();
  }

  void _getFilterkey(bool state, String option) {
    if (state && option == 'firstname') {
      _choice2 = 'firstname';
      print("CHOICE CHIP: " + _choice2);
    } else if (state && option == 'lastname') {
      _choice2 = 'lastname';
       print("CHOICE CHIP: " + _choice2);
    } else {
      _choice2 = 'barangay';
       print("CHOICE CHIP: " + _choice2);
    }
  }

  Widget results(BuildContext context, SearchResults searchResults){
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
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
                          Text(searchResults.zone, style:  TextStyle(
                                        color: Color.fromRGBO(62, 135, 148, 1),
                                        fontSize: 12,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        ),),
                           Text(searchResults.barangay, style: addressStyle()),
                           
                  
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
         Navigator.pushNamed(context, ProfileDetails.routeName,
         arguments:{
           'id': searchResults.id,
           'category':  searchResults.catType,
           'uid':  searchResults.uid,
           'catId': searchResults.catId,
           }
         );
        },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: [
          IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = Icon(Icons.close);
                    this.appBarTitle = 
                         TextField(
                        controller: _search,
                        onSubmitted: (text) async{
                          setState(() {
                            _isLoading =  true;
                          });
                          print('Controller: $text');
                             if(_choice2 == null){
                               return;
                             }
                             if(_search.text == null){
                               return;
                             }
                           await Services.searchWorker(_search.text, _choice2).then((val){
                             searchResults = val;
                            print("search length: "+ searchResults.length.toString());
                             setState(() {
                            _isLoading =  false;
                          });
                          });
                         
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      );
                   
                    print('okay');
                    
                  } else {
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle = Text('Search worker...');
                  }
                });
              }),
        ],
      ),
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Text('Filter Search', style: addressStyle3()),
              Container(
                padding: EdgeInsets.all(5),
                child: Wrap(
                  spacing: 2,
                  // runSpacing: 2,
                  children: [
                    ChoiceChip(
                      label: Text('firstname', style: addressStyle3()),
                      selected: _fname,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Color.fromRGBO(62, 135, 140, 0.5),
                      onSelected: !_lname && !_barangay
                          ? (val) {
                              setState(() {
                                _fname = !_fname;
                                _getFilterkey(_fname, 'firstname');
                              });
                            }
                          : null,
                      selectedColor: Color.fromRGBO(62, 135, 148, 1),
                    ),
                    ChoiceChip(
                      label: Text('lastname', style: addressStyle3()),
                      selected: _lname,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Color.fromRGBO(62, 135, 140, 0.5),
                      onSelected: !_fname && !_barangay
                          ? (val) {
                              setState(() {
                                _lname = !_lname;
                                _getFilterkey(_lname, 'lastname');
                              });
                            }
                          : null,
                      selectedColor: Color.fromRGBO(62, 135, 148, 1),
                    ),
                    ChoiceChip(
                      label: Text('barangay', style: addressStyle3()),
                      selected: _barangay,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Color.fromRGBO(62, 135, 140, 0.5),
                      onSelected: !_fname && !_lname
                          ? (val) {
                              setState(() {
                                _barangay = !_barangay;
                                _getFilterkey(_barangay, 'barangay');
                              });
                            }
                          : null,
                      selectedColor: Color.fromRGBO(62, 135, 148, 1),
                    ),
                  ],
                ),
              ),
              Divider(),
             _isLoading ? 
              Padding(
                padding: EdgeInsets.only( top: MediaQuery.of(context).size.height * 0.3),
                child: Center(
            child: SpinKitSquareCircle(
                  color: Color.fromRGBO(62, 135, 148, 1), size: 50.0),
          ),
              )
             :Container(
               height: MediaQuery.of(context).size.height * 0.5,
               child: ListView.builder(
                 itemCount: searchResults.length,
                 itemBuilder: (context, int index){
                   if(searchResults.isEmpty){
                     return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(height: 15),
                              Text(
                                'No result found.',
                                style: TextStyle(
                                  color: Color.fromRGBO(62, 135, 148, 1),
                                  fontSize: 12,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                   }
                   return results(context, searchResults[index]);
                 }
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
