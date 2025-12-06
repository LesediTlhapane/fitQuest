// lib/widgets/bottom_nav.dart
import 'package:flutter/material.dart';
import '../core/theme.dart';

class FitQuestBottomNav extends StatelessWidget {
  final int index;
  final Function(int) onTap;

  const FitQuestBottomNav({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 70,
      selectedIndex: index,
      onDestinationSelected: onTap,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month_rounded), label: 'Plans'),
        NavigationDestination(icon: Icon(Icons.directions_run_outlined), selectedIcon: Icon(Icons.directions_run_rounded), label: 'Run'),
        NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups_rounded), label: 'Club'),
        NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart_rounded), label: 'Activity'),
      ],
    );
  }
}
