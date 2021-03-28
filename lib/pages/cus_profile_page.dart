import 'package:flutter/material.dart';

//import '../models/cust_profile.dart';
import '../models/widget_data.dart';
import '../widget/cust_profile_grid.dart';
import '../models/cus_display_profile.dart';
import '../widget/customer_display.dart';
import '../services/services.dart';

class CustomerProfilePage extends StatefulWidget {
  final int id;
  CustomerProfilePage(this.id);
  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(170, 225, 227, 0.3),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            height: MediaQuery.of(context).size.height * 0.25,
            child: FutureBuilder<List<CustomerProfile>>(
              future: Services.getCustomerDisplay(widget.id),
            ),
          ),
          SingleChildScrollView(
            child: Stack(children: [
              Container(
                padding: EdgeInsets.only(
                  top: 30,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Color.fromRGBO(62, 135, 148, 1)),
                height: MediaQuery.of(context).size.height * 0.66,
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
                    padding: EdgeInsets.all(20),
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

              //width: MediaQuery.of(context).size.width * 0.85,
              // padding: EdgeInsets.all(20.0),
            ]),
          ),
        ],
      ),
    );
  }
}
