import 'package:flutter_test/flutter_test.dart';
import 'package:mute_pattern_plugin/mute_pattern_plugin.dart';
import 'package:mute_pattern_plugin/mute_pattern_plugin_platform_interface.dart';
import 'package:mute_pattern_plugin/mute_pattern_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMutePatternPluginPlatform 
    with MockPlatformInterfaceMixin
    implements MutePatternPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MutePatternPluginPlatform initialPlatform = MutePatternPluginPlatform.instance;

  test('$MethodChannelMutePatternPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMutePatternPlugin>());
  });

  test('getPlatformVersion', () async {
    MutePatternPlugin mutePatternPlugin = MutePatternPlugin();
    MockMutePatternPluginPlatform fakePlatform = MockMutePatternPluginPlatform();
    MutePatternPluginPlatform.instance = fakePlatform;
  
    expect(await mutePatternPlugin.getPlatformVersion(), '42');
  });
}
