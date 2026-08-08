import "package:flutter/material.dart";
import "package:djinn/audio_handler.dart";
import "package:djinn/ui/action_button.dart";
import "package:djinn/ui/audio_file_list_view.dart";
import "package:djinn/ui/top_bar.dart";
import "package:provider/provider.dart";

class AudioFileManagerPage extends StatelessWidget {
  AudioFileManagerPage({super.key});
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context, listen: true);
    final color = Theme.of(context).colorScheme.primary;
    return Focus(
      autofocus: true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 120),
          child: TopBar(
            title: "Audio management",
            backButton: true,
            rightSlot: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                ActionButton(
                  label: "Add file",
                  icon: Icons.add,
                  color: Theme.of(context).colorScheme.primaryFixedDim,
                  hoverColor: color,
                  onPressed: () {
                    audioProvider.addAudioFile();
                  },
                  tooltipMessage: "Add file",
                ),
                ActionButton(
                  label: "Delete file",
                  icon: Icons.delete,
                  color: Theme.of(context).colorScheme.primaryFixedDim,
                  hoverColor: Colors.redAccent,
                  onPressed: () {
                    if (audioProvider.selectedFile != null) {
                      audioProvider.deleteAudioFile(
                        audioProvider.selectedFile!,
                      );
                    }
                  },
                  tooltipMessage: "Delete file",
                ),
              ],
            ),
          ),
        ),
        body: Center(child: AudioFileListView(management: true)),
      ),
    );
  }
}
