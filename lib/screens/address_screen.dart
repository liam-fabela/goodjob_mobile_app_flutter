import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../styles/style.dart';
import '../widget/address_search.dart';
import '../services/place_service.dart';


class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _controller = TextEditingController();
  String _streetNumber;
  String _street;
  String _city;
  String _zipCode;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, ''),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            readOnly: true,
            decoration: textFieldInputDecoration('Enter address'),
            onTap: () async{
            
                final sessionToken = Uuid().v4();
                final Suggestion result = await showSearch(
                context: context,
                delegate: AddressSearch(sessionToken),
                );
                if(result != null){
                  final placeDetails = await PlaceApiProvider(sessionToken)
                    .getPlaceDetailFromId(result.placeId);
                    setState(() {
                      _controller.text = result.description;
                      _streetNumber = placeDetails.streetNumber;
                      _street = placeDetails.street;
                      _city = placeDetails.city;
                      _zipCode = placeDetails.zipCode;
                    });
                }
            },
          ),
          SizedBox(height: 20),
          Text('Street Number: $_streetNumber'),
          Text('Street: $_street'),
          Text('City: $_city'),
          Text('Zip Code: $_zipCode'),
        ],
      ),
      
    );
  }
}