import 'package:flutter/material.dart';
import 'package:jingle_player/config.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/ui/action_button.dart';
import 'package:jingle_player/audio_handler.dart';

class PaletteSelector extends StatelessWidget {
  const PaletteSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ApplicationConfig>(context, listen: true);
    return Flexible(
      fit: FlexFit.tight,
      child: Consumer<AudioHandler>(
        builder: (context, player, child) {
          final carouselController = CarouselController(
            initialItem: (player.activePalette < 4) ? 0 : 4,
          );
          return Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            spacing: 2,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_sharp),
                onPressed: () {
                  carouselController.animateToItem(0);
                },
              ),
              Expanded(
                child: CarouselView.weighted(
                  padding: EdgeInsets.all(8),
                  key: UniqueKey(),
                  itemSnapping: true,
                  flexWeights: [1, 1, 1, 1],
                  shrinkExtent: 64,
                  controller: carouselController,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  enableSplash: false, // makes children clickable
                  scrollDirection: Axis.horizontal,
                  children: List.generate(config.palettes, (int index) {
                    final buttonLabel = (index + 1).toString();
                    return ActionButton(
                      tooltipMessage: player.editMode
                          ? 'Save to palette $buttonLabel'
                          : 'Switch to palette $buttonLabel',
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
                      color: player.editMode && player.activePalette == index
                          ? Colors.orange
                          : player.activePalette == index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primaryFixedDim,
                    );
                  }),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_sharp),
                onPressed: () {
                  carouselController.animateToItem(4);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
