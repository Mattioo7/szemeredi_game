import 'package:flutter/material.dart';

class NumberTile extends StatelessWidget {
  const NumberTile({
    super.key,
    required this.number,
    required this.colorCode,
  });

  final int number;
  final int colorCode;

  @override
  Widget build(BuildContext context) {
    MaterialStateProperty<Color> backgroundColor;
    switch (colorCode) {
      case 0:
        backgroundColor = MaterialStateProperty.all<Color>(Colors.grey);
      case 1:
        backgroundColor = MaterialStateProperty.all<Color>(Colors.blue);
      case 2:
        backgroundColor = MaterialStateProperty.all<Color>(Colors.red);
      default:
        backgroundColor = MaterialStateProperty.all<Color>(Colors.grey);
    }

    return ElevatedButton(
      onPressed: () {
        // Handle button press
        print('Tile $number pressed');
      },
      style: ButtonStyle(
        backgroundColor: backgroundColor,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Ensuring the button is square depending on its context
        minimumSize: MaterialStateProperty.all<Size>(const Size(100, 100)), // Example fixed size, adjust as needed
      ),
      child: Text(
        '$number',
        style: const TextStyle(
          fontSize: 24, // Adjust the font size as per your design
          color: Colors.white, // Text color
        ),
      ),
    );
  }
}
