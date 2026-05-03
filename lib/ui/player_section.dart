import "package:flutter/material.dart";
import "package:audioplayers/audioplayers.dart";
import "package:jingle_player/audio_handler.dart";
import "package:provider/provider.dart";
import 'package:jingle_player/ui/action_button.dart';
import 'package:jingle_player/ui/palette_selector.dart';
import 'package:jingle_player/ui/status_bar.dart';

class PlayerSection extends StatelessWidget {
  const PlayerSection({super.key});
  @override
  Widget build(BuildContext context) {
    // AudioHandler player = Provider.of<AudioHandler>(context, listen: true);
    final color = Theme.of(context).colorScheme.primary;
    return Material(
      color: Colors.black87,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 16,
                      children: [
                        IconButton(
                          onPressed: () => player.activateToolbar(),
                          icon: Icon(Icons.menu),
                        ),
                        Flexible(child: PaletteSelector()),
                      ],
                    ),
                  ),
                  Expanded(child: StatusBar()),
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
      ),
    );
    //   ],
    // );
  }
}
