import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class StudioClock extends StatefulWidget {
  const StudioClock({super.key});
  @override
  State<StudioClock> createState() {
    return StudioClockState();
  }
}

class StudioClockState extends State<StudioClock> {
  DateTime currentTime = DateTime.now();
  String currentTimeFormat = '';
  String currentDateFormat = '';
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTime = DateTime.now();
        currentTimeFormat = DateFormat.Hms().format(currentTime);
      });
    });
  }

  @override
  build(BuildContext context) {
    return Container(
      // color: Colors.redAccent,
      // margin: EdgeInsetsGeometry.all(16),
      child: Text(
        currentTimeFormat,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
