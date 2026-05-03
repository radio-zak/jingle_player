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
        return Container(
          padding: EdgeInsetsGeometry.directional(
            start: 8,
            end: 32,
            top: 8,
            bottom: 8,
          ),
          child: CarouselView.weighted(
            itemSnapping: true,
            flexWeights: [1, 1, 1, 1],
            // itemExtent: 64,
            shrinkExtent: 64,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
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
