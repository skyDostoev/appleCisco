// @dart=2.16

import 'dart:ui' as ui;

import 'package:apple_cisco/main.dart' as entrypoint;

Future<void> main() async {
  await ui.webOnlyInitializePlatform();
  entrypoint.main();
}
