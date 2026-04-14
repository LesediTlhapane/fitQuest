// lib/views/main_navigation_screen.dart
import 'package:flutter/material.dart';
import 'package:fitquest/views/home_screen.dart';
import 'package:fitquest/views/plans_screen.dart';
import 'package:fitquest/views/run_screen.dart';
import 'package:fitquest/views/club_screen.dart';
import 'package:fitquest/views/stats_screen.dart';
import 'package:fitquest/views/widgets/fitquest_bottom_nav.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const HomeScreenEnhanced(),
    const PlansScreen(),
    const RunScreen(),
    const ClubsScreen(),
    const StatsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: FitQuestBottomNav(
        index: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}