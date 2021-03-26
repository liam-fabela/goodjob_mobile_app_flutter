import 'package:flutter/material.dart';

import '../styles/style.dart';

class CategoryChoices extends StatefulWidget {
  final String choice;
  CategoryChoices(this.choice);
  @override
  _CategoryChoicesState createState() => _CategoryChoicesState();
}

class _CategoryChoicesState extends State<CategoryChoices> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.choice, style: addressStyle2()),
      selected: _isSelected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Color.fromRGBO(62, 135, 148, 0.5),
      onSelected: (isSelected){
        setState(() {
          _isSelected = isSelected;
        });
        print(_isSelected);
      },
      selectedColor: Color.fromRGBO(62, 135, 148, 1),
      );
  }
}