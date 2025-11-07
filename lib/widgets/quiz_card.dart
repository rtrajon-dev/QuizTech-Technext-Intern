import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizCard extends StatelessWidget {
  final String title, questions, duration, rating, imageAsset;
  final bool bordered, disabled;

  const QuizCard({
    super.key,
    required this.title,
    required this.questions,
    required this.duration,
    required this.rating,
    required this.imageAsset,
    this.bordered = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.6 : 1.0,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 96.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: bordered ? Border.all(color: Colors.blue) : null,
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
                        imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          color: Colors.grey,
                          child: const Icon(Icons.image, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.h),
                        Row(children: [
                          const Icon(Icons.book, color: Colors.grey, size: 16),
                          SizedBox(width: 5.w),
                          Text(questions,
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.grey[700])),
                        ]),
                        Row(children: [
                          const Icon(Icons.timer, color: Colors.grey, size: 16),
                          SizedBox(width: 5.w),
                          Text(duration,
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.grey[700])),
                        ]),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 5.w),
                      Text(rating, style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 6.h,
            right: 6.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: disabled
                    ? Colors.orange.withOpacity(0.15)
                    : Colors.blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                disabled ? 'Ongoing' : (bordered ? 'Played' : ''),
                style: TextStyle(
                  color: disabled ? Colors.orange : Colors.blue,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
