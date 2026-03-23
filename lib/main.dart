import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:jingle_player/ui/jingle_grid.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/audio_handler.dart';
import 'package:jingle_player/ui/top_bar.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

late String appTitle;
late int playerCount;
late int paletteCount;
late Map<String, dynamic> configMap;
String configPath = 'config.json';

void main() async {
  AudioLogger.logLevel = AudioLogLevel.info;
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(1200, 900),
    skipTaskbar: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  await loadConfig(configPath);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AudioHandler>(
          create: (context) => AudioHandler(),
        ),
      ],
      child: const JinglePlayer(),
    ),
  );
}

Future<void> loadConfig(String configPath) async {
  if (kDebugMode) {
    debugPrint('Using default configuration from asset directory');
    loadDefaultConfig();
  } else {
    var configFile = await File(configPath).exists();
    if (!configFile) {
      await initializeConfigFile(configPath);
    }
    debugPrint('Loading configuration file');
    try {
      await loadConfigFromFile(configPath);
    } catch (e) {
      debugPrint('$e');
      await loadDefaultConfig();
    }
  }
}

Future<void> loadConfigFromFile(String configPath) async {
  var appConfig = await File(configPath).readAsString();
  Map<String, dynamic> configMap = await jsonDecode(appConfig);
  paletteCount = configMap['paletteCount'];
  appTitle = configMap['appTitle'];
  playerCount = configMap['playerCount'];
}

Future<void> loadDefaultConfig() async {
  await GlobalConfiguration().loadFromAsset("default_config");
  appTitle = GlobalConfiguration().getValue("appTitle");
  playerCount = GlobalConfiguration().getValue("playerCount");
  paletteCount = GlobalConfiguration().getValue("paletteCount");
}

Future<void> initializeConfigFile(String configPath) async {
  debugPrint('Creating default configuration file');
  ByteData configAssetData = await rootBundle.load(
    'assets/cfg/default_config.json',
  );
  List<int> bytes = configAssetData.buffer.asUint8List();
  await File(configPath).create();
  await File(configPath).writeAsBytes(bytes);
  debugPrint('Config file created in $configPath');
}

class JinglePlayer extends StatelessWidget {
  const JinglePlayer({super.key});
  @override
  Widget build(BuildContext context) {
    final surfaceColor = Color.fromARGB(255, 34, 34, 34);
    final primaryColor = Colors.teal;
    final primaryDimmedColor = Color.fromARGB(255, 54, 54, 54);
    final textPrimaryColor = Colors.white;
    final textGreyedColor = Color(0xFFBBBBBB);
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        appBarTheme: AppBarThemeData(
          actionsIconTheme: IconThemeData(color: textPrimaryColor),
          iconTheme: IconThemeData(color: textPrimaryColor),
          backgroundColor: surfaceColor,
          foregroundColor: surfaceColor,
        ),
        tabBarTheme: TabBarThemeData(
          indicatorColor: primaryColor,
          labelStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.normal,
          ),
          labelColor: primaryColor,
          unselectedLabelStyle: TextStyle(
            color: textGreyedColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        colorScheme: ColorScheme(
          surface: surfaceColor,
          onSurface: textPrimaryColor,
          primary: primaryColor,
          onPrimary: textPrimaryColor,
          secondary: textGreyedColor,
          onSecondary: textPrimaryColor,
          primaryFixedDim: primaryDimmedColor,
          tertiary: textGreyedColor,
          brightness: Brightness.dark,
          onError: Colors.red,
          error: Colors.red,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.sora(),
          displayMedium: GoogleFonts.sora(),
          titleLarge: GoogleFonts.sora(fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.sora(fontWeight: FontWeight.bold),
          titleSmall: GoogleFonts.sora(fontWeight: FontWeight.bold),
          displaySmall: GoogleFonts.sora(),
          labelLarge: GoogleFonts.sora(
            fontWeight: FontWeight.bold,
            color: textGreyedColor,
          ),
          labelMedium: GoogleFonts.sora(
            fontWeight: FontWeight.bold,
            color: textGreyedColor,
          ),
          labelSmall: GoogleFonts.sora(
            fontWeight: FontWeight.bold,
            color: textGreyedColor,
          ),
          headlineLarge: GoogleFonts.sora(),
          headlineMedium: GoogleFonts.sora(),
          headlineSmall: GoogleFonts.sora(fontSize: 16),
          bodyLarge: GoogleFonts.sora(),
          bodyMedium: GoogleFonts.sora(),
          bodySmall: GoogleFonts.sora(),
        ),
      ),
      home: HomePage(title: appTitle),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  late AudioHandler audioPlayer;

  @override
  void initState() {
    initializePlayers();
    setState(() {
      super.initState();
      windowManager.addListener(this);
    });
  }

  Future<void> initializePlayers() async {
    audioPlayer = Provider.of<AudioHandler>(context, listen: false);
    await audioPlayer.initialize(playerCount, paletteCount);
    await audioPlayer.getPalette(audioPlayer.activePalette);
  }

  @override
  void onWindowFocus() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopBar(title: widget.title),
          Expanded(
            child: Center(child: JingleGrid(playerCount: playerCount)),
          ),
        ],
      ),
    );
  }
}
