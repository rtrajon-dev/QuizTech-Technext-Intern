import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loginsignup/layout/main_layout.dart';
import 'package:loginsignup/provider/auth_provider.dart';
import 'package:loginsignup/provider/quiz_provider.dart';
import 'package:loginsignup/provider/score_provider.dart';
import 'package:loginsignup/provider/sound_provider.dart';
import 'package:loginsignup/screens/dashboard_screen.dart';
import 'package:loginsignup/screens/details_screen.dart';
import 'package:loginsignup/screens/home_screen.dart';
import 'package:loginsignup/screens/login_screen.dart';
import 'package:loginsignup/screens/onboarding_screen.dart';
import 'package:loginsignup/screens/profile_screen.dart';
import 'package:loginsignup/screens/quiz_screen.dart';
import 'package:loginsignup/screens/score_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('quiz_progress');

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ScoreProvider()..loadScores()),
          ChangeNotifierProvider(create: (_) => SoundProvider()),

          ChangeNotifierProvider(create: (_) => QuizProvider()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context, child) => const MyApp(),
        ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // get quizDetail => null;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Show a loading screen until token is loaded
    if (!authProvider.isInitialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Tech',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/main' : (context) => const MainLayout(),
        // '/quiz' : (context) =>  QuizScreen(quizDetail: quizDetail),
        // // '/detail' : (context) => DetailsScreen(quizDetail: quizDetail),
        // '/detail' : (context) => DetailsScreen(quizDetail: quizDetail),
        '/home' : (context) => const HomeScreen(),
        // '/score' : (context) => const ScoreScreen(),

      },
      home: authProvider.isLoggedIn ? const MainLayout() : const LoginScreen(),
    );
  }
}
