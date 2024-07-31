import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'gen/assets.gen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tesla Theater',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF35383A),
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
        ),
      ),
      home: const TeslaTheater(),
    );
  }
}

class TeslaTheater extends StatelessWidget {
  const TeslaTheater({super.key});

  void _launchFullScreen() async {
    final currentUrl = Uri.base.toString();
    final redirectUri = Uri.parse('https://www.youtube.com/redirect?q=$currentUrl');
    if (await canLaunchUrl(redirectUri)) {
      await launchUrl(redirectUri, webOnlyWindowName: '_self');
    } else {
      throw 'Could not launch $redirectUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appButtons = [
      AppButtonData(icon: Assets.icons.netflix.svg(), backgroundColor: Colors.white, url: 'https://www.netflix.com'),
      AppButtonData(icon: Assets.icons.appletvplus.svg(), backgroundColor: Colors.black, url: 'https://tv.apple.com/'),
      AppButtonData(icon: Assets.icons.artetv.svg(), backgroundColor: Colors.white, url: 'https://www.arte.tv/'),
      AppButtonData(icon: Assets.icons.disneyplus.svg(), backgroundColor: const Color(0xFF101C50), url: 'https://www.disneyplus.com/'),
      AppButtonData(icon: Assets.icons.francetv.svg(), backgroundColor: const Color(0XFF172128), url: 'https://www.france.tv/'),
      AppButtonData(icon: Assets.icons.mycanal.svg(), backgroundColor: Colors.black, url: 'https://www.mycanal.fr/'),
      AppButtonData(icon: Assets.icons.orangetv.svg(), backgroundColor: const Color(0XFFFF6600), url: 'https://chaines-tv.orange.fr/'),
      AppButtonData(icon: Assets.icons.primevideo.svg(), backgroundColor: const Color(0xFF1A98FF), url: 'https://www.primevideo.com/'),
      AppButtonData(icon: Assets.icons.sfrplay.svg(), backgroundColor: Colors.white, url: 'https://tv.sfr.fr/'),
      AppButtonData(icon: Assets.icons.youtube.svg(), backgroundColor: Colors.white, url: 'https://www.youtube.com/'),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Assets.icons.tesla.svg(height: 30, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
          const SizedBox(height: 20),
          Text(
            'THEATER',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: appButtons.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                return _buildAppButton(appButtons[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchFullScreen();
        },
        label: const Text('FULL SCREEN'),
        icon: const Icon(Icons.fullscreen),
        backgroundColor: const Color(0xFF3E6AE1),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Color _foregroundColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Widget _buildAppButton(AppButtonData data) {
    return OutlinedButton(
      onPressed: () { data.launchURL(); },
      style: OutlinedButton.styleFrom(
        backgroundColor: data.backgroundColor,
        foregroundColor: _foregroundColor(data.backgroundColor),
        side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.zero,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 150, // Ajuster la hauteur des boutons
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FittedBox(
            fit: BoxFit.contain,
            child: data.icon,
          ),
        ),
      ),
    );
  }
}

class AppButtonData {
  final Widget icon;
  final Color backgroundColor;
  final String url;
  final bool isNewTab;

  AppButtonData({required this.icon, required this.backgroundColor, required this.url, this.isNewTab = false});

  void launchURL() async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: isNewTab ? '_blank' : '_self');
    } else {
      throw 'Could not launch $url';
    }
  }
}
