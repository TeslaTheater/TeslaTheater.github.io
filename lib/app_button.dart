import 'package:flutter/material.dart';
import 'package:tesla_theater/app_button_data.dart';

class AppButton extends StatelessWidget {

  final AppButtonData data;
  final double width;
  final double aspectRatio;

  const AppButton({super.key, required this.data, this.width = 250, this.aspectRatio = 4 / 3});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: () {
          data.launchURL();
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: data.backgroundColor,
          foregroundColor: _foregroundColor(data.backgroundColor),
          side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.zero,
        ),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: data.icon,
            ),
          ),
        ),
      ),
    );
  }
}

Color _foregroundColor(Color backgroundColor) {
  final luminance = backgroundColor.computeLuminance();
  return luminance > 0.5 ? Colors.black : Colors.white;
}