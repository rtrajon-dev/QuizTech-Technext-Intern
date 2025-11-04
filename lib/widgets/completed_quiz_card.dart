import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedQuizCard extends StatelessWidget {
  final MapEntry<String, dynamic> quizEntry;

  const CompletedQuizCard({super.key, required this.quizEntry});

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

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
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
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
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
        ],
      ),
    );
  }
}
