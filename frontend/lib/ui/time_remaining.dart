import 'package:flutter/material.dart';
import '../audio_handler.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';

class TimeRemainingClock extends StatelessWidget {
  TimeRemainingClock({super.key});

  String calculateEndTime(Duration fileDuration) {
    return DateFormat.Hms().format(DateTime.now().add(fileDuration));
  }

  @override
  Widget build(BuildContext context) {
    AudioProvider player = Provider.of<AudioProvider>(context, listen: true);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(4),

        color: player.playbackStatus == "PLAYING"
            ? Colors.red
            : player.editMode
            ? Colors.orange
            : player.activeSlotID == null
            ? Theme.of(context).colorScheme.primaryFixedDim
            : Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(4),
        child: Align(
          alignment: FractionalOffset.center,
          child: Consumer<AudioProvider>(
            builder: (context, player, child) {
              switch (player.isAudioStatusConnected) {
                case true:
                  return Text(
                    player.playbackStatus != "PLAYING"
                        ? Duration.zero.toString().split('.').first
                        : Duration(
                            milliseconds: (player.timeRemaining * 1000).round(),
                          ).toString().split('.').first,
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                case false:
                  return Text(
                    "OFFLINE",
                    style: Theme.of(context).textTheme.displayLarge,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
