import 'package:flutter/material.dart';
import 'package:hydro/developer.dart';
import 'package:hydro/helpers/platform_helper.dart';
import 'package:hydro/overview.dart';
import 'package:hydro/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return useDesktopLayout(context) ? const DesktopHome() : const MobileHome();
  }
}

//******** DESKTOP *********//

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  int railSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: (int index) {
              setState(() {
                railSelectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Overview'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bug_report_outlined),
                selectedIcon: Icon(Icons.bug_report),
                label: Text('Developer Options'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            selectedIndex: railSelectedIndex,
          ),
          const VerticalDivider(
            color: Colors.grey,
            thickness: 1,
            width: 1,
          ),
          Pages()[railSelectedIndex],
        ],
      ),
    );
  }
}

//******** MOBILE *********//
class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  int navbarSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            navbarSelectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Overview'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report_outlined),
            activeIcon: Icon(Icons.bug_report),
            label: 'Developer Options',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: navbarSelectedIndex,
      ),
      body: Pages()[navbarSelectedIndex],
    );
  }
}

List<Widget> Pages() {
  return const [
    OverviewPage(),
    DeveloperPage(),
    SettingsPage(),
  ];
}
