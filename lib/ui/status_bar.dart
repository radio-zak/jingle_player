import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/audio_handler.dart';

class StatusBar extends StatelessWidget {
  StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioHandler>(
      builder: (context, player, child) {
        return Center(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                player.sourceFileParsed != null
                    ? '${player.sourceFileParsed}'
                    : 'No file selected',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Flexible(
                child: LinearProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  value:
                      // (player.playerPosition != null &&
                      //     player.playerDuration != null &&
                      (player.playerPosition.inMilliseconds > 0 &&
                          player.playerPosition.inMilliseconds <
                              player.playerDuration.inMilliseconds)
                      ? player.playerPosition.inMilliseconds /
                            player.playerDuration.inMilliseconds
                      : 0.0,
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      player.playerPositionString,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    player.sourceFileParsed != null
                        ? Center(
                            child: VerticalDivider(
                              color: Colors.white,
                              // thickness: 2,
                              // width: 4,
                            ),
                          )
                        : Container(),
                    Text(
                      player.playerDurationString,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
