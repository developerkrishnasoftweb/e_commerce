import 'package:flutter/material.dart';

Widget dropDown<T>(
    {String label,
      List<DropdownMenuItem> items,
      T value,
      EdgeInsetsGeometry margin,
      double height,
      ValueChanged<T> onChanged}) {
  return Padding(
    padding: margin ?? EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff8B8B8B))),
        SizedBox(height: 5),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: height ?? 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(7)),
            child: DropdownButton<T>(
              onChanged: onChanged,
              underline: SizedBox(),
              value: value,
              isExpanded: true,
              items: items,
            ))
      ],
    ),
  );
}