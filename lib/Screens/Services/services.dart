import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';

class Services extends StatefulWidget {
  const Services({ Key key }) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  
  String valueChoose;
  List listItem = [
    "Certificate with Detailed Salary",
    "Certificte with Total Salary",
    "Certificate with Without Salary",
    "Others",
  ]; 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(15)
          ),
          child: DropdownButton(
            hint: Text("Select Options"),
            dropdownColor: const Color(0xFF6392B0),
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(
              color: Color.fromRGBO(247, 227, 112, 1.0),
              fontSize: 22,
            ),
            value: valueChoose,
            onChanged: (newValue) {
              setState(() {
                valueChoose = newValue;
              });
            },
            items: listItem.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            },
          ).toList(),
          ),
        ),
      ),
    );
  }
}