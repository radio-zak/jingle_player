import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class StudioClock extends StatelessWidget {
  const StudioClock({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [Clock(), DateDisplay()],
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});
  @override
  State<Clock> createState() {
    return ClockState();
  }
}

class ClockState extends State<Clock> {
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
