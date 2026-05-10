import 'package:flutter/material.dart';
import 'package:jingle_player/ui/jingle_button.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/audio_handler.dart';

class JingleGrid extends StatelessWidget {
  final int playerCount;
  const JingleGrid({required this.playerCount, super.key});

  Future<void> handleButtonClick(BuildContext context, int index) async {
    final audioHandler = Provider.of<AudioHandler>(context, listen: false);
    if (audioHandler.paletteLoading) {
      return;
    }
    if (audioHandler.sourceMap[index] == null) {
      debugPrint('$index');
      debugPrint('tried to activate empty source');
    } else if (audioHandler.editMode) {
      debugPrint('button in edit mode - not playing');
    } else {
      await audioHandler.stop();
      await audioHandler.loadToPlayer(audioHandler.sourceMap[index]!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _audioPlayer = Provider.of<AudioHandler>(context, listen: true);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(32),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.extent(
                  key: PageStorageKey('scroll_value'),
                  padding: EdgeInsetsGeometry.all(8),
                  scrollDirection: Axis.vertical,
                  maxCrossAxisExtent: 344,
                  physics: const BouncingScrollPhysics(),
                  controller: ScrollController(),
                  shrinkWrap: true,
                  // crossAxisCount: 4,
                  mainAxisSpacing: 32.0,
                  crossAxisSpacing: 32.0,
                  childAspectRatio: 384 / 122,
                  children: List.generate(playerCount, (index) {
                    return Container(
                      // width: 384,
                      // height: 122,
                      child: JingleSelector(
                        context: context,
                        index: index,
                        onPressedAction: () async =>
                            handleButtonClick(context, index),
                        keybind: _audioPlayer.keyMap[index]!.keyLabel,
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
