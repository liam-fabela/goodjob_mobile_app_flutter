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
  String cat;
  void didChangeDependencies() {
    final worker =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    id = worker['id'];
    cat = worker['category'];
    wid = int.parse(id);
    super.didChangeDependencies();
  }

   Future<void> _refreshData(int wid) async {
    setState(() {
      
    });
    return Services.getReviews(wid);
    
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, cat),
      body: RefreshIndicator(
            onRefresh: ()=> _refreshData(wid),
              child: Center(
          child: FutureBuilder<List<WorkerIndividual>>(
              future: Services.getProfile(wid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<WorkerIndividual> workerIndividual = snapshot.data;
                  return WorkerDetails(workerIndividual,id);
                } else if (snapshot.hasError) {
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
                        'Connection Error.',
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
                        onTap: ()=> _refreshData(wid),
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
                    ],
                  );
                }
                return loadingScreen(context, 'Loading...');
              }),
        ),
      ),
    );
  }
}
