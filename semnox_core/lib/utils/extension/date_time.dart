import 'package:flutter/material.dart';

extension DateTimeFormat on DateTime{
  String formatToToday(){
    return "$year-$month-$day" ;  
  }

  String formatWithTime(){
    return formatToToday()+ " "+hour.toString().padLeft(2,"0")+":"+minute.toString().padLeft(2,"0");
  }
    DateTime applied(TimeOfDay? time) {
    return DateTime(
        year, month, day, time?.hour ?? hour, time?.minute ?? minute);
  }
}

