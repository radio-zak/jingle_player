import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/ui/action_button.dart';
import 'package:jingle_player/audio_handler.dart';

class PaletteSelector extends StatelessWidget {
  const PaletteSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Consumer<AudioHandler>(
        builder: (context, player, child) {
          return CarouselView.weighted(
            padding: EdgeInsets.all(8),
            key: UniqueKey(),
            itemSnapping: true,
            flexWeights: [1, 1, 1, 1],
            shrinkExtent: 64,
            controller: CarouselController(initialItem: 1),
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
          );
        },
      ),
    );
  }
}
