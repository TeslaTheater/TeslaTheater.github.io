import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reorderables/reorderables.dart';
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

class TeslaTheater extends StatefulWidget {
  const TeslaTheater({super.key});

  @override
  _TeslaTheaterState createState() => _TeslaTheaterState();
}

class _TeslaTheaterState extends State<TeslaTheater> {
  List<AppButtonData> appButtons = [];

  @override
  void initState() {
    super.initState();
    _loadButtons();
  }

  void _loadButtons() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedOrder = prefs.getStringList('appOrder');
    List<AppButtonData> defaultAppButtons = [
      AppButtonData(id: 0, icon: Assets.icons.netflix.svg(), backgroundColor: Colors.white, url: 'https://www.netflix.com'),
      AppButtonData(id: 1, icon: Assets.icons.disneyplus.svg(), backgroundColor: const Color(0xFF101C50), url: 'https://www.disneyplus.com/'),
      AppButtonData(id: 2, icon: Assets.icons.primevideo.svg(), backgroundColor: const Color(0xFF1A98FF), url: 'https://www.primevideo.com/'),
      AppButtonData(id: 3, icon: Assets.icons.appletvplus.svg(), backgroundColor: Colors.black, url: 'https://tv.apple.com/'),
      AppButtonData(id: 4, icon: Assets.icons.mycanal.svg(), backgroundColor: Colors.black, url: 'https://www.mycanal.fr/'),
      AppButtonData(id: 5, icon: Assets.icons.youtube.svg(), backgroundColor: Colors.white, url: 'https://www.youtube.com/'),
      AppButtonData(id: 6, icon: Assets.icons.max.svg(), backgroundColor: const Color(0xFF002BE7), url: 'https://www.max.com/'),
      AppButtonData(id: 7, icon: Assets.icons.paramoutplus.svg(), backgroundColor: const Color(0xFF0164FF), url: 'https://www.paramountplus.com/'),
      AppButtonData(id: 8, icon: Assets.icons.artetv.svg(), backgroundColor: Colors.white, url: 'https://www.arte.tv/'),
      AppButtonData(id: 9, icon: Assets.icons.francetv.svg(), backgroundColor: const Color(0xFF172128), url: 'https://www.france.tv/'),
      AppButtonData(id: 10, icon: Assets.icons.sfrplay.svg(), backgroundColor: Colors.white, url: 'https://tv.sfr.fr/'),
      AppButtonData(id: 11, icon: Assets.icons.orangetv.svg(), backgroundColor: const Color(0xFFFF6600), url: 'https://chaines-tv.orange.fr/'),
      AppButtonData(id: 12, icon: Assets.icons.oqee.svg(), backgroundColor: const Color(0xFF161616), url: 'https://oqee.tv/'),
    ];

    if (storedOrder != null) {
      List<AppButtonData> orderedButtons = storedOrder
          .map((id) => defaultAppButtons.firstWhere((button) => button.id == int.parse(id)))
          .toList();

      for (var button in defaultAppButtons) {
        if (!orderedButtons.any((b) => b.id == button.id)) {
          orderedButtons.add(button);
        }
      }

      appButtons = orderedButtons;
    } else {
      appButtons = defaultAppButtons;
    }

    setState(() {});
  }

  Future<void> _saveButtonsOrder() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> appOrder = appButtons.map((button) => button.id.toString()).toList();
    await prefs.setStringList('appOrder', appOrder);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final AppButtonData item = appButtons.removeAt(oldIndex);
      appButtons.insert(newIndex, item);
    });
    _saveButtonsOrder();
  }

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
            child: Center(
              child: ReorderableWrap(
                padding: const EdgeInsets.all(24.0),
                onReorder: _onReorder,
                spacing: 24.0,
                runSpacing: 24.0,
                children: appButtons
                    .asMap()
                    .map((index, buttonData) => MapEntry(index, _buildAppButton(buttonData, index)))
                    .values
                    .toList(),
              ),
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

  Widget _buildAppButton(AppButtonData data, int index) {
    return SizedBox(
      width: 250,
      key: ValueKey(index),
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
          aspectRatio: 4 / 3,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
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
