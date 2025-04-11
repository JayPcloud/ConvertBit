import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key,required this.text, required this.color, this.icon, this.onPressed});

  final String text;
  final IconData? icon;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: color,
        onPressed: onPressed,
        child: Row(
          spacing: 2,
          children: [
            if(icon!=null)Icon(
              icon,
              color: Colors.white,
              size: 15,
            ),
            Text(text, style: TextStyle(color: Colors.white)),
          ],
        ));
  }
}
