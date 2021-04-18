import 'package:flutter/material.dart';

import '../helper/shared_preferences.dart';
import '../styles/style.dart';
import '../models/widget_data.dart';
import '../widget/worker_profile_grid.dart';

class WorkerProfilePage extends StatefulWidget {
  @override
  _WorkerProfilePageState createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  Future<int> tem;

  @override
  void initState(){
   tem = SharedPrefUtils.getUser('userId');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(170, 225, 227, 0.3),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              top: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,

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
                      height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                            bottom: 30,
                          ),
                           child: GridView(
                             padding: const EdgeInsets.all(10),
                             children: WORKER_PROFILE
                             .map((gridData) => WorkerProfileGrid(
                               gridData.id,
                               gridData.title,
                               gridData.icon,
                             ),)
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
          ],
        ),
      ),
    );
  }
}
