import "package:flutter/material.dart";
import "package:audioplayers/audioplayers.dart";
import "package:jingle_player/audio_handler.dart";
import "package:provider/provider.dart";
import 'package:jingle_player/ui/action_button.dart';

class PlayerSection extends StatelessWidget {
  const PlayerSection({super.key});
  @override
  Widget build(BuildContext context) {
    // AudioHandler player = Provider.of<AudioHandler>(context, listen: true);
    final color = Theme.of(context).colorScheme.primary;
    return Material(
      color: Colors.black87,
      child: Padding(
        padding: EdgeInsetsGeometry.directional(
          end: 32,
          start: 32,
          top: 16,
          bottom: 16,
        ),
        child: Consumer<AudioHandler>(
          builder: (context, player, child) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    spacing: 16,
                    children: List.generate(player.palettes, (int index) {
                      final buttonLabel = (index + 1).toString();
                      return ActionButton(
                        label: buttonLabel,
                        onPressed: player.editMode
                            ? () => player.savePalette(index)
                            : () => player.getPalette(index),
                        color: player.editMode
                            ? Colors.orange
                            : player.activePalette == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.primaryFixedDim,
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      spacing: 5,
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
                        SizedBox(
                          width: 600,
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
                        Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              player.playerPositionString,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              player.playerDurationString,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<AudioHandler>(
                    builder: (_, value, _) {
                      final playLabel = 'Play (Space)';
                      final stopLabel = 'Stop (ESC)';
                      final mainAxisSize = MainAxisSize.min;
                      final mainAxisAlignment = MainAxisAlignment.end;
                      final double spacing = 16;
                      switch (value.audioPlayer.state) {
                        case PlayerState.completed:
                          return Row(
                            mainAxisSize: mainAxisSize,
                            mainAxisAlignment: mainAxisAlignment,
                            spacing: spacing,
                            children: [
                              ActionButton(
                                onPressed: () => player.play(),
                                icon: Icons.play_arrow,
                                label: playLabel,
                                color: color,
                              ),
                              ActionButton(
                                onPressed: () => player.stop(),
                                icon: Icons.stop,
                                label: stopLabel,
                                color: Colors.red,
                              ),
                            ],
                          );
                        case PlayerState.disposed:
                          return Row(
                            mainAxisSize: mainAxisSize,
                            mainAxisAlignment: mainAxisAlignment,
                            spacing: spacing,
                            children: [
                              ActionButton(
                                onPressed: () => player.play(),
                                icon: Icons.play_arrow,
                                label: playLabel,
                                color: color,
                              ),
                              ActionButton(
                                onPressed: () => player.stop(),
                                icon: Icons.stop,
                                label: stopLabel,
                                color: Colors.red,
                              ),
                            ],
                          );
                        case PlayerState.playing:
                          return Row(
                            mainAxisSize: mainAxisSize,
                            mainAxisAlignment: mainAxisAlignment,
                            spacing: spacing,
                            children: [
                              ActionButton(
                                onPressed: () => player.play(),
                                icon: Icons.play_arrow,
                                label: playLabel,
                                color: Colors.red,
                              ),
                              ActionButton(
                                onPressed: () => player.stop(),
                                icon: Icons.stop,
                                label: stopLabel,
                                color: color,
                              ),
                            ],
                          );
                        case PlayerState.paused:
                          return Row(
                            mainAxisSize: mainAxisSize,
                            mainAxisAlignment: mainAxisAlignment,
                            spacing: spacing,
                            children: [
                              ActionButton(
                                onPressed: () => player.play(),
                                icon: Icons.play_arrow,
                                label: playLabel,
                                color: color,
                              ),
                              ActionButton(
                                onPressed: () => player.stop(),
                                icon: Icons.stop,
                                label: stopLabel,
                                color: Colors.red,
                              ),
                            ],
                          );
                        case PlayerState.stopped:
                          return Row(
                            mainAxisSize: mainAxisSize,
                            mainAxisAlignment: mainAxisAlignment,
                            spacing: spacing,
                            children: [
                              ActionButton(
                                onPressed: () => player.play(),
                                icon: Icons.play_arrow,
                                label: playLabel,
                                color: player.sourceFileParsed == null
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.primaryFixedDim
                                    : color,
                              ),
                              ActionButton(
                                onPressed: () => player.stop(),
                                icon: Icons.stop,
                                label: stopLabel,
                                color: Colors.red,
                              ),
                            ],
                          );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
