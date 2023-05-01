import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> useDesktopLayout(FlutterView view) async {
  final layout = await getLayout();
  if (layout == 0) {
    if (Platform.isAndroid || Platform.isIOS) {
      // The equivalent of the "smallestWidth" qualifier on Android.
      var shortestSide = view.displayFeatures.first.bounds.size.shortestSide;

      // Determine if we should use mobile layout or not, 600 here is
      // a common breakpoint for a typical 7-inch tablet.
      final bool useDesktopLayout = shortestSide > 600;

      return useDesktopLayout;
    } else {
      return true;
    }
  } else {
    return layout == 2;
  }
}

Future<int> getLayout() async {
  final prefs = await SharedPreferences.getInstance();
  int? mode = prefs.getInt('layout_mode');

  if (mode == null) return 0;

  return mode;
}

Brightness getSystemBrightness() {
  return PlatformDispatcher.instance.platformBrightness;
}

Brightness getCurrentBrightness(BuildContext context) {
  return MediaQueryData.fromView(View.of(context)).platformBrightness;
}
