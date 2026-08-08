import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:djinn/grpc.dart';
import 'package:djinn/ui/clock.dart';
import 'package:djinn/ui/time_remaining.dart';
import 'ui/jingle_grid.dart';
import 'package:provider/provider.dart';
import 'audio_handler.dart';
import 'ui/top_bar.dart';
import 'package:window_manager/window_manager.dart';
import 'ui/player_section.dart';
import 'ui/toolbar.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:toastification/toastification.dart';
import 'logger.dart';
import 'config.dart';
import 'file_ops.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(1280, 800),
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
  final grpcClient = GrpcClient();

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
        ChangeNotifierProvider<AudioProvider>(
          create: (context) => AudioProvider(grpcClient, fileOps, logger),
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
        title: "Djinn",
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
        home: HomePage(title: "Djinn"),
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
  late AudioProvider audioPlayer;
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
    final _audioPlayer = Provider.of<AudioProvider>(context, listen: true);
    return Shortcuts(
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.space): PlayerStartIntent(),
        SingleActivator(LogicalKeyboardKey.escape): PlayerStopIntent(),
        SingleActivator(LogicalKeyboardKey.keyE, control: true):
            EditModeHandler(),
        for (MapEntry<int, LogicalKeyboardKey> k in config.keyMap.entries)
          SingleActivator(k.value): ButtonPressHandler(index: k.key),
        // for (MapEntry<int, LogicalKeyboardKey> k
        //     in config.paletteKeyMap.entries)
        //   SingleActivator(k.value, control: true): PaletteSelectHandler(
        //     index: k.key,
        //   ),
      },
      child: Actions(
        actions: {
          ButtonPressHandler: ButtonPressAction(audioProvider: _audioPlayer),
          // PaletteSelectHandler: PaletteSelectAction(audioHandler: _audioPlayer),
          PlayerStartIntent: PlayerStartAction(audioProvider: _audioPlayer),
          PlayerStopIntent: PlayerStopAction(audioProvider: _audioPlayer),
          EditModeHandler: EditModeAction(audioProvider: _audioPlayer),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 120),
              child: TopBar(
                title: widget.title,
                backButton: false,
                centerSlot: TimeRemainingClock(),
                rightSlot: StudioClock(),
              ),
            ),
            body: Consumer<AudioProvider>(
              builder: (context, value, child) {
                switch (value.isSlotStatusConnected) {
                  case false:
                    return Center(
                      child: !value.slotStatusConnBackOff
                          ? Row(
                              spacing: 32,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  strokeCap: StrokeCap.round,
                                  color: Theme.of(context).colorScheme.primary,
                                  semanticsLabel: "Connecting...",
                                ),
                                Text(
                                  "Connecting...",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            )
                          : Column(
                              spacing: 16,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Conenction to backend failed",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "${value.errorMessage}",
                                  textAlign: TextAlign.center,
                                ),
                                TextButton(
                                  child: Text("Reconnect"),
                                  onPressed: () {
                                    value.reconnectionTries = 0;
                                    value.slotStatusConnBackOff = false;
                                    value.audioStatusConnBackOff = false;
                                    value.connectToAudioStatusBackend();
                                    value.connectToSlotStatus();
                                  },
                                ),
                              ],
                            ),
                    );
                  case true:
                    return Stack(
                      children: [
                        Center(child: JingleGrid(playerCount: config.players)),
                        Consumer<AudioProvider>(
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
                    );
                }
              },
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
  AudioProvider audioProvider;
  LoggingService logger = LoggingService();

  ButtonPressAction({required this.audioProvider});

  @override
  Future<void> invoke(ButtonPressHandler intent) async {
    if (audioProvider.editMode) {
      logger.print.d('button in edit mode - not playing');
    } else {
      await audioProvider.loadToPlayer(intent.index);
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
  AudioProvider audioProvider;
  PlayerStartAction({required this.audioProvider});
  @override
  Future<void> invoke(PlayerStartIntent intent) async {
    audioProvider.play();
  }
}

class PlayerStopAction extends Action<PlayerStopIntent> {
  AudioProvider audioProvider;
  PlayerStopAction({required this.audioProvider});

  @override
  Future<void> invoke(PlayerStopIntent intent) async {
    audioProvider.stop();
  }
}

// class PaletteSelectHandler extends Intent {
//   final int index;
//   const PaletteSelectHandler({required this.index});
// }

// class PaletteSelectAction extends Action<PaletteSelectHandler> {
//   AudioHandler audioHandler;
//   PaletteSelectAction({required this.audioHandler});

//   @override
//   Future<void> invoke(PaletteSelectHandler intent) async {
//     audioHandler.editMode
//         ? await audioHandler.savePalette(intent.index)
//         : await audioHandler.getPalette(intent.index);
//   }
// }

class EditModeHandler extends Intent {}

class EditModeAction extends Action<EditModeHandler> {
  AudioProvider audioProvider;
  EditModeAction({required this.audioProvider});

  @override
  void invoke(EditModeHandler intent) {
    int activePalette = audioProvider.activePalette;
    audioProvider.switchMode(activePalette);
  }
}
