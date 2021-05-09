import 'package:flutter/material.dart';
import '../models/widget_data.dart';
import '../widget/cust_profile_grid.dart';
import '../widget/customer_display.dart';
import '../helper/shared_preferences.dart';
import '../styles/style.dart';
import '../helper/firebase_user.dart';

class CustomerProfilePage extends StatefulWidget {
  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  var cid;
  var fullname;
  int id;
  String cus;
  Future<int> tem;

  @override
  void initState(){
   tem = SharedPrefUtils.getUser('userId');
    super.initState();
  }

  getData()async{
    
    cid = await SharedPrefUtils.getUser('userId');
    cus = cid.toString();
    id = int.parse(cus);
 
    //cid = await SharedPrefUtils.getUser('userId');
    cus = cid.toString();
    id = int.parse(cus);
    print('MAO NI: $id');
    fullname = await SharedPrefUtils.getUserName('userName');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(170, 225, 227, 0.3),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                  child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: FutureBuilder(
                      future: tem,
                      builder: (context, snapshot){
                        if(snapshot.connectionState != ConnectionState.done){
                           return shimmerEffect(context);
                        }
                        final cust = snapshot.data.toString();
                        final custId = int.parse(cust);
                        UserProfile.dbUser = custId;
                        return CustomerDisplay(custId);
                      }
                  ),
                ),
              ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.3,
                      child: Container(
                      padding: EdgeInsets.only(
                        top: 30,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Color.fromRGBO(62, 135, 148, 0.7)),
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Color.fromRGBO(75, 210, 178, 1),
                        ),
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                            bottom: 30,
                          ),
                          // color: Colors.grey,
                          child: GridView(
                            padding: const EdgeInsets.all(10),
                            children: PROFILE_GRID
                                .map(
                                  (gridData) => CustomerGridItem(
                                    gridData.id,
                                    gridData.title,
                                    gridData.icon,
                                  ),
                                )
                                .toList(),
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 1,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //width: MediaQuery.of(context).size.width * 0.85,
           
             
            ],
          ),
        );
  }
}
