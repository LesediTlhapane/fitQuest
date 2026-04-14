// TODO Implement this library.import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ColorfulCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ColorfulCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withValues(alpha: 0.2),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
      ),
    );
  }
}
