import "package:flutter/material.dart";
import "package:jingle_player/audio_handler.dart";
import "package:jingle_player/ui/action_button.dart";
import "package:jingle_player/ui/audio_file_list_view.dart";
import "package:jingle_player/ui/top_bar.dart";
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
                  color: color,
                  hoverColor: Colors.tealAccent,
                  onPressed: () {
                    audioProvider.addAudioFile();
                  },
                  tooltipMessage: "Add file",
                ),
                ActionButton(
                  label: "Delete file",
                  icon: Icons.delete,
                  color: Colors.red,
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

// class BottomSection extends StatelessWidget {
//   BottomSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black87,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: 100,
//         child: Padding(
//           padding: EdgeInsetsGeometry.directional(
//             end: 32,
//             start: 32,
//             top: 16,
//             bottom: 16,
//           ),
//           child: Flex(
//             direction: Axis.horizontal,
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 flex: 2,
//                 child: Row(
//                   spacing: 16,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(Icons.arrow_back),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
