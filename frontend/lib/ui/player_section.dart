import "package:flutter/material.dart";
import "package:audioplayers/audioplayers.dart";
import "../audio_handler.dart";
import "package:provider/provider.dart";
import 'action_button.dart';
import 'palette_selector.dart';
import 'status_bar.dart';

class PlayerSection extends StatelessWidget {
  const PlayerSection({super.key});
  @override
  Widget build(BuildContext context) {
    // AudioHandler player = Provider.of<AudioHandler>(context, listen: true);
    final color = Theme.of(context).colorScheme.primary;
    return Material(
      color: Colors.black87,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Padding(
          padding: EdgeInsetsGeometry.directional(
            end: 32,
            start: 32,
            top: 16,
            bottom: 16,
          ),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<AudioHandler>(
                      builder: (context, player, child) {
                        return Tooltip(
                          waitDuration: Duration(seconds: 1),
                          message: player.toolbarActive
                              ? "Show options toolbar"
                              : "Close options toolbar",
                          child: IconButton(
                            onPressed: () => player.toggleToolbar(),
                            icon: player.toolbarActive
                                ? Icon(Icons.close)
                                : Icon(Icons.menu),
                          ),
                        );
                      },
                    ),
                    PaletteSelector(),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Center(child: StatusBar()),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(8),
                  child: Consumer<AudioProvider>(
                    builder: (context, player, child) {
                      final playLabel = 'Play (Space)';
                      final stopLabel = 'Stop (ESC)';
                      final mainAxisSize = MainAxisSize.min;
                      final mainAxisAlignment = MainAxisAlignment.end;
                      final playTooltipMessage = "Play audio";
                      final stopTooltipMessage = "Stop playing audio";
                      final double spacing = 16;
                      return Row(
                        mainAxisSize: mainAxisSize,
                        mainAxisAlignment: mainAxisAlignment,
                        spacing: spacing,
                        children: [
                          ActionButton(
                            onPressed: () => player.play(),
                            icon: Icons.play_arrow,
                            label: playLabel,
                            color: player.playbackStatus == "PLAYING"
                                ? Colors.red
                                : color,
                            tooltipMessage: playTooltipMessage,
                          ),
                          ActionButton(
                            onPressed: () => player.stop(),
                            icon: Icons.stop,
                            label: stopLabel,
                            color: player.playbackStatus == "PLAYING"
                                ? color
                                : Colors.red,
                            hoverColor: Colors.redAccent,
                            tooltipMessage: stopTooltipMessage,
                          ),
                        ],
                      );
                      // switch (player.audioStatus) {
                      //   case "PLAYING":
                      //     return Row(
                      //       mainAxisSize: mainAxisSize,
                      //       mainAxisAlignment: mainAxisAlignment,
                      //       spacing: spacing,
                      //       children: [
                      //         ActionButton(
                      //           onPressed: () => player.play(),
                      //           icon: Icons.play_arrow,
                      //           label: playLabel,
                      //           color: color,
                      //           tooltipMessage: playTooltipMessage,
                      //         ),
                      //         ActionButton(
                      //           onPressed: () => player.stop(),
                      //           icon: Icons.stop,
                      //           label: stopLabel,
                      //           color: Colors.red,
                      //           hoverColor: Colors.redAccent,
                      //           tooltipMessage: stopTooltipMessage,
                      //         ),
                      //       ],
                      //     );
                      //   case PlayerState.completed:
                      //     return Row(
                      //       mainAxisSize: mainAxisSize,
                      //       mainAxisAlignment: mainAxisAlignment,
                      //       spacing: spacing,
                      //       children: [
                      //         ActionButton(
                      //           onPressed: () => player.play(),
                      //           icon: Icons.play_arrow,
                      //           label: playLabel,
                      //           color: color,
                      //           tooltipMessage: playTooltipMessage,
                      //         ),
                      //         ActionButton(
                      //           onPressed: () => player.stop(),
                      //           icon: Icons.stop,
                      //           label: stopLabel,
                      //           color: Colors.red,
                      //           hoverColor: Colors.redAccent,
                      //           tooltipMessage: stopTooltipMessage,
                      //         ),
                      //       ],
                      //     );
                      //   case PlayerState.disposed:
                      //     return Row(
                      //       mainAxisSize: mainAxisSize,
                      //       mainAxisAlignment: mainAxisAlignment,
                      //       spacing: spacing,
                      //       children: [
                      //         ActionButton(
                      //           onPressed: () => player.play(),
                      //           icon: Icons.play_arrow,
                      //           label: playLabel,
                      //           color: color,
                      //           tooltipMessage: playTooltipMessage,
                      //         ),
                      //         ActionButton(
                      //           onPressed: () => player.stop(),
                      //           icon: Icons.stop,
                      //           label: stopLabel,
                      //           color: Colors.red,
                      //           hoverColor: Colors.redAccent,
                      //           tooltipMessage: stopTooltipMessage,
                      //         ),
                      //       ],
                      //     );
                      //   case PlayerState.playing:
                      //     return Row(
                      //       mainAxisSize: mainAxisSize,
                      //       mainAxisAlignment: mainAxisAlignment,
                      //       spacing: spacing,
                      //       children: [
                      //         ActionButton(
                      //           onPressed: () => player.play(),
                      //           icon: Icons.play_arrow,
                      //           label: playLabel,
                      //           color: Colors.red,
                      //           hoverColor: Colors.redAccent,

                      //           tooltipMessage: playTooltipMessage,
                      //         ),
                      //         ActionButton(
                      //           onPressed: () => player.stop(),
                      //           icon: Icons.stop,
                      //           label: stopLabel,
                      //           color: color,
                      //           tooltipMessage: stopTooltipMessage,
                      //         ),
                      //       ],
                      //     );
                      //   case PlayerState.paused:
                      //     return Row(
                      //       mainAxisSize: mainAxisSize,
                      //       mainAxisAlignment: mainAxisAlignment,
                      //       spacing: spacing,
                      //       children: [
                      //         ActionButton(
                      //           onPressed: () => player.play(),
                      //           icon: Icons.play_arrow,
                      //           label: playLabel,
                      //           color: color,
                      //           tooltipMessage: playTooltipMessage,
                      //         ),
                      //         ActionButton(
                      //           onPressed: () => player.stop(),
                      //           icon: Icons.stop,
                      //           label: stopLabel,
                      //           color: Colors.red,
                      //           hoverColor: Colors.redAccent,
                      //           tooltipMessage: stopTooltipMessage,
                      //         ),
                      //       ],
                      //     );
                      //   case PlayerState.stopped:
                      //     return Row(
                      //       mainAxisSize: mainAxisSize,
                      //       mainAxisAlignment: mainAxisAlignment,
                      //       spacing: spacing,
                      //       children: [
                      //         ActionButton(
                      //           onPressed: () => player.play(),
                      //           icon: Icons.play_arrow,
                      //           label: playLabel,
                      //           color: player.sourceFileParsed == null
                      //               ? Theme.of(
                      //                   context,
                      //                 ).colorScheme.primaryFixedDim
                      //               : color,
                      //           tooltipMessage: playTooltipMessage,
                      //         ),
                      //         ActionButton(
                      //           onPressed: () => player.stop(),
                      //           icon: Icons.stop,
                      //           label: stopLabel,
                      //           color: Colors.red,
                      //           hoverColor: Colors.redAccent,
                      //           tooltipMessage: stopTooltipMessage,
                      //         ),
                      //       ],
                      //     );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
