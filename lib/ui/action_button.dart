import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? hoverColor;
  final double? width;
  final double? height;
  final String? tooltipMessage;
  const ActionButton({
    this.icon,
    required this.label,
    this.onPressed,
    this.hoverColor,
    this.color,
    this.width,
    this.height,
    this.tooltipMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      waitDuration: const Duration(seconds: 1),
      padding: EdgeInsetsGeometry.all(4),
      message: tooltipMessage,
      child: Material(
        color: color,
        borderRadius: BorderRadiusGeometry.circular(4),
        child: InkWell(
          onTap: onPressed,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(4),
          ),
          hoverColor: hoverColor,
          child: Container(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsetsGeometry.all(8),
              child: Row(
                mainAxisAlignment: icon != null
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                spacing: icon != null ? 8 : 0,
                children: [
                  icon != null ? Icon(icon) : Container(),
                  Text(label, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
