import 'package:flutter/material.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';
import '../pid_dashboard/pid_dashboard_screen.dart';
import '../dtc/dtc_screen.dart';
import '../profiles/profiles_screen.dart';
import '../connection/connection_screen.dart';
import '../settings/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PreditechTab _currentTab = PreditechTab.home;

  Widget _getScreen() {
    switch (_currentTab) {
      case PreditechTab.home:
        return const PidDashboardScreen();
      case PreditechTab.dtc:
        return const DtcScreen();
      case PreditechTab.connection:
        return const ConnectionScreen();
      case PreditechTab.garage:
        return const ProfilesScreen();
      case PreditechTab.settings:
        return const SettingsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final semantics = context.pt;

    return Scaffold(
      backgroundColor: semantics.background,
      body: SafeArea(
        child: _getScreen(),
      ),
      bottomNavigationBar: PreditechNavBar(
        currentTab: _currentTab,
        onTabChanged: (tab) {
          setState(() {
            _currentTab = tab;
          });
        },
      ),
    );
  }
}

