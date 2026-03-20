import 'package:flutter/material.dart';
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
                ? Colors.orangeAccent
                : Colors.tealAccent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 64,
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
                Container(
                  child: Padding(
                    padding: EdgeInsetsGeometry.directional(
                      top: 12,
                      bottom: 12,
                      start: 16,
                      end: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                width: 180,
                                height: 36,
                              ),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                player.titleMap[index]!,
                                style: TextTheme.of(context).titleLarge,
                              ),
                            ),
                          ],
                        ),
                        player.editMode
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  Container(
                                    height: 24,
                                    color: Colors.black87,
                                    child: TextButton(
                                      onPressed: () =>
                                          player.setButtonSource(index),
                                      child: Text(
                                        'Pick file',
                                        style: TextTheme.of(context).bodySmall,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 24,
                                    color: Colors.black87,
                                    child: TextButton(
                                      onPressed: () =>
                                          player.clearButtonSource(index),
                                      child: Text(
                                        'Clear slot',
                                        style: TextTheme.of(context).bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                player.parseDuration(player.durationMap[index]),
                                style: TextTheme.of(context).bodyLarge,
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
