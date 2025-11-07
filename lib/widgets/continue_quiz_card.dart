// lib/widgets/continue_quiz_card.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginsignup/provider/score_provider.dart';
import 'package:provider/provider.dart';
import 'package:loginsignup/models/quiz_model.dart';
import 'package:loginsignup/provider/quiz_provider.dart';
import 'package:loginsignup/screens/quiz_screen.dart';

class ContinueQuizCard extends StatefulWidget {
  final Map<String, dynamic> quizData;
  final String quizImage;

  const ContinueQuizCard({
    super.key,
    required this.quizData,
    required this.quizImage,
  });

  @override
  State<ContinueQuizCard> createState() => _ContinueQuizCardState();
}

class _ContinueQuizCardState extends State<ContinueQuizCard> {
  // This timer is ONLY for updating the UI's countdown text.
  // It does not contain any submission logic.
  Timer? _countdownTimer;
  Duration _remaining = Duration.zero;
  bool _isTimeOver = false;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    // Set up a timer that fires every second to update the UI.
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime();
    });
  }

  @override
  void dispose() {
    // Clean up the timer when the widget is removed.
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _calculateRemainingTime() {
    final quizDetail = widget.quizData['quizDetail'] as QuizDetail;
    final startTimeString = widget.quizData['startTime'];

    if (startTimeString == null) {
      if (mounted) setState(() => _isTimeOver = true);
      return;
    }

    final startTime = DateTime.tryParse(startTimeString) ?? DateTime.now();
    final durationMinutes =
        int.tryParse(quizDetail.duration.replaceAll(RegExp(r'[^0-9]'), '')) ?? 30;
    final endTime = startTime.add(Duration(minutes: durationMinutes));

    // Calculate the new remaining time and update the state.
    final newRemaining = endTime.difference(DateTime.now());
    if (mounted) {
      setState(() {
        _remaining = newRemaining;
        _isTimeOver = _remaining.isNegative;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);
    final quizDetail = widget.quizData['quizDetail'] as QuizDetail;
    final selectedAnswers = Map<String, String>.from(widget.quizData['selectedAnswers']);

    final minutes = _remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = _remaining.inSeconds.remainder(60).toString().padLeft(2, '0');

    // The text on the button should reflect whether the time is over.
    // The QuizProvider in the background handles the actual score submission.
    final buttonText = _isTimeOver ? "Time Over! Score Submitted" : "Continue Quiz";

    return Container(
      width: 270.w,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
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
                // Quiz Image
                SizedBox(
                  width: 80.w,
                  height: 80.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(widget.quizImage, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 10.w),
                // Quiz Title, question count, timer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quizDetail.title,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Row(children: [
                        const Icon(Icons.book, size: 14, color: Colors.grey),
                        SizedBox(width: 4.w),
                        Text(
                            "${selectedAnswers.length}/${quizDetail.totalQuestions} Questions",
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.grey[600])),
                      ]),
                      Row(children: [
                        const Icon(Icons.timer, size: 14, color: Colors.grey),
                        SizedBox(width: 4.w),
                        Text(
                          _isTimeOver ? "00:00" : "$minutes:$seconds",
                          style: TextStyle(
                              color:
                              _isTimeOver ? Colors.redAccent : Colors.red[300],
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                    ],
                  ),
                ),
                // Delete button
                GestureDetector(
                  onTap: () async {
                    // Ask the provider to remove the quiz.
                    // The UI will update automatically via the provider's listeners.
                    await quizProvider.removeQuiz(quizDetail.id);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${quizDetail.title} removed.")));
                    }
                  },
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: ElevatedButton(
                // The button is disabled if time is over.
                onPressed: _isTimeOver
                    ? null
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => QuizScreen(quizDetail: quizDetail)),
                  ).then((_) {
                    quizProvider.loadAllPlayedQuizzes();
                    scoreProvider.loadScores();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isTimeOver ? Colors.grey[400] : Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(color: _isTimeOver? Colors.redAccent : Colors.white, fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
