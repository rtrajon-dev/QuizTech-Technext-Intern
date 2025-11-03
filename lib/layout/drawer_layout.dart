import 'package:flutter/material.dart';
import 'package:loginsignup/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:loginsignup/provider/auth_provider.dart';

class DrawerLayout extends StatefulWidget {
  final Function(int) onItemSelected; // <-- Callback to switch tab

  const DrawerLayout({super.key, required this.onItemSelected});

  @override
  State<DrawerLayout> createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  bool soundOn = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user?['user'];
    final userName = user?['fullName'] ?? 'user';
    final userProfile = user?['profileImg'];


    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage:
                  user['profileImg'] != null &&
                      user['profileImg']
                          .toString()
                          .isNotEmpty
                      ? NetworkImage(user['profileImg'])
                      : const AssetImage(
                      'assets/default_avatar.png')
                  as ImageProvider,
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello $userName",
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),

          _drawerItem(
            icon: Icons.home_outlined,
            title: "Home",
            onTap: () {
              Navigator.pop(context);
              widget.onItemSelected(0); // Switch to Home tab
            },
          ),

          _drawerItem(
            icon: Icons.scoreboard_outlined,
            title: "Score",
            onTap: () {
              Navigator.pop(context);
              widget.onItemSelected(1); // Switch to Score tab
            },
          ),

          _drawerItem(
            icon: Icons.person_outline,
            title: "Profile",
            onTap: () {
              Navigator.pop(context);
              widget.onItemSelected(2); // Switch to Profile tab
            },
          ),

          const Divider(),

          SwitchListTile(
            value: soundOn,
            title: const Text("Sound"),
            secondary: const Icon(Icons.volume_up_outlined),
            onChanged: (value) {
              setState(() => soundOn = value);
            },
          ),

          const Divider(),

          _drawerItem(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              Navigator.pop(context);
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
