import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant/color.dart';

Widget input(
    {InputDecoration decoration,
    TextStyle style,
    GestureTapCallback onTap,
    TextEditingController controller,
    bool obscureText,
    bool autoFocus,
    ValueChanged<String> onChanged,
    VoidCallback onEditingComplete,
    String text,
    TextInputType keyboardType,
    bool readOnly,
    EdgeInsetsGeometry margin,
    double width,
    TextStyle labelStyle,
    TextInputAction textInputAction,
    FocusNode focusNode,
    double height,
    FormFieldValidator<String> validator,
    int maxLines}) {
  return Container(
    margin: margin ?? const EdgeInsets.all(10),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text != null
            ? Text(
                text,
                style: labelStyle ??
                    TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8B8B8B)),
              )
            : SizedBox(),
        SizedBox(
          height: text != null ? 5 : 0,
        ),
        Container(
          height: height,
          child: TextFormField(
            autofocus: autoFocus ?? false,
            maxLines: maxLines ?? 1,
            decoration: decoration ??
                InputDecoration(
                    contentPadding: EdgeInsets.all(10), border: border()),
            validator: validator,
            style: style ?? null,
            onTap: onTap ?? null,
            controller: controller ?? null,
            obscureText: obscureText ?? false,
            onChanged: onChanged ?? null,
            onEditingComplete: onEditingComplete ?? null,
            textInputAction: textInputAction ?? null,
            keyboardType: keyboardType,
            readOnly: readOnly ?? false,
            focusNode: focusNode,
            cursorColor: primaryColor,
          ),
        ),
      ],
    ),
  );
}

OutlineInputBorder border({double borderRadius}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 6),
      borderSide: BorderSide(color: Colors.grey));
}
