import "package:flutter/material.dart";
import "package:djinn/ui/top_bar.dart";
import "package:djinn/ui/audio_file_list_view.dart";

class AudioFileSelectorPage extends StatelessWidget {
  AudioFileSelectorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 120),
          child: TopBar(title: "Select file", backButton: true),
        ),
        body: Center(child: AudioFileListView(management: false)),
      ),
    );
  }
}
