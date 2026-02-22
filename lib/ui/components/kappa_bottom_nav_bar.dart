import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class FKappaBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  const FKappaBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
        activeColor: CupertinoColors.activeBlue,
      );
    }
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: items.map((item) {
        return NavigationDestination(
          icon: item.icon,
          label: item.label ?? '',
          selectedIcon: item.activeIcon,
        );
      }).toList(),
    );
  }
}
