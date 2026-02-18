import 'package:flutter/material.dart';

import 'ui/providers/theme_color_provider.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'ui/screens/downloads/downloads_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeColorProvider,
      builder: (context, child) {
        final List<Widget> pages = [DownloadsScreen(), SettingsScreen()];
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: Scaffold(
            body: pages[_currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              selectedItemColor: currentThemeColor.color,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Downloads',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
