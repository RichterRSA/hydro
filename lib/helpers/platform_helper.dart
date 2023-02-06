import 'dart:io';
import 'package:flutter/widgets.dart';

bool useDesktopLayout(BuildContext context) {
  if (Platform.isAndroid || Platform.isIOS) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    final bool useDesktopLayout = shortestSide > 600;

    return useDesktopLayout;
  } else {
    return true;
  }
}
