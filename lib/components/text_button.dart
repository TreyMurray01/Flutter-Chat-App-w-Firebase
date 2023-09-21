import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class MyTextButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const MyTextButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ));
  }
}
