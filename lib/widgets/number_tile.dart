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
        minimumSize: MaterialStateProperty.all<Size>(const Size(100, 100)),
        elevation: MaterialStateProperty.all(5),
        surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.black),
      ),
      child: Text(
        '$number',
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
