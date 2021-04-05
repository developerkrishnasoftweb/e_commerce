
import 'package:e_commerce/Models/MainCategory.dart';

class Preferences{
  static String user = 'user';
}

getPrice(Products item){
  return "\u20b9${item.attributes.specialPrice != "0" ? item.attributes.specialPrice : item.price * item.quantity}";
}

getMRP(Products item){
  return item.attributes.specialPrice != "0" && item.price != 0 ? "\u20b9${item.price}" : '';
}

getSavingPrice(Products item){
  return item.attributes.specialPrice != "0" && item.price != 0
      ? "You Save \u20b9${(item.price - double.parse(item.attributes.specialPrice)) * item.quantity}"
      : '';
}

getDiscountPercentage(Products item){
  double specialPrice = double.parse(item.attributes.specialPrice) * 100;
  double discount = (specialPrice / item.price);
  return "${100 - discount.toInt()}%\nOFF";
}