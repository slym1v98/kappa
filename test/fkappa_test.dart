import 'package:flutter_test/flutter_test.dart';
import 'package:fkappa/fkappa_platform_interface.dart';
import 'package:fkappa/fkappa_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFKappaPlatform
    with MockPlatformInterfaceMixin
    implements FKappaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FKappaPlatform initialPlatform = FKappaPlatform.instance;

  test('$MethodChannelFKappa is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFKappa>());
  });

  test('getPlatformVersion', () async {
    MockFKappaPlatform fakePlatform = MockFKappaPlatform();
    FKappaPlatform.instance = fakePlatform;

    expect(await FKappaPlatform.instance.getPlatformVersion(), '42');
  });
}
