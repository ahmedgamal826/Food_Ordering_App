import 'package:flutter/material.dart';

class MyRadioButton extends StatefulWidget {
  @override
  _MyRadioButtonState createState() => _MyRadioButtonState();
}

class _MyRadioButtonState extends State<MyRadioButton> {
  String selectedValue = ''; // Initially no selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single Radio Button'), // Optional app bar for clarity
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the column
          children: [
            RadioListTile(
              title: Text('Option 1'), // Define text and value directly
              value: 'option1',
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                  print("Selected Value = $selectedValue");
                });
              },
              activeColor: Colors.orange,
              selectedTileColor: Colors.red,
            ),
            // Add more RadioListTile widgets as needed for other options
            RadioListTile(
              title: Text('Option 2'),
              value: 'option2',
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                  print("Selected Value = $selectedValue");
                });
              },
              activeColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
