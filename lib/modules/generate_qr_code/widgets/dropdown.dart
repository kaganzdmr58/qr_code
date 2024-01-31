
import 'package:flutter/material.dart';
import 'package:qr_code/globals/tools.dart';

class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String selectedValue = 'Web';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      
      value: selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
      },
      // Set the dropdown button width
      // You can also use dropdownButtonWidth parameter in DropdownButton widget
      // if you want to set a fixed width for the dropdown button
      // dropdownButtonWidth: 200.0,
      items: [
        'Web',
        'Text',
        'Wifi',
        'Wifi',
        'Wifi',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            // Set the height of each dropdown menu item
            height: 50.0,
            width: getScreenWidth(context)- 300,
            child: Center(
              child: Text(value),
            ),
          ),
        );
      }).toList(),
    );
  }
}