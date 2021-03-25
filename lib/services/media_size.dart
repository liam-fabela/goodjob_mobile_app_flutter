import 'package:flutter/material.dart';

class DeviceSize {
  String dim;
  double size;
  
  DeviceSize(this.dim, this.size);

  static List getSize(BuildContext context) {

     List media =[];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    media.add(DeviceSize('width', width));
    media.add(DeviceSize('height', height));
   
  }

}