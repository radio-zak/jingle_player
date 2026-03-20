import 'package:flutter/material.dart';
import 'package:jingle_player/ui/date_display.dart';
import 'package:jingle_player/ui/clock.dart';
import 'package:jingle_player/ui/time_remaining.dart';

class TopBar extends StatelessWidget {
  final String title;
  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      // height: 64,
      child: Padding(
        padding: EdgeInsetsGeometry.directional(
          end: 32,
          start: 32,
          top: 16,
          bottom: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 36),
              ),
            ),
            Expanded(child: TimeRemainingClock()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [StudioClock(), DateDisplay()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
