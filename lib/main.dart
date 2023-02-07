import 'package:flutter/material.dart';
import 'package:hydro/helpers/platform_helper.dart';
import 'package:hydro/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const HydroApp());
}

class HydroApp extends StatefulWidget {
  const HydroApp({super.key});

  @override
  State<HydroApp> createState() => HydroAppState();
}

class HydroAppState extends State<HydroApp> {
  ThemeData? customTheme;
  static HydroAppState? instance;

  @override
  Widget build(BuildContext context) {
    instance = this;
    return FutureBuilder(
      future: useSystem(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            title: 'hydro',
            theme: (snapshot.data!) ? light : customTheme!,
            darkTheme: (snapshot.data!) ? dark : customTheme!,
            home: const HomePage(),
          );
        } else {
          return const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Future<bool> useSystem() async {
    final prefs = await SharedPreferences.getInstance();
    String? bright = prefs.getString('theme_override');

    customTheme = await getTheme();

    return bright == null;
  }

  Future<ThemeData> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? bright = prefs.getString('theme_override');

    if (bright == null) {
      return getSystemBrightness() == Brightness.dark ? dark : light;
    }

    if (bright == 'dark') {
      return dark;
    } else {
      return light;
    }
  }

  ThemeData light = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.light,
  );

  ThemeData dark = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
  );
}
