import 'package:flutter/material.dart';

class FitQuestBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const FitQuestBottomNav({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.event_note_outlined), label: 'Plans'),
        BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Run'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'Club'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Activity'),
      ],
    );
  }
}
