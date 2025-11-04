import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginsignup/models/quiz_model.dart';

class CompletedQuizCard extends StatelessWidget {
  final MapEntry<String, dynamic> quizEntry;
  final List<QuizSummary> quizSummaries;

  const CompletedQuizCard({
    super.key,
    required this.quizEntry,
    required this.quizSummaries,
  });

  @override
  Widget build(BuildContext context) {
    final quizId = quizEntry.key;
    final scoresListRaw = quizEntry.value as List<dynamic>? ?? [];
    final latestData = scoresListRaw.isNotEmpty
        ? Map<String, dynamic>.from(scoresListRaw.last)
        : {};
    final score = (latestData['score'] is num)
        ? (latestData['score'] as num).toInt()
        : 0;
    final total = (latestData['total'] is num)
        ? (latestData['total'] as num).toInt()
        : 0;
    final date = DateTime.tryParse(latestData['date']?.toString() ?? '') ??
        DateTime.now();

    final quizSummary = quizSummaries.firstWhere(
          (q) => q.id == quizId,
      orElse: () => QuizSummary(id: quizId, categoryId: '', title: '', totalQuestions: total, duration: '', rating: '0', imageAsset: ''),
    );

    return Container(
      width: double.infinity,
      height: 96.h,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A333333),
            offset: Offset(10, 24),
            blurRadius: 54,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            // Quiz Image
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  quizSummary.imageAsset.isNotEmpty
                      ? quizSummary.imageAsset
                      : 'assets/placeholder.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // Quiz Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quizSummary.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      const Icon(Icons.date_range, color: Colors.grey, size: 16),
                      SizedBox(width: 5.w),
                      Text(
                        "${date.day}/${date.month}/${date.year}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Score Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                "$score/$total",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
