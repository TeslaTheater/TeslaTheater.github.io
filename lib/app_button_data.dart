import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AppButtonData {
  final int id;
  final Widget icon;
  final Color backgroundColor;
  final String url;
  final bool isNewTab;

  AppButtonData({required this.id, required this.icon, required this.backgroundColor, required this.url, this.isNewTab = false});

  void launchURL() async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: isNewTab ? '_blank' : '_self');
    } else {
      throw 'Could not launch $url';
    }
  }
}