import "package:flutter/material.dart";
import "package:djinn/audio_handler.dart";
import "package:provider/provider.dart";
import "package:djinn/ui/audio_file_selector.dart";

class AudioFileListView extends StatelessWidget {
  bool management;
  AudioFileListView({super.key, required this.management});
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, value, child) {
        if (value.audioFileList == null) {
          return CircularProgressIndicator();
        }
        if (value.audioFileList!.audioFiles.length == 0) {
          return Text("No files found");
        } else {
          return GridView.builder(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 12 / 1,
            ),
            itemCount: value.audioFileList!.audioFiles.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: AudioFileSelector(
                  fileName: value.audioFileList!.audioFiles[index].fileName,
                  duration: value.audioFileList!.audioFiles[index].duration,
                  color:
                      value.selectedFile ==
                          value.audioFileList!.audioFiles[index].id
                      ? Colors.teal
                      : Theme.of(context).colorScheme.primaryFixedDim,
                  onPressed: () {
                    if (management) {
                      value.selectFile(
                        value.audioFileList!.audioFiles[index].id,
                      );
                    } else {
                      value.assignFileToSlot(
                        value.editedSlotID!,
                        value.audioFileList!.audioFiles[index].id,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
