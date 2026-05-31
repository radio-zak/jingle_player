import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:jingle_player/config.dart';
import 'package:jingle_player/file_ops.dart';

class MockFileOperationService extends Mock implements FileOperationService {}

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationSupportPath() async => '/mock/support/dir';
}

void main() {
  late MockFileOperationService mockFileOps;
  late MockPathProviderPlatform mockPathProvider;

  setUp(() {
    mockFileOps = MockFileOperationService();
    mockPathProvider = MockPathProviderPlatform();
    PathProviderPlatform.instance = mockPathProvider;
  });

  tearDown(() {
    ApplicationConfig.reset();
  });

  group('ApplicationConfig - Initialization Factory', () {
    test('Throws StateError if accessed before calling init()', () {
      expect(() => ApplicationConfig(), throwsA(isA<StateError>()));
    });
  });

  group('ApplicationConfig - init()', () {
    test(
      'Initializes with default values if config file does not exist',
      () async {
        // Arrange
        when(
          () => mockFileOps.checkFileExists("./config.json"),
        ).thenAnswer((_) async => false);

        // Act
        final config = await ApplicationConfig.init(mockFileOps);

        // Assert
        expect(config.players, equals(16));
        expect(config.palettes, equals(8));
        expect(config.appTitle, equals("Jingle Player "));
        expect(config.mediaDir, equals("/mock/support/dir/media"));

        expect(ApplicationConfig(), equals(config));
      },
    );

    test('Initializes with custom values if config file exists', () async {
      // Arrange
      final fakeJson = {
        'playerCount': 32,
        'paletteCount': 4,
        'appTitle': 'Test Title',
        'mediaDir': '/custom/media',
        'logPath': '/custom/log',
        'logLevel': 'debug',
      };

      when(
        () => mockFileOps.checkFileExists("./config.json"),
      ).thenAnswer((_) async => true);
      when(
        () => mockFileOps.readAsString("./config.json"),
      ).thenAnswer((_) async => jsonEncode(fakeJson));

      // Act
      final config = await ApplicationConfig.init(mockFileOps);

      // Assert
      expect(config.players, equals(32));
      expect(config.palettes, equals(4));
      expect(config.appTitle, equals('Test Title'));
      expect(config.mediaDir, equals('/custom/media'));
      expect(config.logLevel, equals('debug'));
    });

    test(
      'Initializes with fallback defaults if config file exists but is missing specific keys',
      () async {
        final incompleteJson = {
          'paletteCount': 12,
          'mediaDir': '/custom/media',
        };

        when(
          () => mockFileOps.checkFileExists("./config.json"),
        ).thenAnswer((_) async => true);
        when(
          () => mockFileOps.readAsString("./config.json"),
        ).thenAnswer((_) async => jsonEncode(incompleteJson));

        final config = await ApplicationConfig.init(mockFileOps);

        expect(config.palettes, equals(12)); // From JSON
        expect(config.players, equals(16)); // Default fallback
        expect(config.appTitle, equals("Jingle Player ")); // Default fallback
      },
    );

    test(
      'Returns the identical instance if init() is called multiple times',
      () async {
        // Arrange
        when(
          () => mockFileOps.checkFileExists("./config.json"),
        ).thenAnswer((_) async => false);

        final firstCall = await ApplicationConfig.init(mockFileOps);
        final secondCall = await ApplicationConfig.init(mockFileOps);

        expect(
          identityHashCode(firstCall),
          equals(identityHashCode(secondCall)),
        );
        verify(
          () => mockFileOps.checkFileExists("./config.json"),
        ).called(1); // Should only execute JSON setup check once
      },
    );
  });
}
