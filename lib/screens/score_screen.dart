import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginsignup/constants/app_colors.dart';
import 'package:loginsignup/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider?>(context, listen: false);
    final user = authProvider?.user?['user'] ?? {};
    final userName = user['fullName'] ?? 'User';

    final box = Hive.box('quiz_progress');
    final allScoresRaw = box.get('all_scores');
    final Map<String, dynamic> allScores =
    (allScoresRaw is Map) ? Map<String, dynamic>.from(allScoresRaw) : {};

    // Calculate total score
    // Calculate total score only from latest attempts
    int totalScore = 0;
    allScores.forEach((quizId, scoresListRaw) {
      final scoresList = (scoresListRaw is List) ? scoresListRaw : [];
      if (scoresList.isNotEmpty) {
        final latestData = (scoresList.last is Map)
            ? Map<String, dynamic>.from(scoresList.last)
            : {};
        final score = (latestData['score'] is num)
            ? (latestData['score'] as num).toInt()
            : 0;
        totalScore += score * 10; // same multiplier you use
      }
    });

    // int totalScore = 0;
    // allScores.forEach((quizId, scoresListRaw) {
    //   final scoresList = (scoresListRaw is List) ? scoresListRaw : [];
    //   for (var scoreItem in scoresList) {
    //     final data = (scoreItem is Map) ? Map<String, dynamic>.from(scoreItem) : {};
    //     final score = (data['score'] is num) ? (data['score'] as num).toInt() : 0;
    //     totalScore += score * 10;
    //   }
    // });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              children: [
                SizedBox(height: 50.h),

                // Score Circle
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 128.r,
                        backgroundColor: Colors.indigo.shade700,
                      ),
                      CircleAvatar(
                        radius: 100.r,
                        backgroundColor: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Score",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "$totalScore",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                Text(
                  "Congratulations!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Great job, $userName! You did it.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 30.h),

                // All Scores List
                Expanded(
                  child: allScores.isEmpty
                      ? Center(
                    child: Text(
                      "No scores yet.",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white70),
                    ),
                  )
                      : ListView.separated(
                    itemCount: allScores.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final entry = allScores.entries.elementAt(index);
                      final quizId = entry.key ?? 'Unknown Quiz';
                      final scoresListRaw = entry.value as List<dynamic>? ?? [];
                      final latestData = scoresListRaw.isNotEmpty
                          ? Map<String, dynamic>.from(scoresListRaw.last)
                          : {};
                      final score = (latestData['score'] is num)
                          ? (latestData['score'] as num).toInt()
                          : 0;
                      final total = (latestData['total'] is num)
                          ? (latestData['total'] as num).toInt()
                          : 0;
                      final date = DateTime.tryParse(
                          latestData['date']?.toString() ?? '') ??
                          DateTime.now();

                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A333333),
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quiz: $quizId",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "${date.day}/${date.month}/${date.year}",
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              "$score / $total",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Text("You Attempt:", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.grey),),
                            //     SizedBox(width: 3.w,),
                            //     Text(
                            //       "$score / $total",
                            //       style: TextStyle(
                            //         fontSize: 16.sp,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.indigo,
                            //       ),
                            //     ),
                            //   ],
                            //
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                // Share Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Share feature coming soon!"),
                        ),
                      );
                    },
                    icon: const Icon(Icons.share, color: Colors.white),
                    label: const Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 4,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Go to Home Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    },
                    icon: const Icon(Icons.home, color: Colors.white),
                    label: const Text(
                      "Go to Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 4,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
