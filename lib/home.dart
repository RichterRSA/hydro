import 'package:flutter/material.dart';
import 'package:hydro/overview.dart';
import 'package:hydro/settings.dart';

import 'developer.dart';

class HomePage extends StatefulWidget {
  final bool isMobile;
  const HomePage({super.key, required this.isMobile});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.isMobile) {
      return const MobileHome();
    } else {
      return const DesktopHome();
    }
  }
}

//******** DESKTOP *********//

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  int railSelectedIndex = 1;
  bool navRailExtended = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: navRailExtended,
            onDestinationSelected: (int index) {
              setState(() {
                if (index > 0) {
                  railSelectedIndex = index;
                } else {
                  navRailExtended = !navRailExtended;
                }
              });
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.menu),
                label: Text('Menu'),
              ),
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
          Expanded(child: pages()[railSelectedIndex - 1]),
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        title: Text(pageTitles[navbarSelectedIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
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
      body: pages()[navbarSelectedIndex],
    );
  }
}

List<Widget> pages() {
  return const [
    OverviewPage(),
    DeveloperPage(),
    SettingsPage(),
  ];
}

const pageTitles = ['Overview', 'Developer Options', 'Settings'];
