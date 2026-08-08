import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final bool backButton;
  final String title;
  final Widget? centerSlot;
  final Widget? rightSlot;
  const TopBar({
    super.key,
    required this.backButton,
    required this.title,
    this.centerSlot,
    this.rightSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Padding(
        padding: EdgeInsetsGeometry.directional(
          end: 32,
          start: 32,
          top: 16,
          bottom: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8,
                children: [
                  backButton
                      ? IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        )
                      : Container(),
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 36),
                  ),
                ],
              ),
            ),
            centerSlot != null ? Expanded(child: centerSlot!) : Container(),
            rightSlot != null ? Expanded(child: rightSlot!) : Container(),
          ],
        ),
      ),
    );
  }
}
