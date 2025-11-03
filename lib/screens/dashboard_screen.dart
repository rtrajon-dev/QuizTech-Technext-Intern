import 'package:flutter/material.dart';
import 'package:loginsignup/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {



  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () async {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                await authProvider.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text("Welcome"),
      ),
    );
  }
}
