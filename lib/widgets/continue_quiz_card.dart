import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:loginsignup/models/quiz_model.dart';
import 'package:loginsignup/provider/quiz_provider.dart';
import 'package:loginsignup/screens/quiz_screen.dart';


class ContinueQuizCard extends StatefulWidget {
  final Map<String, dynamic> quizData;
  final String quizImage;
  final VoidCallback onRefresh;

  const ContinueQuizCard({
    super.key,
    required this.quizData,
    required this.quizImage,
    required this.onRefresh,
  });

  @override
  State<ContinueQuizCard> createState() => _ContinueQuizCardState();
}

class _ContinueQuizCardState extends State<ContinueQuizCard> {
  late QuizDetail quizDetail;
  late Duration remaining;
  bool isTimeOver = false;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
  }

  void _calculateRemainingTime() {
    quizDetail = widget.quizData['quizDetail'] as QuizDetail;
    final startTime = DateTime.tryParse(widget.quizData['startTime'] ?? '') ?? DateTime.now();
    final durationMinutes =
        int.tryParse(quizDetail.duration.replaceAll(RegExp(r'[^0-9]'), '')) ?? 30;
    final endTime = startTime.add(Duration(minutes: durationMinutes));
    remaining = endTime.difference(DateTime.now());
    isTimeOver = remaining.inSeconds <= 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedAnswers = Map<String, String>.from(widget.quizData['selectedAnswers']);
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    return StreamBuilder<Duration>(
      stream: Stream.periodic(const Duration(seconds: 1), (_) {
        _calculateRemainingTime();
        return remaining;
      }),
      builder: (context, snapshot) {
        try {
          if (remaining.isNegative && !isTimeOver) {
            isTimeOver = true;
            Future.microtask(() async {
              try {
                await quizProvider.submitAutoScore(widget.quizData);
                if (mounted) setState(() {});
                widget.onRefresh();
              } catch (e) {
                debugPrint('Error auto-submitting score: $e');
              }
            });
          }
        } catch (e) {
          debugPrint('Timer update failed: $e');
        }


        final minutes = remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
        final seconds = remaining.inSeconds.remainder(60).toString().padLeft(2, '0');

        return Container(
          width: 270.w,
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Image + Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //quiz image
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(
                          widget.quizImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, _, __) => Container(
                            color: Colors.grey,
                            child: const Icon(Icons.quiz,
                                size: 36, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    //Quiz Title, question count, timer
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quizDetail.title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              const Icon(Icons.book, size: 14, color: Colors.grey),
                              SizedBox(width: 4.w),
                              Text(
                                "${selectedAnswers.length}/${quizDetail.totalQuestions} Questions",
                                style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timer, size: 14, color: Colors.grey),
                              SizedBox(width: 4.w),
                              Text(
                                isTimeOver ? "00:00" : "$minutes:$seconds",
                                style: TextStyle(
                                  color: isTimeOver ? Colors.redAccent : Colors.red[300],
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Ubuntu",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Delete button
                    GestureDetector(
                      onTap: () async {
                        try {
                          await quizProvider.removeQuiz(quizDetail.id);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "${quizDetail.title} removed successfully")),
                            );
                          }
                          widget.onRefresh();
                        } catch (e) {
                          debugPrint("Error removing quiz: $e");
                        }
                      },
                      child: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
                //Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 36.h,
                  child: ElevatedButton(
                    onPressed: isTimeOver
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(quizDetail: quizDetail),
                        ),
                      ).then((_) => widget.onRefresh());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isTimeOver ? Colors.redAccent : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      isTimeOver ? "Time Over! Score Submitted" : "Continue Quiz",
                      style: TextStyle(
                        color: isTimeOver ? Colors.red : Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
