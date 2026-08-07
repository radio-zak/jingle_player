import 'package:flutter/material.dart';

class AudioFileSelector extends StatelessWidget {
  String fileName;
  double duration;
  Color? color;
  VoidCallback? onPressed;

  AudioFileSelector({
    required this.fileName,
    required this.duration,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        borderRadius: BorderRadiusGeometry.circular(4),
        animateColor: true,
        borderOnForeground: true,
        clipBehavior: Clip.hardEdge,
        color: color,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(4),
          ),
          onTap: onPressed,
          hoverColor: Colors.grey,
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: 12,
                    bottom: 12,
                    start: 16,
                    end: 16,
                  ),
                  child: Text(
                    fileName,
                    style: TextTheme.of(context).titleLarge,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsetsGeometry.directional(
                    top: 12,
                    bottom: 12,
                    start: 16,
                    end: 16,
                  ),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    "0.00.000",
                    style: TextTheme.of(context).headlineMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
