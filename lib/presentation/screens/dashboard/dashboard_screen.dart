import 'package:flutter/material.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';
import '../../components/preditech_nav_bar.dart';
import '../pid_dashboard/pid_dashboard_screen.dart';
import '../dtc/dtc_screen.dart';
import '../connection/connection_screen.dart';
import '../profiles/profiles_screen.dart';
import '../settings/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AppTab _currentTab = AppTab.home;

  Widget _getScreen() {
    switch (_currentTab) {
      case AppTab.home:
        return const PidDashboardScreen();
      case AppTab.dtc:
        return const DtcScreen();
      case AppTab.connection:
        return const ConnectionScreen();
      case AppTab.garage:
        return const ProfilesScreen();
      case AppTab.settings:
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
      bottomNavigationBar: PreditechNavBar5(
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