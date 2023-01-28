import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mute_pattern_plugin_method_channel.dart';

abstract class MutePatternPluginPlatform extends PlatformInterface {
  /// Constructs a MutePatternPluginPlatform.
  MutePatternPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MutePatternPluginPlatform _instance = MethodChannelMutePatternPlugin();

  /// The default instance of [MutePatternPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMutePatternPlugin].
  static MutePatternPluginPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MutePatternPluginPlatform] when
  /// they register themselves.
  static set instance(MutePatternPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> checkMutePattern() {
    throw UnimplementedError('checkMutePattern() has not been implemented.');
  }
}
