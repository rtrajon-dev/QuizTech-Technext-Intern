import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loginsignup/constants/app_colors.dart';
import 'package:loginsignup/data/dummy_data.dart';
import 'package:loginsignup/models/quiz_model.dart';
import 'package:loginsignup/provider/auth_provider.dart';
import 'package:loginsignup/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'quiz_screen.dart';


class DetailsScreen extends StatefulWidget {
  final QuizDetail quizDetail;
  const DetailsScreen({super.key, required this.quizDetail});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user?['user'];
    final quiz = widget.quizDetail;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
        title: Text(
          "Quiz Details",
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              radius: 14,
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
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 120.h),

              // Quiz Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quiz title + subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz.title,
                          // "UI UX Design Quiz",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "get 100 points",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 5.w),
                        Text(
                          "4.8",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15.h),

              // White section
              Container(
                width: double.infinity,
                height: 729.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Indicator
                      Center(
                        child: Container(
                          width: 48.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),

                      // Explanation section
                      Text(
                        "Brief Explanation about this quiz",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // Quiz details
                      Column(
                        children: [
                          _buildInfoItem(
                            "${quiz.totalQuestions} questions",
                            "10 points for a correct answer",
                            Icons.help_outline, // Questions icon
                          ),
                          SizedBox(height: 15.h),

                          _buildInfoItem(
                            "${quiz.duration}",
                            "Total duration of the quiz",
                            Icons.timer_outlined, // Time icon
                          ),
                          SizedBox(height: 15.h),

                          _buildInfoItem(
                            "Win ${quiz.pointsPerCorrect} stars",
                            "Answer all questions correctly",
                            Icons.star_border, // Star icon
                          ),
                        ],
                      ),


                      SizedBox(height: 30.h),

                      // Rules section
                      Text(
                        "Please read the text below carefully so you can understand it",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: quiz.rules.map((rule) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(radius: 3.r, backgroundColor: Colors.black),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    rule,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 40.h),

                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: FutureBuilder(
                          future: Hive.openBox('quiz_progress'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            final box = snapshot.data!;
                            final allScoresRaw = box.get('all_scores');
                            final Map<String, dynamic> allScores =
                            (allScoresRaw is Map) ? Map<String, dynamic>.from(allScoresRaw) : {};

                            final quizId = widget.quizDetail.id;
                            final hasPlayed = allScores.containsKey(quizId);

                            final String buttonText = hasPlayed ? "Play Again" : "Start Quiz";
                            final Color buttonColor = hasPlayed ? Colors.orange : Colors.blue;

                            return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => QuizScreen(quizDetail: widget.quizDetail),
                                  ),
                                ).then((_) {
                                  Navigator.pop(context);
                                  setState(() {}); // refresh button state after returning
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                buttonText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget for explanation info rows
  Widget _buildInfoItem(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: Colors.black,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }



}