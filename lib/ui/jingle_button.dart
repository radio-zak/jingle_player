import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class JingleButton extends StatelessWidget {
  final void Function() setSource;
  final void Function() play;
  final String title;
  final String? subtitle;
  final Key? sourceKey;
  final filePicker;

  const JingleButton({
    required this.setSource,
    required this.play,
    required this.title,
    this.subtitle,
    this.sourceKey,
    this.filePicker,
  });
  @override
  Widget build(context) {
    return Column(
      children: [
        TextButton(key: sourceKey, onPressed: play, child: Text(title)),
        TextButton(onPressed: filePicker, child: Text('pick file')),
      ],
    );
  }
}
