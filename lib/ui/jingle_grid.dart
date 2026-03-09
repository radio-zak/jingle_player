import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class JingleGrid extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const JingleGrid({required this.audioPlayer, super.key});
  @override
  State<JingleGrid> createState() => _JingleGridState();
}

class _JingleGridState extends State<JingleGrid> {
  AudioPlayer get audioPlayer => widget.audioPlayer;
  Source source = DeviceFileSource('');
  String title = '';

  Future<void> _setSource(Source source) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        source = DeviceFileSource(result.paths.first!);
        title = result.names.first!;
      });
    }
  }

  Future<void> _loadFileToPlayer(Source source) async {
    await audioPlayer.setSource(source);
  }

  Future<void> _play() async {
    await audioPlayer.stop();
    await audioPlayer.resume();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => _loadFileToPlayer(source),
          child: Text(title),
        ),
        TextButton(
          onPressed: () => _setSource(source),
          child: Text('Pick file'),
        ),
      ],
    );
  }
}
