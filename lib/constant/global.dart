import 'dart:math';

import 'package:dio/dio.dart';
import 'package:e_commerce/Models/UserDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

const String mandatoryChar = "*";
const String lastNotificationId = "last_notification_id";

SharedPreferences sharedPreferences;
UserDetails userdata;
Config config;
Locale appLocale;

extension RandomInt on int {
  static int generate({int min = 1000, int max = 9999}) {
    final _random = Random();
    return min + _random.nextInt(max - min);
  }
}

FormData SMS_DATA({String mobile, String message}) {
  return FormData.fromMap({
    "user": config.smsUserName,
    "password": config.smsPassword,
    "msisdn": mobile,
    "sid": config.smsSenderId,
    "msg": "<#> $message",
    "fl": config.smsFL,
    "gwid": config.smsGwID
  });
}

String removeHtmlTags({String data : "N/A"}) {
  RegExp regExp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return data
      .replaceAll(regExp, "")
      .replaceAll("&nbsp;", " ")
      .replaceAll("&amp;", "&")
      .replaceAll("&quot;", "\"") ?? "N/A";
}
