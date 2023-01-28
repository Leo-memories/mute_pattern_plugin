import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mute_pattern_plugin_platform_interface.dart';

/// An implementation of [MutePatternPluginPlatform] that uses method channels.
class MethodChannelMutePatternPlugin extends MutePatternPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mute_pattern_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }


  @override
  Future<String?> checkMutePattern() async {
    final isMute = await methodChannel.invokeMethod<String>('checkMutePattern');
    return isMute;
  }

}
