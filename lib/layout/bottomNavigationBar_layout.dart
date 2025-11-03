import 'package:flutter/material.dart';
import 'package:loginsignup/constants/app_colors.dart';

class BottomNavigationbarLayout extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationbarLayout({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.score), label: 'Score'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
