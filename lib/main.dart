import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jingle_player/ui/jingle_grid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/audio_handler.dart';
import 'package:jingle_player/ui/top_bar.dart';
import 'package:window_manager/window_manager.dart';
import 'package:jingle_player/ui/player_section.dart';
import 'package:jingle_player/ui/toolbar.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:toastification/toastification.dart';

String appTitle = "Jingle Player";
int playerCount = 16;
int paletteCount = 8;
String filesPath = '';
late Map<String, dynamic> configMap;
String configPath = './config.json';

void main() async {
  AudioLogger.logLevel = AudioLogLevel.error;
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(1280, 720),
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
  var configFile = await File(configPath).exists();
  if (!configFile) {
    debugPrint("Using default configuration");
    await initializeMediaDirectory(filesPath);
    return;
  }
  try {
    debugPrint('Loading configuration file $configPath');
    await loadConfigFromFile(configPath);
  } catch (e) {
    debugPrint('$e');
  }
}

Future<void> loadConfigFromFile(String configPath) async {
  var appConfig = await File(configPath).readAsString();
  Map<String, dynamic> configMap = await jsonDecode(appConfig);
  paletteCount = configMap['paletteCount'];
  appTitle = configMap['appTitle'];
  playerCount = configMap['playerCount'];
  if (configMap.containsKey('filesPath')) {
    debugPrint("Found media directory in config file");
    filesPath = configMap['filesPath'];
  }
  await initializeMediaDirectory(filesPath);
}

Future<void> initializeMediaDirectory(String mediaPath) async {
  bool mediaDirExists;
  String createPath;
  final appDocsDir = await getApplicationSupportDirectory();
  if (mediaPath != '') {
    debugPrint(
      "Initializing media directory in the configured location $mediaPath",
    );
    createPath = mediaPath;
  } else {
    debugPrint("Initializing media directory in the default location");
    createPath = path.join(appDocsDir.path, "media");
    filesPath = createPath;
  }
  mediaDirExists = await Directory(createPath).exists();
  if (!mediaDirExists) {
    debugPrint("Creating media directory $createPath");
    try {
      await Directory(createPath).create(recursive: true);
    } catch (e) {
      debugPrint("An error occured when initializing media directory: $e");
    }
  }
  debugPrint("Media directory available: $createPath");
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
    return ToastificationWrapper(
      child: MaterialApp(
        title: appTitle,
        scrollBehavior: PlayerScrollBehavior(),
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
            displayLarge: GoogleFonts.spaceMono(),
            displayMedium: GoogleFonts.spaceMono(),
            titleLarge: GoogleFonts.sora(fontWeight: FontWeight.bold),
            titleMedium: GoogleFonts.sora(fontWeight: FontWeight.bold),
            titleSmall: GoogleFonts.sora(fontWeight: FontWeight.bold),
            displaySmall: GoogleFonts.spaceMono(),
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
            headlineLarge: GoogleFonts.spaceMono(),
            headlineMedium: GoogleFonts.spaceMono(),
            headlineSmall: GoogleFonts.spaceMono(fontSize: 16),
            bodyLarge: GoogleFonts.sora(),
            bodyMedium: GoogleFonts.sora(),
            bodySmall: GoogleFonts.sora(),
          ),
        ),
        home: HomePage(title: appTitle),
      ),
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
    debugPrint("Initializing audio player");
    await audioPlayer.initialize(playerCount, paletteCount, filesPath);
    await audioPlayer.getPalette(audioPlayer.activePalette);
  }

  @override
  void onWindowFocus() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _audioPlayer = Provider.of<AudioHandler>(context, listen: true);
    return Shortcuts(
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.space): PlayerStartIntent(),
        SingleActivator(LogicalKeyboardKey.escape): PlayerStopIntent(),
        SingleActivator(LogicalKeyboardKey.keyE, control: true):
            EditModeHandler(),
        for (MapEntry<int, LogicalKeyboardKey> k in _audioPlayer.keyMap.entries)
          SingleActivator(k.value): ButtonPressHandler(index: k.key),
        for (MapEntry<int, LogicalKeyboardKey> k
            in _audioPlayer.paletteKeyMap.entries)
          SingleActivator(k.value, control: true): PaletteSelectHandler(
            index: k.key,
          ),
      },
      child: Actions(
        actions: {
          ButtonPressHandler: ButtonPressAction(audioHandler: _audioPlayer),
          PaletteSelectHandler: PaletteSelectAction(audioHandler: _audioPlayer),
          PlayerStartIntent: PlayerStartAction(audioHandler: _audioPlayer),
          PlayerStopIntent: PlayerStopAction(audioHandler: _audioPlayer),
          EditModeHandler: EditModeAction(audioHandler: _audioPlayer),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 120),
              child: TopBar(title: widget.title),
            ),
            body: Stack(
              children: [
                Center(child: JingleGrid(playerCount: playerCount)),
                Consumer<AudioHandler>(
                  builder: (context, player, child) {
                    switch (player.toolbarActive) {
                      case true:
                        return Align(
                          alignment: Alignment.bottomLeft,
                          child: Toolbar(),
                        );
                      case false:
                        return Container();
                    }
                  },
                ),
              ],
            ),
            bottomNavigationBar: PlayerSection(),
          ),
        ),
      ),
    );
  }
}

class ButtonPressHandler extends Intent {
  final int index;
  const ButtonPressHandler({required this.index});
}

class ButtonPressAction extends Action<ButtonPressHandler> {
  AudioHandler audioHandler;

  ButtonPressAction({required this.audioHandler});

  @override
  Future<void> invoke(ButtonPressHandler intent) async {
    if (audioHandler.sourceMap[intent.index] == null) {
      debugPrint('$intent.index');
      debugPrint('tried to activate empty source');
    } else if (audioHandler.editMode) {
      debugPrint('button in edit mode - not playing');
    } else {
      await audioHandler.stop();
      await audioHandler.loadToPlayer(audioHandler.sourceMap[intent.index]!);
    }
  }
}

class PlayerScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class PlayerStartIntent extends Intent {}

class PlayerStopIntent extends Intent {}

class PlayerStartAction extends Action<PlayerStartIntent> {
  AudioHandler audioHandler;
  PlayerStartAction({required this.audioHandler});

  @override
  Future<void> invoke(PlayerStartIntent intent) async {
    audioHandler.play();
  }
}

class PlayerStopAction extends Action<PlayerStopIntent> {
  AudioHandler audioHandler;
  PlayerStopAction({required this.audioHandler});

  @override
  Future<void> invoke(PlayerStopIntent intent) async {
    audioHandler.stop();
  }
}

class PaletteSelectHandler extends Intent {
  final int index;
  const PaletteSelectHandler({required this.index});
}

class PaletteSelectAction extends Action<PaletteSelectHandler> {
  AudioHandler audioHandler;
  PaletteSelectAction({required this.audioHandler});

  @override
  Future<void> invoke(PaletteSelectHandler intent) async {
    audioHandler.editMode
        ? await audioHandler.savePalette(intent.index)
        : await audioHandler.getPalette(intent.index);
  }
}

class EditModeHandler extends Intent {}

class EditModeAction extends Action<EditModeHandler> {
  AudioHandler audioHandler;
  EditModeAction({required this.audioHandler});

  @override
  void invoke(EditModeHandler intent) {
    int activePalette = audioHandler.activePalette;
    audioHandler.switchMode(activePalette);
  }
}
