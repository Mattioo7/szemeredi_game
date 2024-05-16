import 'package:flutter/material.dart';

class NumberTile extends StatelessWidget {
  const NumberTile({
    super.key,
    required this.number,
    required this.colorCode,
    required this.onPressed,
  });

  final int number;
  final int colorCode;
  final void Function(int number)? onPressed;

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
      case 3:
        backgroundColor = MaterialStateProperty.all<Color>(Colors.transparent);
      default:
        backgroundColor = MaterialStateProperty.all<Color>(Colors.grey);
    }

    return ElevatedButton(
      onPressed: onPressed != null ? () => onPressed!(number) : null,
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
        shadowColor: colorCode != 3 ? MaterialStateProperty.all(Colors.black) : MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      ),
      child: Text(
        '$number',
        style: TextStyle(
          fontSize: 24,
          color: colorCode != 3 ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
