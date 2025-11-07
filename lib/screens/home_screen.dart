import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loginsignup/constants/app_colors.dart';
import 'package:loginsignup/models/quiz_model.dart';
import 'package:loginsignup/data/dummy_data.dart';
import 'package:loginsignup/provider/auth_provider.dart';
import 'package:loginsignup/provider/quiz_provider.dart';
import 'package:loginsignup/provider/score_provider.dart';
import 'package:loginsignup/screens/details_screen.dart';
import 'package:loginsignup/screens/quiz_screen.dart';
import 'package:loginsignup/widgets/completed_quiz_card.dart';
import 'package:loginsignup/widgets/continue_quiz_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final box = Hive.box('quiz_progress');
  //
  // Map<String, dynamic>? lastQuiz;
  // String selectedCategoryId = 'popular';
  // String searchText = '';
  //
  // List<Map<String, dynamic>> allPlayedQuizzes = [];
  // Timer? _expiryCheckTimer;
  //
  // final ongoingQuizIds = Set<String>.from(
  //   Hive.box('quiz_progress')
  //       .get('all_quizzes', defaultValue: {})
  //       .keys
  //       .cast<String>(),
  // );
  //
  // String _getQuizImage(String quizId) {
  //   final quiz = quizSummaries.firstWhere(
  //         (q) => q.id == quizId,
  //     orElse: () => QuizSummary(
  //       id: '',
  //       categoryId: '',
  //       title: '',
  //       totalQuestions: 0,
  //       duration: '0',
  //       rating: '0',
  //       imageAsset: '',
  //     ),
  //   );
  //   return quiz.imageAsset.isNotEmpty ? quiz.imageAsset : 'assets/placeholder.png';
  // }
  //

  @override
  void initState(){
    super.initState();

    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);
    scoreProvider.loadScores();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.loadAllPlayedQuizzes();

    // //listen to an changes in 'quiz_progress' box
    // box.listenable().addListener(_refreshLastQuiz);
    //
    // // _loadLastQuiz();
    // _loadAllPlayedQuizzes();
    // _startPeriodicExpiryCheck();


  }

  // @override
  // void dispose(){
  //   _expiryCheckTimer?.cancel();
  //   super.dispose();
  // }
  //
  // void _refreshLastQuiz(){
  //   // _loadLastQuiz();
  //   _loadAllPlayedQuizzes();
  //   Provider.of<ScoreProvider>(context, listen: false).loadScores();
  // }
  //
  // void _startPeriodicExpiryCheck() {
  //   _expiryCheckTimer = Timer.periodic(const Duration(seconds: 5), (_) {
  //     _checkExpiredQuizzes();
  //   });
  // }
  //
  // Future<void> _checkExpiredQuizzes() async {
  //   final box = Hive.box('quiz_progress');
  //   final all = Map<String, dynamic>.from(box.get('all_quizzes', defaultValue: {}) as Map);
  //
  //   for (var entry in all.entries) {
  //     final quizId = entry.key;
  //     final savedData = Map<String, dynamic>.from(entry.value);
  //
  //     QuizDetail? quizDetail;
  //     try {
  //       quizDetail = quizDetails.firstWhere((q) => q.id == quizId);
  //     } catch (_) {
  //       continue; // Skip if quiz not found in quizDetails
  //     }
  //
  //     // Ensure startTime exists
  //     if (savedData['startTime'] == null) continue;
  //
  //     // Calculate expiry time
  //     final startTime = DateTime.parse(savedData['startTime']);
  //     final durationMinutes = int.tryParse(quizDetail.duration.replaceAll(RegExp(r'[^0-9]'), '')) ?? 30;
  //     final expiry = startTime.add(Duration(minutes: durationMinutes));
  //
  //     // Skip if not expired
  //     if (DateTime.now().isBefore(expiry)) continue;
  //
  //     // If already marked, skip
  //     if (savedData['scoreAdded'] == true) continue;
  //
  //     // Calculate score
  //     final selectedAnswers = Map<String, String>.from(savedData['selectedAnswers'] ?? {});
  //     int correctCount = 0;
  //     for (var q in quizDetail.questions) {
  //       if (selectedAnswers[q.id] == q.correctOptionId) correctCount++;
  //     }
  //
  //     // Save to all_scores
  //     final allScores = Map<String, dynamic>.from(box.get('all_scores', defaultValue: {}) as Map);
  //     final scoreData = {
  //       'score': correctCount,
  //       'attempted': selectedAnswers.length,
  //       'total': quizDetail.totalQuestions,
  //       'date': DateTime.now().toIso8601String(),
  //     };
  //     if (!allScores.containsKey(quizId)) allScores[quizId] = [];
  //     allScores[quizId].add(scoreData);
  //     await box.put('all_scores', allScores);
  //
  //     // Mark as score added
  //     savedData['scoreAdded'] = true;
  //     all[quizId] = savedData;
  //   }
  //
  //   await box.put('all_quizzes', all);
  //   setState(() {});
  // }
  //
  // void _loadAllPlayedQuizzes() {
  //   final box = Hive.box('quiz_progress');
  //   final allSaved = Map<String, dynamic>.from(
  //     box.get('all_quizzes', defaultValue: {}) as Map,
  //   );
  //
  //   List<Map<String, dynamic>> loadedQuizzes = [];
  //
  //   allSaved.forEach((quizId, savedData) async {
  //     try {
  //       final quizDetail = quizDetails.firstWhere((q) => q.id == quizId);
  //
  //       if (savedData['startTime'] == null) {
  //         savedData['startTime'] = DateTime.now().toIso8601String();
  //
  //         //save back to hive
  //         final all = Map<String, dynamic>.from(box.get('all_quizzes', defaultValue: {}) as Map);
  //         all[quizId] = savedData;
  //         await box.put('all_quizzes', all);
  //       }
  //
  //       // Check if quiz is unfinished
  //       if (savedData['currentQuestionIndex'] < quizDetail.questions.length) {
  //         loadedQuizzes.add({
  //           'quizDetail': quizDetail,
  //           'currentQuestionIndex': savedData['currentQuestionIndex'] ?? 0,
  //           'selectedAnswers': Map<String, String>.from(savedData['selectedAnswers'] ?? {}),
  //           'startTime' : savedData['startTime'],
  //         });
  //       }
  //     } catch (e) {
  //       debugPrint("Quiz not found for ID: $quizId");
  //     }
  //   });
  //
  //   setState(() {
  //     allPlayedQuizzes = loadedQuizzes;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final quizProvider = Provider.of<QuizProvider>(context);

    final user = authProvider.user?['user'];
    final userName = user?['fullName'] ?? 'User';
    // final filteredQuizzes = quizSummaries.where((q) => q.categoryId == selectedCategoryId && q.title.toLowerCase().contains(searchText.toLowerCase())).toList();
    //
    // final allScores = Map<String, dynamic>.from(box.get('all_scores', defaultValue: {}) as Map);

    // final playedQuizIds = allScores.keys.toSet();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: AppColors.primaryGradient),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello $userName",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 8.h),
                      Text("Let's test your knowledge",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.h),
                      TextField(
                        onChanged: (value) {
                          quizProvider.setSearchText(value);

                          // setState(() {
                            // searchText = value;

                          //   if (value.isEmpty) {
                          //     selectedCategoryId = 'popular';
                          //   } else {
                          //     QuizSummary? matchingQuiz;
                          //     try {
                          //       //find the first quiz that matches the search
                          //       matchingQuiz = quizSummaries.firstWhere(
                          //             (q) => q.title.toLowerCase().contains(value.toLowerCase()),
                          //       );
                          //     } catch (_) {
                          //       matchingQuiz = null;
                          //     }
                          //
                          //     if (matchingQuiz != null) {
                          //       selectedCategoryId = matchingQuiz.categoryId;
                          //     }
                          //   }
                          // });
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //quiz card
                Container(
                  width: double.infinity,
                  // height: 400.h,
                  // height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                    child: Column(
                      children: [
                        Container(
                          width: 48.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        SizedBox(height: 15.h),

                        // ======= CATEGORY TABS =======
                        SizedBox(
                          height: 40.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final cate = categories[index];
                              bool isActive = cate.id == quizProvider.selectedCategoryId;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quizProvider.setSelectedCategory(cate.id);
                                    // quizProvider = cate.id;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: _buildCategory(cate.title, isActive),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // ======= QUIZ CARDS =======

                        Column(
                          children: quizProvider.filteredQuizzes.map((q) {
                            final isOngoing = quizProvider.ongoingQuizIds.contains(q.id);
                            final isPlayed = quizProvider.playedQuizIds.contains(q.id);
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: isOngoing ? null :
                                      () {
                                    final quizDetail = quizDetails.firstWhere((d) => d.id == q.id);
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (_) => DetailsScreen(quizDetail: quizDetail),
                                    ));
                                    // Navigator.pushNamed(context, '/detail');
                                  },
                                  child: _buildQuizCard(
                                    title: q.title,
                                    questions: '${q.totalQuestions} Question',
                                    duration: q.duration,
                                    rating: q.rating,
                                    imageAsset: q.imageAsset,
                                    bordered: isPlayed,
                                    disabled: isOngoing,
                                  ),
                                ),
                                SizedBox(height: 15.h,),
                              ],
                            );
                          }).toList(),
                        )


                        // ValueListenableBuilder(
                        //     valueListenable: box.listenable(),
                        //     builder: (context, Box hiveBox, _) {
                        //       final allScores = Map<String, dynamic>.from(hiveBox.get('all_scores', defaultValue: {}) as Map);
                        //       final allQuizzes = Map<String, dynamic>.from(hiveBox.get('all_quizzes', defaultValue: {}) as Map);
                        //
                        //       final playedQuizIds = allScores.keys.toSet();
                        //       final ongoingQuizIds = allQuizzes.keys.toSet();
                        //
                        //       return SingleChildScrollView(
                        //         child: Column(
                        //           children: quizProvider.filteredQuizzes.map((q) {
                        //             final isOngoing = ongoingQuizIds.contains(q.id);
                        //             final isPlayed = playedQuizIds.contains(q.id);
                        //
                        //             return Column(
                        //               children: [
                        //                 GestureDetector(
                        //                   onTap: isOngoing ? null :
                        //                       () {
                        //                     final quizDetail = quizDetails.firstWhere((d) => d.id == q.id);
                        //                     Navigator.push(context, MaterialPageRoute(
                        //                       builder: (_) => DetailsScreen(quizDetail: quizDetail),
                        //                     ));
                        //                     // Navigator.pushNamed(context, '/detail');
                        //                   },
                        //                   child: _buildQuizCard(
                        //                     title: q.title,
                        //                     questions: '${q.totalQuestions} Question',
                        //                     duration: q.duration,
                        //                     rating: q.rating,
                        //                     imageAsset: q.imageAsset,
                        //                     bordered: isPlayed,
                        //                     disabled: isOngoing,
                        //                   ),
                        //                 ),
                        //                 SizedBox(height: 15.h,),
                        //               ],
                        //             );
                        //           }).toList(),
                        //         ),
                        //       );
                        //     }
                        // ),
                        // White container with completed quizzes
                        // SizedBox(height: 150.h),
                      ],
                    ),
                  ),
                ),
                //quiz history
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(0.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(12.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A333333),
                        // color: Colors.black,
                        offset: Offset(0, 0),
                        blurRadius: 50,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quiz History",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        // List of completed quizzes
                        Consumer<ScoreProvider>(
                          builder: (context, scoreProvider, _) {
                            final scores = scoreProvider.scores;

                            if (scores.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Motivational icon or image
                                      Icon(
                                        Icons.emoji_events_outlined,
                                        size: 36.sp,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(height: 8.h),
                                      // Motivational text
                                      Text(
                                        "Your first quiz awaits!\nChallenge yourself & start learning!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3, // makes it a bit more readable
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return Column(
                              children: [
                                for (var entry in scores)
                                  CompletedQuizCard(quizEntry: entry, quizSummaries: quizSummaries,),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                // SizedBox(height: 200.h,),
                if (quizProvider.allPlayedQuizzes.isNotEmpty)
                  Container (
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          // ======= CONTINUE QUIZ =======
          Positioned(
              bottom: 0.h,
              left: 10.w,
              right: 10.w,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: const [
                    BoxShadow(
                      // color: Color(0x37333333),
                      color: Colors.white,
                      offset: Offset(0, -20),
                      blurRadius: 55,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5.h,),

                    if(quizProvider.allPlayedQuizzes.isNotEmpty) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Continue Pending Quizzes",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: "Ubuntu",
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                    SizedBox(height: 15.h,),
                    _buildContinueQuizzesList(quizProvider),


                  ],
                ),
              )
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );

  }

  // ===== CATEGORY BUILDER =====
  Widget _buildCategory(String title, bool active) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: active ? Colors.blue : Colors.grey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Ubuntu",
          ),
        ),
        Container(
          width: 48.w,
          height: 2.h,
          color: active ? Colors.blue : Colors.white,
        ),
      ],
    );
  }

  // ===== QUIZ CARD BUILDER =====
  Widget _buildQuizCard({required String title, required String questions, required String duration, required String rating, required String imageAsset, bool bordered = false, bool disabled = false}) {
    return Opacity(
      opacity: disabled ? 0.6 : 1.0,
      child: Stack(
        children: [
          // Main Card
          Container(
            width: double.infinity,
            height: 96.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: bordered ? Border.all(color: Colors.blue,) : null,
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
                      color: Colors.grey[200], // fallback color while loading
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        imageAsset,
                        fit: BoxFit.cover, // ensures image fills the container
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: const Icon(Icons.image, color: Colors.white),
                          );
                        },
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

          //Badge (in the top-right corner)
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

  // ===== CONTINUE QUIZ CARD =====
  // Widget _buildContinueQuizCard(Map<String, dynamic> quizData) {
  //   final QuizDetail quizDetail = quizData['quizDetail'];
  //   final int currentQuestionIndex = quizData['currentQuestionIndex'];
  //   final Map<String, String> selectedAnswers = Map<String, String>.from(quizData['selectedAnswers']);
  //
  //   // Convert duration text (e.g. "8 min") → minutes
  //   final durationMinutes =
  //       int.tryParse(quizDetail.duration.replaceAll(RegExp(r'[^0-9]'), '')) ?? 30;
  //
  //   // final quizDuration = Duration(minutes: durationMinutes);
  //   final startTime = DateTime.tryParse(quizData['startTime'] ?? '') ?? DateTime.now();
  //   final endTime = startTime.add(Duration(minutes: durationMinutes));
  //
  //   // bool isTimeOver = false;
  //   Duration remaining = endTime.difference(DateTime.now());
  //   bool isTimeOver = remaining.inSeconds <= 0;
  //
  //   return StatefulBuilder(
  //     builder: (BuildContext context, void Function(void Function()) setLocalState) {
  //
  //       return StreamBuilder(
  //           stream: Stream.periodic(const Duration(seconds: 1), (_) {
  //             final now = DateTime.now();
  //             return endTime.difference(now);
  //           }),
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               remaining = snapshot.data!;
  //               if (remaining.isNegative && !isTimeOver) {
  //                 isTimeOver = true;
  //
  //                 Future.microtask(() async {
  //                   int correctCount = 0;
  //                   for (var q in quizDetail.questions) {
  //                     if (selectedAnswers[q.id] == q.correctOptionId){
  //                       correctCount++;
  //                     }
  //                   }
  //
  //                   //store score in Hive
  //                   final allScores = Map<String, dynamic>.from(box.get('all_scores', defaultValue: {}) as Map);
  //
  //                   final scoreData = {
  //                     'score': correctCount,
  //                     'attempted': selectedAnswers.length,
  //                     'total': quizDetail.totalQuestions,
  //                     'date': DateTime.now().toIso8601String(),
  //                   };
  //
  //                   if (!allScores.containsKey(quizDetail.id)) {
  //                     allScores[quizDetail.id] = [];
  //                   }
  //                   allScores[quizDetail.id].add(scoreData);
  //                   await box.put('all_scores', allScores);
  //
  //
  //
  //                   // Remove from continue list
  //                   final allQuizzes = Map<String, dynamic>.from(box.get('all_quizzes', defaultValue: {}) as Map);
  //                   // allQuizzes.remove(quizDetail.id);
  //                   final quizDataHive = allQuizzes[quizDetail.id];
  //                   if (quizDataHive != null) {
  //                     quizDataHive['scoreAdded'] = true;
  //                     allQuizzes[quizDetail.id] = quizDataHive;
  //                     await box.put('all_quizzes', allQuizzes);
  //                   }
  //
  //                   if (context.mounted) {
  //                     // ScaffoldMessenger.of(context).showSnackBar(
  //                     //   const SnackBar(content: Text("Time Out! Score Submitted")),
  //                     // );
  //                     setState(() {
  //
  //                     });
  //                   }
  //                 });
  //               }
  //
  //             }
  //
  //             final minutes = remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
  //             final seconds = remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
  //
  //             return Container(
  //               width: 270.w,
  //               margin: EdgeInsets.only(bottom: 10.h),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 border: Border.all(
  //                   color: Colors.blue,
  //                   width: 1,
  //                 ),
  //                 borderRadius: BorderRadius.circular(12.r),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black12,
  //                     blurRadius: 4,
  //                     offset: const Offset(0, 2),
  //                   ),
  //                 ],
  //               ),
  //               child: Padding(
  //                 padding: EdgeInsets.all(10.w),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     // Header section
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Container(
  //                           width: 80.w,
  //                           height: 80.h,
  //                           decoration: BoxDecoration(
  //                             color: Colors.grey[300],
  //                             borderRadius: BorderRadius.circular(8.r),
  //                           ),
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(8.r),
  //                             child: Image.asset(
  //                               _getQuizImage(quizDetail.id), // helper function
  //                               fit: BoxFit.cover,
  //                               errorBuilder: (context, error, stackTrace) {
  //                                 return Container(
  //                                   color: Colors.grey,
  //                                   child: const Icon(Icons.quiz, size: 36, color: Colors.white),
  //                                 );
  //                               },
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(width: 10.w),
  //                         Expanded(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 quizDetail.title,
  //                                 style: TextStyle(
  //                                   fontSize: 16.sp,
  //                                   color: Colors.blue,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                                 maxLines: 1,
  //                                 overflow: TextOverflow.ellipsis,
  //                               ),
  //                               SizedBox(height: 6.h),
  //                               Row(
  //                                 children: [
  //                                   const Icon(Icons.book, size: 14, color: Colors.grey),
  //                                   SizedBox(width: 4.w),
  //                                   Text(
  //                                     "${selectedAnswers.length}/${quizDetail.totalQuestions} Questions",
  //                                     style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
  //                                   ),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   const Icon(Icons.timer, size: 14, color: Colors.grey),
  //                                   SizedBox(width: 4.w),
  //                                   Text(
  //                                     isTimeOver ? "00:00" : "$minutes:$seconds",
  //                                     style: TextStyle(
  //                                       color: isTimeOver ? Colors.redAccent : Colors.red[300],
  //                                       fontSize: 13.sp,
  //                                       fontWeight: FontWeight.w500,
  //                                       fontFamily: "Ubuntu",
  //                                     ),
  //                                   )
  //
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //
  //                         GestureDetector(
  //                           onTap: () async {
  //                             final box = Hive.box('quiz_progress');
  //                             final all = Map<String, dynamic>.from(box.get('all_quizzes', defaultValue: {}) as Map);
  //                             final quizData = all[quizDetail.id];
  //                             if (quizData == null) return;
  //
  //                             final startTime = DateTime.tryParse(quizData['startTime'] ?? '') ?? DateTime.now();
  //                             final durationMinutes = int.tryParse(quizDetail.duration.replaceAll(RegExp(r'[^0-9]'), '')) ?? 30;
  //                             final expiry = startTime.add(Duration(minutes: durationMinutes));
  //                             final isExpired = DateTime.now().isAfter(expiry);
  //
  //                             // If not expired → just delete (no score)
  //                             if (!isExpired) {
  //                               all.remove(quizDetail.id);
  //                               await box.put('all_quizzes', all);
  //
  //                               if (context.mounted) {
  //                                 ScaffoldMessenger.of(context).showSnackBar(
  //                                   SnackBar(content: Text("${quizDetail.title} removed before time over (no score added)")),
  //                                 );
  //                               }
  //                             } else {
  //                               // Expired → score already stored by background checker
  //                               all.remove(quizDetail.id);
  //                               await box.put('all_quizzes', all);
  //                               if (context.mounted) {
  //                                 ScaffoldMessenger.of(context).showSnackBar(
  //                                   SnackBar(content: Text("${quizDetail.title} removed (score was already stored)")),
  //                                 );
  //                               }
  //                             }
  //                             setState(() {});
  //                           },
  //
  //                           child: const Icon(Icons.delete, color: Colors.red),
  //                         ),
  //
  //                       ],
  //                     ),
  //
  //                     // SizedBox(height: 3.h),
  //
  //                     // Continue button
  //                     SizedBox(
  //                       width: double.infinity,
  //                       height: 36.h,
  //                       child: ElevatedButton(
  //                         onPressed: isTimeOver
  //                             ? null
  //                             : () {
  //                           Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                               builder: (_) => QuizScreen(quizDetail: quizDetail),
  //                             ),
  //                           ).then((_) {
  //                             _loadAllPlayedQuizzes(); // refresh after returning
  //                           });
  //                         },
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: isTimeOver ? Colors.redAccent : Colors.black,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8.r),
  //                           ),
  //                         ),
  //                         child: Text(
  //                           isTimeOver ? "Time Over! Score Submitted" : "Continue Quiz",
  //                           style: TextStyle(
  //                             color: isTimeOver? Colors.red : Colors.white,
  //                             fontSize: 14.sp,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }
  //       );
  //
  //
  //     },
  //   );
  // }


  Widget _buildContinueQuizzesList(QuizProvider quizProvider) {
    if (quizProvider.allPlayedQuizzes.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 150.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
          final quizData = quizProvider.allPlayedQuizzes[index];
          final quizDetail = quizData['quizDetail'] as QuizDetail;
          return ContinueQuizCard(
            quizData: quizData,
            quizImage: quizProvider.getQuizImage(quizDetail.id),
          );
          },
          separatorBuilder: (_, _) => SizedBox(width: 12.w,),
          itemCount: quizProvider.allPlayedQuizzes.length,
      ),
    );
  }

  // Widget _buildContinueQuizzesList(QuizProvider quizProvider) {
  //   // if (allPlayedQuizzes.isEmpty) {
  //   //   //do nothing
  //   //   return const SizedBox();
  //   // }
  //   if (quizProvider.allPlayedQuizzes.isEmpty) {
  //     return const SizedBox();
  //   }
  //
  //   return SizedBox(
  //     height: 150.h, // Adjust as needed
  //     child: ListView.separated(
  //       scrollDirection: Axis.horizontal,
  //       separatorBuilder: (_, __) => SizedBox(width: 12.w),
  //       itemCount: quizProvider.allPlayedQuizzes.length,
  //       itemBuilder: (context, index) {
  //         final quizData = quizProvider.allPlayedQuizzes.length;
  //         final quizDetail = quizData['quizDetail'];
  //         // final quizDetail = quizData['quizDetail'] as QuizDetail;
  //         // final quizDetail = quizData['quizDetail'] as QuizDetail;
  //         // return _buildContinueQuizCard(quizData);
  //         return ContinueQuizCard(
  //           quizData: quizData,
  //           quizImage: quizProvider.getQuizImage(quizDetail.id),
  //
  //         );
  //       },
  //     ),
  //   );
  // }


}