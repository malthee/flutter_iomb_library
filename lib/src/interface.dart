import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'channel.dart';

enum IOMBViewEvent { appeared, refreshed, disappeared }

enum IOMBDebugLevel { off, error, warning, info, trace }

/// Android measurement system; iOS uses its existing session configuration.
enum IOMBMeasurementSystem { iomb, iombAt }

abstract class IombLibrary extends PlatformInterface {
  /// Constructs a FlutterIombLibraryPlatform.
  IombLibrary() : super(token: _token);

  static final Object _token = Object();

  static IombLibrary _instance = MethodChannelFlutterIombLibrary();

  /// The default instance of [IombLibrary] to use.
  ///
  /// Defaults to [MethodChannelFlutterIombLibrary].
  static IombLibrary get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IombLibrary] when
  /// they register themselves.
  static set instance(IombLibrary instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  abstract final IombLibraryPlatformIOS ios;
  abstract final IombLibraryPlatformAndroid android;

  /// Configures the measurement session.
  ///
  /// On Android, [measurementSystem] defaults to German IOMb; select
  /// [IOMBMeasurementSystem.iombAt] for Austrian ÖWA. iOS ignores this option.
  Future<void> sessionConfiguration({
    required String baseURL,
    required String offerIdentifier,
    String? hybridIdentifier,
    IOMBMeasurementSystem measurementSystem = IOMBMeasurementSystem.iomb,
  }) async {
    throw UnimplementedError(
      'sessionConfiguration() has not been implemented.',
    );
  }

  Future<void> logViewEvent({
    required IOMBViewEvent type,
    required String category,
    String? comment,
  }) async {
    throw UnimplementedError('logViewEvent() has not been implemented.');
  }

  Future<void> terminateSession() {
    throw UnimplementedError('terminateSession() has not been implemented.');
  }

  void setFlutterDebugModeEnabled(bool enable) {
    throw UnimplementedError(
      'setFlutterDebugModeEnabled() has not been implemented.',
    );
  }
}

abstract class IombLibraryPlatformIOS {
  Future<void> setDebugLogLevel(IOMBDebugLevel level) async {
    throw UnimplementedError('setDebugLogLevel() has not been implemented.');
  }
}

abstract class IombLibraryPlatformAndroid {
  Future<void> setDebugModeEnabled(bool enable) async {
    throw UnimplementedError('setDebugModeEnabled() has not been implemented.');
  }
}
