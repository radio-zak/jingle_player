import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/ui/action_button.dart';
import 'package:jingle_player/audio_handler.dart';

class PaletteSelector extends StatelessWidget {
  PaletteSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioHandler>(
      builder: (context, player, child) {
        return Padding(
          padding: EdgeInsetsGeometry.directional(
            start: 8,
            end: 32,
            top: 8,
            bottom: 8,
          ),
          child: GridView.extent(
            maxCrossAxisExtent: 64,
            mainAxisSpacing: 8,
            crossAxisSpacing: 4,
            shrinkWrap: true,
            childAspectRatio: 1.5,
            scrollDirection: Axis.horizontal,
            children: List.generate(player.palettes, (int index) {
              final buttonLabel = (index + 1).toString();
              return ActionButton(
                label: buttonLabel,
                hoverColor: player.editMode
                    ? Colors.orangeAccent
                    : Colors.tealAccent,
                onPressed: player.editMode
                    ? () async {
                        await player.savePalette(index);
                      }
                    : () async {
                        await player.getPalette(index);
                      },
                color: player.editMode
                    ? Colors.orange
                    : player.activePalette == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primaryFixedDim,
              );
            }),
          ),
        );
      },
    );
  }
}
