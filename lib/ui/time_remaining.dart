import 'package:flutter/material.dart';
import 'package:jingle_player/audio_handler.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class TimeRemainingClock extends StatelessWidget {
  const TimeRemainingClock({super.key});
  @override
  Widget build(BuildContext context) {
    AudioHandler player = Provider.of<AudioHandler>(context, listen: true);
    return Container(
      color: player.audioPlayer.state == PlayerState.playing
          ? Colors.red
          : player.editMode
          ? Colors.orange
          : player.sourceFileParsed == null
          ? Theme.of(context).colorScheme.primaryFixedDim
          : Theme.of(context).colorScheme.primary,
      padding: EdgeInsetsGeometry.all(16),
      child: Align(
        alignment: FractionalOffset.center,
        child: Consumer<AudioHandler>(
          builder: (context, player, child) {
            return Text(
              player.audioPlayer.state != PlayerState.playing
                  ? Duration.zero.toString().split('.').first
                  : player.timeRemainingString,
              style: Theme.of(context).textTheme.displayLarge,
            );
          },
        ),
      ),
    );
  }
}
