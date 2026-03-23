import 'package:flutter/material.dart';
import 'package:jingle_player/ui/action_button.dart';
import 'package:jingle_player/ui/jingle_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:jingle_player/audio_handler.dart';
import 'package:jingle_player/ui/player_section.dart';

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
      audioHandler.loadToPlayer(audioHandler.sourceMap[index]!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _audioPlayer = Provider.of<AudioHandler>(context, listen: true);
    return Shortcuts(
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.space): PlayerStartIntent(),
        SingleActivator(LogicalKeyboardKey.escape): PlayerStopIntent(),
        for (MapEntry<int, LogicalKeyboardKey> k in _audioPlayer.keyMap.entries)
          SingleActivator(k.value): ButtonPressHandler(index: k.key),
      },
      child: Actions(
        actions: {
          ButtonPressHandler: ButtonPressAction(audioHandler: _audioPlayer),
          PlayerStartIntent: PlayerStartAction(audioHandler: _audioPlayer),
          PlayerStopIntent: PlayerStopAction(audioHandler: _audioPlayer),
        },
        child: Focus(
          autofocus: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 16,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
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

                      Consumer<AudioHandler>(
                        builder: (context, editmode, child) {
                          return Container(
                            constraints: BoxConstraints.loose(
                              Size.fromWidth(300),
                            ),
                            child: ActionButton(
                              onPressed: () =>
                                  editmode.switchMode(editmode.activePalette),
                              icon: Icons.edit,
                              label: editmode.editMode
                                  ? 'Exit edit mode'
                                  : 'Enter edit mode',
                              color: editmode.editMode
                                  ? Colors.orange
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              PlayerSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonPressHandler extends Intent {
  final int index;
  const ButtonPressHandler({required this.index});
}

class ButtonPressAction extends Action<ButtonPressHandler> {
  AudioHandler audioHandler;

  ButtonPressAction({required this.audioHandler});

  @override
  Future<void> invoke(ButtonPressHandler intent) async {
    if (audioHandler.sourceMap[intent.index] == null) {
      debugPrint('$intent.index');
      debugPrint('tried to activate empty source');
    } else if (audioHandler.editMode) {
      debugPrint('button in edit mode - not playing');
    } else {
      audioHandler.loadToPlayer(audioHandler.sourceMap[intent.index]!);
    }
  }
}

class PlayerStartIntent extends Intent {}

class PlayerStopIntent extends Intent {}

class PlayerStartAction extends Action<PlayerStartIntent> {
  AudioHandler audioHandler;
  PlayerStartAction({required this.audioHandler});

  @override
  Future<void> invoke(PlayerStartIntent intent) async {
    audioHandler.play();
  }
}

class PlayerStopAction extends Action<PlayerStopIntent> {
  AudioHandler audioHandler;
  PlayerStopAction({required this.audioHandler});

  @override
  Future<void> invoke(PlayerStopIntent intent) async {
    audioHandler.stop();
  }
}
