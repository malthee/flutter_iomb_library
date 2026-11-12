import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_iomb_library/flutter_iomb_library.dart';
import 'package:flutter_iomb_library/src/channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('flutter_iomb_library');
  final calls = <MethodCall>[];
  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return null;
        });
  });
  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null),
  );

  test('existing callers retain German measurement by default', () async {
    await MethodChannelFlutterIombLibrary().sessionConfiguration(
      baseURL: 'https://measurement.example',
      offerIdentifier: 'example',
    );
    expect(calls.single.method, 'sessionConfiguration');
    expect(calls.single.arguments, containsPair('measurementSystem', 'iomb'));
  });

  test(
    'ÖWA explicitly selects Austrian measurement without changing identifiers',
    () async {
      await MethodChannelFlutterIombLibrary().sessionConfiguration(
        baseURL: 'https://measurement.example',
        offerIdentifier: 'at_a_example',
        hybridIdentifier: 'hybrid',
        measurementSystem: IOMBMeasurementSystem.iombAt,
      );
      expect(calls.single.arguments, {
        'baseURL': 'https://measurement.example',
        'offerIdentifier': 'at_a_example',
        'hybridIdentifier': 'hybrid',
        'measurementSystem': 'iombAt',
      });
    },
  );
}
