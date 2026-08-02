import "package:flutter/material.dart";
import "package:jingle_player/grpc.dart";
import "package:jingle_player/control/control.pb.dart";
import "package:jingle_player/audio_handler.dart";

class AudioFileManagerPage extends StatefulWidget {
  AudioProvider audioProvider;
  AudioFileManagerPage({super.key, required this.audioProvider});

  @override
  State<AudioFileManagerPage> createState() => AudioFileManagerPageState();
}

class AudioFileManagerPageState extends State<AudioFileManagerPage> {
  Future<AudioFileList>? list;
  @override
  void initState() {
    super.initState();
    fetchAudioList();
    print("Getting files");
  }

  void fetchAudioList() {
    setState(() {
      list = widget.audioProvider.client.listAudioFiles();
    });
  }

  Future<void> _handleUploadAndRefresh() async {
    try {
      await widget.audioProvider.addAudioFile(); // your upload function
      if (!mounted) return;
      fetchAudioList();
    } catch (e) {
      if (!mounted) return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: list,
            builder: (context, future) {
              if (!future.hasData) {
                return CircularProgressIndicator();
              } else {
                final AudioFileList? list = future.data;
                if (list!.audioFiles.length != 0) {
                  return ListView.builder(
                    itemCount: list!.audioFiles.length,
                    itemBuilder: (context, index) {
                      return Text("Have: ${list.audioFiles[index].fileName}");
                    },
                  );
                } else {
                  return Text("No files available");
                }
              }
            },
          ),
        ),
        bottomNavigationBar: Row(
          children: [
            TextButton(
              onPressed: () {
                _handleUploadAndRefresh();
              },
              child: Text("Add file"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
