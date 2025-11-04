import 'package:flutter/material.dart';
import 'package:loginsignup/constants/app_colors.dart';
import 'package:loginsignup/layout/drawer_layout.dart';
import 'package:loginsignup/provider/auth_provider.dart';
import 'package:loginsignup/screens/home_screen.dart';
import 'package:loginsignup/screens/score_screen.dart';
import 'package:loginsignup/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  double _appBarOpacity = 0.0;
  final List<String> _titles = ['Home', 'Score', 'Profile'];
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const ScoreScreen(),
      const ProfileScreen(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user?['user'];

    if (!authProvider.isLoggedIn) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.primaryGradient.colors.first.withOpacity(_appBarOpacity),
                AppColors.primaryGradient.colors.last.withOpacity(_appBarOpacity),
              ],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              _titles[_selectedIndex],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  backgroundImage: user['profileImg'] != null &&
                      user['profileImg'].toString().isNotEmpty
                      ? NetworkImage(user['profileImg'])
                      : const AssetImage('assets/default_avatar.png')
                  as ImageProvider,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerLayout(onItemSelected: _onTabTapped),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis == Axis.vertical) {
            final offset = notification.metrics.pixels;
            setState(() {
              _appBarOpacity = (offset / 100).clamp(0.0, 1.0);
            });
          }
          return false;
        },
        child: _pages[_selectedIndex],
      ),
    );
  }
}
