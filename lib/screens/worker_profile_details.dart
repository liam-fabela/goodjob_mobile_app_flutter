import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../services/services.dart';
import '../models/worker_individual.dart';
import '../widget/worker_details.dart';

class ProfileDetails extends StatefulWidget {
  static const routeName = '/profile_detail';
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
   int wid;
    String id;
  void didChangeDependencies() {
   final worker = ModalRoute.of(context).settings.arguments as Map<String, String>;
   id = worker['id'];
    wid = int.parse(id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  appBarSign(context, ''),   
      body: Center(
        child: FutureBuilder<List<WorkerIndividual>>(
          future: Services.getProfile(wid),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              List<WorkerIndividual> workerIndividual = snapshot.data;
              return WorkerDetails(workerIndividual);
            }else if(snapshot.hasError){
               return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(Icons.error,size:50, color: Colors.white,),
                  SizedBox(height:15),
                  Text('Something went wrong.',style: TextStyle(
                                        color: Color.fromRGBO(62, 135, 148, 1),
                                        fontSize: 12,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.center,
                                  ), 
                    SizedBox(height:15),
                    GestureDetector(
                                onTap: (){
                                //  _refreshData(widget.id);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 0.3,
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
                     ),
                ],);

            }
           return loadingScreen(context,'Loading...');
          }
        ),
      ),
      
    );
  }
}