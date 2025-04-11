import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
    DropDownField({
    super.key,
    this.title, this.value = 1,
      this.onChanged
  });

  final String? title;
  int value;
  void Function(int?)? onChanged;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(title??'',),
        DropdownButtonFormField(
          borderRadius: BorderRadius.circular(7),
          alignment: AlignmentDirectional.bottomCenter,
          value: value,
          style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
          icon: Icon(Icons.keyboard_arrow_down_sharp, size: 16),
          items: [
            DropdownMenuItem(value: 2,child: Text("Binary",),),
            DropdownMenuItem(value: 1,child: Text("Decimal"),)
          ],
          onChanged: onChanged,
        )
      ],
    );
  }
}
