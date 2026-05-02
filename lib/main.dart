import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants.dart';
import 'providers/control_provider.dart';
import 'providers/data_provider.dart';
import 'screens/alerts/alerts_screen.dart';
import 'screens/control/control_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/debug/debug_screen.dart';
import 'screens/history/history_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() {
  runApp(const SmartClimateApp());
}

class SmartClimateApp extends StatelessWidget {
  const SmartClimateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()..startPolling()),
        ChangeNotifierProvider(create: (_) => ControlProvider()),
      ],
      child: MaterialApp(
        title: 'Smart Climate Control',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.transparent,
          fontFamily: AppConstants.defaultFont,
          colorScheme: const ColorScheme.dark(
            primary: AppConstants.neonPink,
            secondary: AppConstants.neonAmber,
          ),
        ),
        home: const AppShell(),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    ControlScreen(),
    SettingsScreen(),
    AlertsScreen(),
    HistoryScreen(),
    DebugScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppConstants.bgTop, AppConstants.bgBottom],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: _screens[currentIndex]),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.black.withValues(alpha: 0.2),
          indicatorColor: AppConstants.neonPink.withValues(alpha: 0.3),
          selectedIndex: currentIndex,
          onDestinationSelected: (value) => setState(() => currentIndex = value),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            NavigationDestination(icon: Icon(Icons.tune), label: 'Control'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
            NavigationDestination(icon: Icon(Icons.warning_amber), label: 'Alerts'),
            NavigationDestination(icon: Icon(Icons.query_stats), label: 'History'),
            NavigationDestination(icon: Icon(Icons.bug_report), label: 'Debug'),
          ],
        ),
      ),
    );
  }
}
