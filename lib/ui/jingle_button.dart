import 'package:flutter/material.dart';
import 'package:jingle_player/ui/action_button.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/audio_handler.dart';

class JingleSelector extends StatelessWidget {
  final int index;
  final String keybind;
  final VoidCallback onPressedAction;
  final BuildContext? context;

  const JingleSelector({
    this.context,
    required this.index,
    required this.onPressedAction,
    required this.keybind,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String _name = keybind;
    return Consumer<AudioHandler>(
      builder: (context, player, child) {
        return Material(
          borderRadius: BorderRadiusGeometry.circular(4),
          animateColor: true,
          borderOnForeground: true,
          clipBehavior: Clip.hardEdge,
          color: (player.editMode && player.sourceMap[index] == null)
              ? Theme.of(context).colorScheme.primaryFixedDim
              : player.editMode && player.sourceMap[index] != null
              ? Colors.orange
              : player.paletteLoading
              ? Theme.of(context).colorScheme.primaryFixedDim
              : player.sourceMap[index] == null
              ? Theme.of(context).colorScheme.primaryFixedDim
              : player.sourceMap[index] != player.sourceFile
              ? Theme.of(context).colorScheme.primary
              : Colors.red,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(4),
            ),
            onTap: player.sourceMap[index] == null ? null : onPressedAction,
            hoverColor: player.sourceMap[index] == null
                ? null
                : player.editMode
                ? Colors.orange
                : player.sourceMap[index] != player.sourceFile
                ? Colors.tealAccent
                : Colors.redAccent,
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.black54,
                    child: Padding(
                      padding: EdgeInsetsGeometry.directional(
                        top: 12,
                        bottom: 12,
                        start: 16,
                        end: 16,
                      ),
                      child: Text(
                        _name,
                        textAlign: TextAlign.center,
                        style: TextTheme.of(context).headlineLarge,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsetsGeometry.directional(
                      top: 12,
                      bottom: 12,
                      start: 16,
                      end: 16,
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            player.paletteLoading
                                ? 'Loading...'
                                : player.titleMap[index]!,
                            style: TextTheme.of(context).titleLarge,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: player.editMode
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    ActionButton(
                                      tooltipMessage:
                                          "Select wave file from disk for playout",
                                      hoverColor: Colors.grey,
                                      color: Colors.black87,
                                      onPressed: () async =>
                                          await player.setButtonSource(index),
                                      label: 'Pick file',
                                      isSmall: true,
                                    ),
                                    ActionButton(
                                      tooltipMessage:
                                          "Removes file from slot, rendering this button inactive",
                                      hoverColor: Colors.grey,
                                      color: Colors.black87,
                                      onPressed: () =>
                                          player.clearButtonSource(index),
                                      label: "Clear slot",
                                      isSmall: true,
                                    ),
                                  ],
                                )
                              : player.paletteLoading
                              ? LinearProgressIndicator(minHeight: 8)
                              : Text(
                                  player.parseDuration(
                                    player.durationMap[index],
                                  ),
                                  style: TextTheme.of(context).bodyLarge,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
