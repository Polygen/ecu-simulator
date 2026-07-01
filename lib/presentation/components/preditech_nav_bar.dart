import 'package:flutter/material.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';

/// ECU Sim'in 5 tab'lı gezinme çubuğu. UI Kit'in generic
/// `PreditechTabBar<T>` organizmasını `AppTab` enum'u ile sarar.
///
/// Neden lokal adaptör: projenin kendi tab isimleri var
/// (home/dtc/connection/garage/settings) ve UI Kit'in 3-tab'lı
/// `PreditechNavBar` organizması hardcoded. Bu ince wrapper,
/// `AppTab`'ı generic `<T>` parametresi olarak besler; UI Kit
/// width-aware capsule hesabını ve animasyonlarını kendisi yapar.
enum AppTab { home, dtc, connection, garage, settings }

class PreditechNavBar5 extends StatelessWidget {
  const PreditechNavBar5({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });

  final AppTab currentTab;
  final ValueChanged<AppTab> onTabChanged;

  static const _tabs = <PreditechTabItem<AppTab>>[
    PreditechTabItem(
      value: AppTab.home,
      activeIcon: PreditechIcons.homeFill,
      inactiveIcon: PreditechIcons.homeDuotone,
      label: 'Ana',
    ),
    PreditechTabItem(
      value: AppTab.dtc,
      activeIcon: PreditechIcons.warning,
      label: 'Hatalar',
    ),
    PreditechTabItem(
      value: AppTab.connection,
      activeIcon: PreditechIcons.ble,
      label: 'Bağlantı',
    ),
    PreditechTabItem(
      value: AppTab.garage,
      activeIcon: PreditechIcons.carFill,
      inactiveIcon: PreditechIcons.carDuotone,
      label: 'Garaj',
    ),
    PreditechTabItem(
      value: AppTab.settings,
      activeIcon: PreditechIcons.settingsFill,
      inactiveIcon: PreditechIcons.settingsDuotone,
      label: 'Ayarlar',
    ),
  ];

  @override
  Widget build(BuildContext context) => PreditechTabBar<AppTab>(
        currentValue: currentTab,
        onChanged: onTabChanged,
        tabs: _tabs,
      );
}
