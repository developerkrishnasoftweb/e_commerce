import 'package:e_commerce/constant/color.dart';
import 'package:flutter/material.dart';

AppBar appBar(
    {@required BuildContext context,
    String title,
    List<Widget> actions,
    ShapeBorder shape,
    Widget leading,
    bool centerTitle,
    Color backgroundColor,
    PreferredSizeWidget bottom,
    Color leadingColor}) {
  if (leading == null)
    leading = IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        if(Navigator.canPop(context))
          Navigator.pop(context);
      },
      iconSize: 20,
      splashRadius: 25,
    );
  return AppBar(
    backgroundColor: backgroundColor ?? primaryColor,
    title: Text(
      title != null ? title : "",
      style: Theme.of(context).textTheme.bodyText1.copyWith(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1),
    ),
    actions: actions,
    shape: shape ?? null,
    leading: leading,
    elevation: 0,
    centerTitle: centerTitle ?? false,
    iconTheme: IconThemeData(color: leadingColor ?? Colors.white, size: 20),
    bottom: bottom ?? null,
  );
}
