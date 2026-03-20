import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateDisplay extends StatefulWidget {
  const DateDisplay({super.key});
  @override
  State<DateDisplay> createState() {
    return DateDisplayState();
  }
}

class DateDisplayState extends State<DateDisplay> {
  DateTime currentTime = DateTime.now();
  String currentDateFormat = '';
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTime = DateTime.now();
        initializeDateFormatting('pl_PL', null).then(
          (_) => currentDateFormat = DateFormat.yMMMMEEEEd(
            'pl_PL',
          ).format(currentTime),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentDateFormat,
      style: TextStyle(fontSize: 24, color: Colors.white),
    );
  }
}
