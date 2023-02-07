import 'package:flutter/material.dart';
import 'package:hydro/custom_widgets/custom_page.dart';
import 'package:hydro/custom_widgets/settings_option.dart';
import 'package:hydro/helpers/platform_helper.dart';
import 'package:hydro/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkModeEnabled = false;
  bool automaticDarkMode = true;

  @override
  Widget build(BuildContext context) {
    darkModeEnabled = getCurrentBrightness(context) == Brightness.dark;
    return FutureBuilder(
      future: getSettings(),
      builder: (context, snapshot) {
        return CustomPage(
          title: 'Settings',
          children: [
            SettingsOption(
              settingName: 'Automatic Light/Dark',
              description: 'Adjusts the theme based on the system theme.',
              value: snapshot.hasData ? snapshot.data!.automaticTheme : false,
              onChange: (value) async {
                final prefs = await SharedPreferences.getInstance();
                if (value) {
                  await prefs.remove('theme_override');
                } else {
                  await prefs.setString(
                      'theme_override', (darkModeEnabled) ? 'dark' : 'light');
                }

                setState(() {
                  automaticDarkMode = value;
                });

                HydroAppState.instance!.setState(() {});
              },
            ),
            SettingsOption(
              settingName: 'Dark Mode',
              description: 'Enable the dark theme.',
              value: snapshot.hasData ? snapshot.data!.darkMode : false,
              enabled: !automaticDarkMode,
              onChange: (value) async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString(
                    'theme_override', (value) ? 'dark' : 'light');
                setState(() {
                  darkModeEnabled = value;
                });

                HydroAppState.instance!.setState(() {});
              },
            ),
            SettingsOption(
              settingName: 'Mobile Theme',
              description: 'Uses the theme used on mobile devices.',
              value: false,
              onChange: (p0) {},
            ),
          ],
        );
      },
    );
  }

  Future<SettingsPageInfo> getSettings() async {
    final prefs = await SharedPreferences.getInstance();

    SettingsPageInfo info = SettingsPageInfo();
    String? themeOverride = prefs.getString('theme_override');
    info.automaticTheme = themeOverride == null;
    automaticDarkMode = info.automaticTheme;
    info.darkMode = !info.automaticTheme ? (themeOverride == 'dark') : false;
    darkModeEnabled = info.darkMode;
    return info;
  }
}

class SettingsPageInfo {
  bool darkMode = false;
  bool automaticTheme = true;

  SettingsPageInfo();
}
