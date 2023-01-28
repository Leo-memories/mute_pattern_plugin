
import 'mute_pattern_plugin_platform_interface.dart';

class MutePatternPlugin {
  Future<String?> getPlatformVersion() {
    return MutePatternPluginPlatform.instance.getPlatformVersion();
  }


  Future<String?> checkMutePattern() {
    return MutePatternPluginPlatform.instance.checkMutePattern();
  }
}
