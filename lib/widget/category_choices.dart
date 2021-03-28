import 'package:flutter/material.dart';

import '../styles/style.dart';

class CategoryChoices extends StatefulWidget {
  final Function getState;
  CategoryChoices(this.getState);
  @override
  _CategoryChoicesState createState() => _CategoryChoicesState();
}

class _CategoryChoicesState extends State<CategoryChoices> {
  var _selectedChip1 = false;
  var _selectedChip2 = false;
  var _selectedChip3 = false;
  var _selectedChip4 = false;
  var _choice1 = 'House chore';
  var _choice2 = 'Personal errand';
  var _choice3 = 'Beauty&Grooming';
  var _choice4 = 'House repair';
   int choice;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          ChoiceChip(
            label: Text(_choice1, style: addressStyle2()),
            selected: _selectedChip1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Color.fromRGBO(62, 135, 148, 0.5),
            onSelected: !_selectedChip2 && !_selectedChip3 && !_selectedChip4 ? (val) {
              setState(() {
                 _selectedChip1 =  !_selectedChip1;
                widget.getState(_selectedChip1, _choice1);
              });
             
            }: null,
            selectedColor: Color.fromRGBO(62, 135, 148, 1),
          ),
          ChoiceChip(
            label: Text(_choice2, style: addressStyle2()),
            selected:_selectedChip2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Color.fromRGBO(62, 135, 148, 0.5),
            onSelected:!_selectedChip1 && !_selectedChip3 && !_selectedChip4 ? (val) {
              setState(() {
                 _selectedChip2 = !_selectedChip2;
                 widget.getState(_selectedChip2,_choice2);
              });
              
            }: null,
            selectedColor: Color.fromRGBO(62, 135, 148, 1),
          ),
          ChoiceChip(
            label: Text(_choice3, style: addressStyle2()),
            selected: _selectedChip3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Color.fromRGBO(62, 135, 148, 0.5),
            onSelected: !_selectedChip1 && !_selectedChip2 && !_selectedChip4 ? (val) {
              setState(() {
                 _selectedChip3 = !_selectedChip3;
                 widget.getState(_selectedChip3,_choice3);
              });
            }: null,
            selectedColor: Color.fromRGBO(62, 135, 148, 1),
          ),
          ChoiceChip(
            label: Text(_choice4, style: addressStyle2()),
            selected: _selectedChip4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Color.fromRGBO(62, 135, 148, 0.5),
            onSelected: !_selectedChip1 && !_selectedChip2 && !_selectedChip3 ? (val) {
              setState(() {
                 _selectedChip4 = !_selectedChip4;
                widget.getState( _selectedChip4,_choice4);
              });
            
            }: null,
            selectedColor: Color.fromRGBO(62, 135, 148, 1),
          ),
        ],
      ),
    );
  }
}
