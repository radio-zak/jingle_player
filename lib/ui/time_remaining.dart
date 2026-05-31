import 'package:flutter/material.dart';
import 'package:jingle_player/audio_handler.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';

class TimeRemainingClock extends StatelessWidget {
  const TimeRemainingClock({super.key});

  @override
  Widget build(BuildContext context) {
    AudioHandler player = Provider.of<AudioHandler>(context, listen: true);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(4),

        color: player.audioPlayer.state == PlayerState.playing
            ? Colors.red
            : player.editMode
            ? Colors.orange
            : player.sourceFileParsed == null
            ? Theme.of(context).colorScheme.primaryFixedDim
            : Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(4),
        child: Align(
          alignment: FractionalOffset.topCenter,
          child: Consumer<AudioHandler>(
            builder: (context, player, child) {
              return Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      player.audioPlayer.state != PlayerState.playing
                          ? Duration.zero.toString().split('.').first
                          : player.timeRemainingString,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      player.audioPlayer.state != PlayerState.playing
                          ? Duration.zero.toString().split('.').first
                          : 'placeholder',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
