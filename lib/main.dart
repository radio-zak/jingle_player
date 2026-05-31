import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jingle_player/ui/jingle_grid.dart';
import 'package:provider/provider.dart';
import 'package:jingle_player/audio_handler.dart';
import 'package:jingle_player/ui/top_bar.dart';
import 'package:window_manager/window_manager.dart';
import 'package:jingle_player/ui/player_section.dart';
import 'package:jingle_player/ui/toolbar.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:toastification/toastification.dart';
import 'package:jingle_player/logger.dart';
import 'package:jingle_player/config.dart';
import 'package:jingle_player/file_ops.dart';

void main() async {
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

  final FileOperationService fileOps = FileOperationService();
  final ApplicationConfig config = await ApplicationConfig.init(fileOps);
  final LoggingService logger = await LoggingService.initialize(
    config,
    fileOps,
  );
  await AudioHandler.init(logger, fileOps, config);

  AudioLogger.logLevel = AudioLogLevel.error;

  logger.print.i("Services initialized");
  try {
    await ApplicationConfig().initializeMediaDirectory();
    logger.print.i("Initialized media directory");
  } catch (e) {
    logger.print.e("Error initializing media directory: $e");
  }

  logger.print.i(
    "Using configuration: players: ${config.players}, palettes: ${config.palettes}, media directory: ${config.mediaDir}, log level: ${config.logLevel}, log path: ${config.logPath} ",
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AudioHandler>(
          create: (context) => AudioHandler(),
        ),
        ChangeNotifierProvider<ApplicationConfig>(
          create: (context) => ApplicationConfig(),
        ),
      ],
      child: const JinglePlayer(),
    ),
  );
}

class JinglePlayer extends StatelessWidget {
  const JinglePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.read<ApplicationConfig>();
    final surfaceColor = Color.fromARGB(255, 34, 34, 34);
    final primaryColor = Colors.teal;
    final primaryDimmedColor = Color.fromARGB(255, 54, 54, 54);
    final textPrimaryColor = Colors.white;
    final textGreyedColor = Color(0xFFBBBBBB);
    return ToastificationWrapper(
      child: MaterialApp(
        title: config.appTitle,
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
        home: HomePage(title: config.appTitle),
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
  final config = ApplicationConfig();
  LoggingService logger = LoggingService();

  @override
  void initState() {
    setState(() {
      super.initState();
      windowManager.addListener(this);
    });
  }

  @override
  void onWindowFocus() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final config = context.read<ApplicationConfig>();
    final _audioPlayer = Provider.of<AudioHandler>(context, listen: true);
    return Shortcuts(
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.space): PlayerStartIntent(),
        SingleActivator(LogicalKeyboardKey.escape): PlayerStopIntent(),
        SingleActivator(LogicalKeyboardKey.keyE, control: true):
            EditModeHandler(),
        for (MapEntry<int, LogicalKeyboardKey> k in config.keyMap.entries)
          SingleActivator(k.value): ButtonPressHandler(index: k.key),
        for (MapEntry<int, LogicalKeyboardKey> k
            in config.paletteKeyMap.entries)
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
                Center(child: JingleGrid(playerCount: config.players)),
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
  LoggingService logger = LoggingService();

  ButtonPressAction({required this.audioHandler});

  @override
  Future<void> invoke(ButtonPressHandler intent) async {
    if (audioHandler.sourceMap[intent.index] == null) {
      logger.print.d('$intent.index');
      logger.print.d('tried to activate empty source');
    } else if (audioHandler.editMode) {
      // logger.print.d('button in edit mode - not playing');
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
