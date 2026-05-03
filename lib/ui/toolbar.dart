import 'package:jingle_player/audio_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/ui/action_button.dart';

class Toolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadiusGeometry.directional(
        topEnd: Radius.circular(8),
      ),
      color: Colors.black87,
      child: Padding(
        padding: EdgeInsetsGeometry.directional(
          end: 32,
          start: 32,
          top: 16,
          bottom: 16,
        ),
        child: Consumer<AudioHandler>(
          builder: (context, player, child) {
            return Container(
              constraints: BoxConstraints.loose(Size.fromWidth(200)),
              child: ActionButton(
                hoverColor: player.editMode
                    ? Colors.orangeAccent
                    : Colors.tealAccent,
                onPressed: () => player.switchMode(player.activePalette),
                icon: Icons.edit,
                label: player.editMode ? 'Exit edit mode' : 'Enter edit mode',
                color: player.editMode
                    ? Colors.orange
                    : Theme.of(context).colorScheme.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
