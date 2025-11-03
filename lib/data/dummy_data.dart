import 'package:loginsignup/models/quiz_model.dart';

final List<Category> categories = [
  Category(id: 'popular', title: 'Popular', isActive: true), //default active
  Category(id: 'science', title: 'Science', isActive: false),
  Category(id: 'math', title: 'Mathematics', isActive: false),
  Category(id: 'computer', title: 'Computer', isActive: false),
];

// Summaries used in HomeScreen cards
final List<QuizSummary> quizSummaries = [
  // Popular Category
  QuizSummary(
    id: 'pop_quiz1',
    categoryId: 'popular',
    title: 'General Knowledge',
    totalQuestions: 8,
    duration: '8 min',
    rating: '4.9',
    imageAsset: 'assets/popular1.png',
  ),
  QuizSummary(
    id: 'pop_quiz2',
    categoryId: 'popular',
    title: 'Famous Personalities',
    totalQuestions: 10,
    duration: '10 min',
    rating: '4.7',
    imageAsset: 'assets/popular2.png',
  ),
  QuizSummary(
    id: 'pop_quiz3',
    categoryId: 'popular',
    title: 'World History',
    totalQuestions: 15,
    duration: '15 min',
    rating: '4.8',
    imageAsset: 'assets/popular3.png',
  ),

  // Science Category
  QuizSummary(
    id: 'sci_quiz1',
    categoryId: 'science',
    title: 'Physics Basics',
    totalQuestions: 8,
    duration: '8 min',
    rating: '4.6',
    imageAsset: 'assets/physics.png',
  ),
  QuizSummary(
    id: 'sci_quiz2',
    categoryId: 'science',
    title: 'Chemistry Core',
    totalQuestions: 10,
    duration: '10 min',
    rating: '4.7',
    imageAsset: 'assets/chemistry.png',
  ),
  QuizSummary(
    id: 'sci_quiz3',
    categoryId: 'science',
    title: 'Biology Essentials',
    totalQuestions: 15,
    duration: '15 min',
    rating: '4.8',
    imageAsset: 'assets/biology.png',
  ),

  // Mathematics Category
  QuizSummary(
    id: 'math_quiz1',
    categoryId: 'math',
    title: 'Algebra',
    totalQuestions: 8,
    duration: '8 min',
    rating: '4.6',
    imageAsset: 'assets/algebra.png',
  ),
  QuizSummary(
    id: 'math_quiz2',
    categoryId: 'math',
    title: 'Geometry',
    totalQuestions: 10,
    duration: '10 min',
    rating: '4.7',
    imageAsset: 'assets/geometry.png',
  ),
  QuizSummary(
    id: 'math_quiz3',
    categoryId: 'math',
    title: 'Calculus',
    totalQuestions: 15,
    duration: '15 min',
    rating: '4.8',
    imageAsset: 'assets/calculus.png',
  ),

  // Computer Category
  QuizSummary(
    id: 'uiux',
    categoryId: 'computer',
    title: 'UI UX Design',
    totalQuestions: 8,
    duration: '8 min',
    rating: '4.8',
    imageAsset: 'assets/uiux.png',
    bordered: true,
  ),
  QuizSummary(
    id: 'graphic',
    categoryId: 'computer',
    title: 'Graphic Design',
    totalQuestions: 10,
    duration: '10 min',
    rating: '4.7',
    imageAsset: 'assets/graphic.png',
  ),
];
  // Add other quizzes for other categories...

// Full details used in DetailsScreen / QuizScreen
final List<QuizDetail> quizDetails = [

  // Popular Quizzes

// pop_quiz1: General Knowledge (8 questions)
  QuizDetail(
    id: 'pop_quiz1',
    title: 'General Knowledge Quiz',
    description: 'Test your general knowledge across a variety of topics.',
    pointsPerCorrect: 10,
    totalQuestions: 8,
    duration: '8 min',
    rules: [
      '10 points per correct answer',
      'No negative marks',
      'You can bookmark questions',
    ],
    questions: [
      Question(
        id: 'pq1',
        text: 'What is the capital of France?',
        options: [
          Option(id: 'A', label: 'A', text: 'Paris'),
          Option(id: 'B', label: 'B', text: 'London'),
          Option(id: 'C', label: 'C', text: 'Berlin'),
          Option(id: 'D', label: 'D', text: 'Madrid'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'pq2',
        text: 'Which planet is known as the Red Planet?',
        options: [
          Option(id: 'A', label: 'A', text: 'Earth'),
          Option(id: 'B', label: 'B', text: 'Mars'),
          Option(id: 'C', label: 'C', text: 'Jupiter'),
          Option(id: 'D', label: 'D', text: 'Venus'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'pq3',
        text: 'What is the largest ocean on Earth?',
        options: [
          Option(id: 'A', label: 'A', text: 'Atlantic Ocean'),
          Option(id: 'B', label: 'B', text: 'Indian Ocean'),
          Option(id: 'C', label: 'C', text: 'Pacific Ocean'),
          Option(id: 'D', label: 'D', text: 'Arctic Ocean'),
        ],
        correctOptionId: 'C',
      ),
      Question(
        id: 'pq4',
        text: 'Who wrote the play "Romeo and Juliet"?',
        options: [
          Option(id: 'A', label: 'A', text: 'William Shakespeare'),
          Option(id: 'B', label: 'B', text: 'Charles Dickens'),
          Option(id: 'C', label: 'C', text: 'Jane Austen'),
          Option(id: 'D', label: 'D', text: 'Mark Twain'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'pq5',
        text: 'Which country is famous for the Taj Mahal?',
        options: [
          Option(id: 'A', label: 'A', text: 'India'),
          Option(id: 'B', label: 'B', text: 'Pakistan'),
          Option(id: 'C', label: 'C', text: 'Bangladesh'),
          Option(id: 'D', label: 'D', text: 'Nepal'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'pq6',
        text: 'Which is the smallest continent by land area?',
        options: [
          Option(id: 'A', label: 'A', text: 'Europe'),
          Option(id: 'B', label: 'B', text: 'Australia'),
          Option(id: 'C', label: 'C', text: 'Antarctica'),
          Option(id: 'D', label: 'D', text: 'South America'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'pq7',
        text: 'How many colors are there in a rainbow?',
        options: [
          Option(id: 'A', label: 'A', text: '5'),
          Option(id: 'B', label: 'B', text: '6'),
          Option(id: 'C', label: 'C', text: '7'),
          Option(id: 'D', label: 'D', text: '8'),
        ],
        correctOptionId: 'C',
      ),
      Question(
        id: 'pq8',
        text: 'Which gas do plants absorb from the atmosphere?',
        options: [
          Option(id: 'A', label: 'A', text: 'Oxygen'),
          Option(id: 'B', label: 'B', text: 'Nitrogen'),
          Option(id: 'C', label: 'C', text: 'Carbon Dioxide'),
          Option(id: 'D', label: 'D', text: 'Hydrogen'),
        ],
        correctOptionId: 'C',
      ),
    ],
  ),

// pop_quiz2: Famous Personalities (10 questions)
  QuizDetail(
    id: 'pop_quiz2',
    title: 'Famous Personalities Quiz',
    description: 'Identify well-known figures from history, sports, and entertainment.',
    pointsPerCorrect: 10,
    totalQuestions: 10,
    duration: '10 min',
    rules: ['10 points per correct answer', 'No negative marks'],
    questions: [
      Question(
        id: 'fpq1',
        text: 'Who is known as the Father of Computers?',
        options: [
          Option(id: 'A', label: 'A', text: 'Alan Turing'),
          Option(id: 'B', label: 'B', text: 'Charles Babbage'),
          Option(id: 'C', label: 'C', text: 'Bill Gates'),
          Option(id: 'D', label: 'D', text: 'Steve Jobs'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'fpq2',
        text: 'Who discovered penicillin?',
        options: [
          Option(id: 'A', label: 'A', text: 'Marie Curie'),
          Option(id: 'B', label: 'B', text: 'Alexander Fleming'),
          Option(id: 'C', label: 'C', text: 'Isaac Newton'),
          Option(id: 'D', label: 'D', text: 'Albert Einstein'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'fpq3',
        text: 'Who is the famous artist behind the Mona Lisa?',
        options: [
          Option(id: 'A', label: 'A', text: 'Leonardo da Vinci'),
          Option(id: 'B', label: 'B', text: 'Michelangelo'),
          Option(id: 'C', label: 'C', text: 'Pablo Picasso'),
          Option(id: 'D', label: 'D', text: 'Vincent van Gogh'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'fpq4',
        text: 'Who is the founder of Microsoft?',
        options: [
          Option(id: 'A', label: 'A', text: 'Steve Jobs'),
          Option(id: 'B', label: 'B', text: 'Bill Gates'),
          Option(id: 'C', label: 'C', text: 'Mark Zuckerberg'),
          Option(id: 'D', label: 'D', text: 'Larry Page'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'fpq5',
        text: 'Which scientist proposed the theory of relativity?',
        options: [
          Option(id: 'A', label: 'A', text: 'Isaac Newton'),
          Option(id: 'B', label: 'B', text: 'Albert Einstein'),
          Option(id: 'C', label: 'C', text: 'Nikola Tesla'),
          Option(id: 'D', label: 'D', text: 'Galileo Galilei'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'fpq6',
        text: 'Who painted the ceiling of the Sistine Chapel?',
        options: [
          Option(id: 'A', label: 'A', text: 'Leonardo da Vinci'),
          Option(id: 'B', label: 'B', text: 'Michelangelo'),
          Option(id: 'C', label: 'C', text: 'Raphael'),
          Option(id: 'D', label: 'D', text: 'Donatello'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'fpq7',
        text: 'Who is the famous cricketer known as “God of Cricket”?',
        options: [
          Option(id: 'A', label: 'A', text: 'Brian Lara'),
          Option(id: 'B', label: 'B', text: 'Sachin Tendulkar'),
          Option(id: 'C', label: 'C', text: 'Virat Kohli'),
          Option(id: 'D', label: 'D', text: 'Jacques Kallis'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'fpq8',
        text: 'Who was the first woman to win a Nobel Prize?',
        options: [
          Option(id: 'A', label: 'A', text: 'Marie Curie'),
          Option(id: 'B', label: 'B', text: 'Rosalind Franklin'),
          Option(id: 'C', label: 'C', text: 'Ada Lovelace'),
          Option(id: 'D', label: 'D', text: 'Jane Goodall'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'fpq9',
        text: 'Who is known as the “Father of Modern Physics”?',
        options: [
          Option(id: 'A', label: 'A', text: 'Albert Einstein'),
          Option(id: 'B', label: 'B', text: 'Isaac Newton'),
          Option(id: 'C', label: 'C', text: 'Galileo Galilei'),
          Option(id: 'D', label: 'D', text: 'Niels Bohr'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'fpq10',
        text: 'Who invented the telephone?',
        options: [
          Option(id: 'A', label: 'A', text: 'Alexander Graham Bell'),
          Option(id: 'B', label: 'B', text: 'Thomas Edison'),
          Option(id: 'C', label: 'C', text: 'Guglielmo Marconi'),
          Option(id: 'D', label: 'D', text: 'Nikola Tesla'),
        ],
        correctOptionId: 'A',
      ),
    ],
  ),

// pop_quiz3: World History (15 questions)
  QuizDetail(
    id: 'pop_quiz3',
    title: 'World History Quiz',
    description: 'Challenge your knowledge of key historical events and figures.',
    pointsPerCorrect: 10,
    totalQuestions: 15,
    duration: '15 min',
    rules: ['10 points per correct answer', 'No negative marks'],
    questions: [
      Question(
        id: 'whq1',
        text: 'In which year did World War II end?',
        options: [
          Option(id: 'A', label: 'A', text: '1945'),
          Option(id: 'B', label: 'B', text: '1939'),
          Option(id: 'C', label: 'C', text: '1918'),
          Option(id: 'D', label: 'D', text: '1965'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'whq2',
        text: 'Who was the first President of the United States?',
        options: [
          Option(id: 'A', label: 'A', text: 'George Washington'),
          Option(id: 'B', label: 'B', text: 'Thomas Jefferson'),
          Option(id: 'C', label: 'C', text: 'Abraham Lincoln'),
          Option(id: 'D', label: 'D', text: 'John Adams'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'whq3',
        text: 'Which empire was ruled by Genghis Khan?',
        options: [
          Option(id: 'A', label: 'A', text: 'Roman Empire'),
          Option(id: 'B', label: 'B', text: 'Mongol Empire'),
          Option(id: 'C', label: 'C', text: 'Ottoman Empire'),
          Option(id: 'D', label: 'D', text: 'Persian Empire'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'whq4',
        text: 'The Great Wall of China was primarily built to protect against which group?',
        options: [
          Option(id: 'A', label: 'A', text: 'Mongols'),
          Option(id: 'B', label: 'B', text: 'Japanese'),
          Option(id: 'C', label: 'C', text: 'Huns'),
          Option(id: 'D', label: 'D', text: 'Romans'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'whq5',
        text: 'Who was the British Prime Minister during World War II?',
        options: [
          Option(id: 'A', label: 'A', text: 'Winston Churchill'),
          Option(id: 'B', label: 'B', text: 'Neville Chamberlain'),
          Option(id: 'C', label: 'C', text: 'Clement Attlee'),
          Option(id: 'D', label: 'D', text: 'David Lloyd George'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'whq6',
        text: 'In which year did the French Revolution begin?',
        options: [
          Option(id: 'A', label: 'A', text: '1789'),
          Option(id: 'B', label: 'B', text: '1776'),
          Option(id: 'C', label: 'C', text: '1804'),
          Option(id: 'D', label: 'D', text: '1799'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'whq7',
        text: 'Who was the first Emperor of Rome?',
        options: [
          Option(id: 'A', label: 'A', text: 'Julius Caesar'),
          Option(id: 'B', label: 'B', text: 'Augustus'),
          Option(id: 'C', label: 'C', text: 'Nero'),
          Option(id: 'D', label: 'D', text: 'Caligula'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'whq8',
        text: 'Which country was formerly known as Persia?',
        options: [
          Option(id: 'A', label: 'A', text: 'Iran'),
          Option(id: 'B', label: 'B', text: 'Iraq'),
          Option(id: 'C', label: 'C', text: 'Turkey'),
          Option(id: 'D', label: 'D', text: 'Syria'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'whq9',
        text: 'The Berlin Wall fell in which year?',
        options: [
          Option(id: 'A', label: 'A', text: '1989'),
          Option(id: 'B', label: 'B', text: '1991'),
          Option(id: 'C', label: 'C', text: '1987'),
          Option(id: 'D', label: 'D', text: '1993'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'whq10',
        text: 'Who was the leader of the Soviet Union during WWII?',
        options: [
          Option(id: 'A', label: 'A', text: 'Vladimir Lenin'),
          Option(id: 'B', label: 'B', text: 'Joseph Stalin'),
          Option(id: 'C', label: 'C', text: 'Nikita Khrushchev'),
          Option(id: 'D', label: 'D', text: 'Leon Trotsky'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'whq11',
        text: 'The Renaissance began in which country?',
        options: [
          Option(id: 'A', label: 'A', text: 'France'),
          Option(id: 'B', label: 'B', text: 'Italy'),
          Option(id: 'C', label: 'C', text: 'England'),
          Option(id: 'D', label: 'D', text: 'Spain'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'whq12',
        text: 'Who was the first man to step on the moon?',
        options: [
          Option(id: 'A', label: 'A', text: 'Buzz Aldrin'),
          Option(id: 'B', label: 'B', text: 'Neil Armstrong'),
          Option(id: 'C', label: 'C', text: 'Yuri Gagarin'),
          Option(id: 'D', label: 'D', text: 'Michael Collins'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'whq13',
        text: 'Which ancient civilization built the pyramids?',
        options: [
          Option(id: 'A', label: 'A', text: 'Egyptians'),
          Option(id: 'B', label: 'B', text: 'Mayans'),
          Option(id: 'C', label: 'C', text: 'Romans'),
          Option(id: 'D', label: 'D', text: 'Greeks'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'whq14',
        text: 'Who was the famous nurse during the Crimean War?',
        options: [
          Option(id: 'A', label: 'A', text: 'Clara Barton'),
          Option(id: 'B', label: 'B', text: 'Florence Nightingale'),
          Option(id: 'C', label: 'C', text: 'Marie Curie'),
          Option(id: 'D', label: 'D', text: 'Elizabeth Blackwell'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'whq15',
        text: 'What year did the American Civil War start?',
        options: [
          Option(id: 'A', label: 'A', text: '1861'),
          Option(id: 'B', label: 'B', text: '1776'),
          Option(id: 'C', label: 'C', text: '1812'),
          Option(id: 'D', label: 'D', text: '1850'),
        ],
        correctOptionId: 'A',
      ),
    ],
  ),


  // Science Quizzes

// sci_quiz1: Physics Basics (8 questions)
  QuizDetail(
    id: 'sci_quiz1',
    title: 'Physics Basics Quiz',
    description: 'Test your understanding of basic physics concepts.',
    pointsPerCorrect: 10,
    totalQuestions: 8,
    duration: '8 min',
    rules: ['10 points per correct answer', 'No negative marks'],
    questions: [
      Question(
        id: 'phq1',
        text: 'What is Newton’s First Law also called?',
        options: [
          Option(id: 'A', label: 'A', text: 'Law of Inertia'),
          Option(id: 'B', label: 'B', text: 'Law of Motion'),
          Option(id: 'C', label: 'C', text: 'Law of Gravity'),
          Option(id: 'D', label: 'D', text: 'Law of Thermodynamics'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'phq2',
        text: 'What is the speed of light?',
        options: [
          Option(id: 'A', label: 'A', text: '3 x 10^8 m/s'),
          Option(id: 'B', label: 'B', text: '3 x 10^6 m/s'),
          Option(id: 'C', label: 'C', text: '3 x 10^5 km/s'),
          Option(id: 'D', label: 'D', text: '3 x 10^7 km/s'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'phq3',
        text: 'Which gas is most abundant in Earth’s atmosphere?',
        options: [
          Option(id: 'A', label: 'A', text: 'Oxygen'),
          Option(id: 'B', label: 'B', text: 'Nitrogen'),
          Option(id: 'C', label: 'C', text: 'Carbon Dioxide'),
          Option(id: 'D', label: 'D', text: 'Hydrogen'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'phq4',
        text: 'What is the unit of electric current?',
        options: [
          Option(id: 'A', label: 'A', text: 'Volt'),
          Option(id: 'B', label: 'B', text: 'Ampere'),
          Option(id: 'C', label: 'C', text: 'Ohm'),
          Option(id: 'D', label: 'D', text: 'Watt'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'phq5',
        text: 'Which particle has a negative charge?',
        options: [
          Option(id: 'A', label: 'A', text: 'Proton'),
          Option(id: 'B', label: 'B', text: 'Electron'),
          Option(id: 'C', label: 'C', text: 'Neutron'),
          Option(id: 'D', label: 'D', text: 'Photon'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'phq6',
        text: 'What is the acceleration due to gravity on Earth?',
        options: [
          Option(id: 'A', label: 'A', text: '9.8 m/s²'),
          Option(id: 'B', label: 'B', text: '10 m/s²'),
          Option(id: 'C', label: 'C', text: '9.8 km/s²'),
          Option(id: 'D', label: 'D', text: '9 m/s²'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'phq7',
        text: 'Which law explains action and reaction?',
        options: [
          Option(id: 'A', label: 'A', text: 'Newton’s First Law'),
          Option(id: 'B', label: 'B', text: 'Newton’s Second Law'),
          Option(id: 'C', label: 'C', text: 'Newton’s Third Law'),
          Option(id: 'D', label: 'D', text: 'Law of Conservation of Energy'),
        ],
        correctOptionId: 'C',
      ),
      Question(
        id: 'phq8',
        text: 'What is the SI unit of force?',
        options: [
          Option(id: 'A', label: 'A', text: 'Newton'),
          Option(id: 'B', label: 'B', text: 'Joule'),
          Option(id: 'C', label: 'C', text: 'Watt'),
          Option(id: 'D', label: 'D', text: 'Pascal'),
        ],
        correctOptionId: 'A',
      ),
    ],
  ),

// sci_quiz2: Chemistry Core (10 questions)
  QuizDetail(
    id: 'sci_quiz2',
    title: 'Chemistry Core Quiz',
    description: 'Assess your knowledge on chemistry basics.',
    pointsPerCorrect: 10,
    totalQuestions: 10,
    duration: '10 min',
    rules: ['10 points per correct answer', 'No negative marks'],
    questions: [
      Question(
        id: 'chq1',
        text: 'What is the chemical symbol for water?',
        options: [
          Option(id: 'A', label: 'A', text: 'H2O'),
          Option(id: 'B', label: 'B', text: 'O2'),
          Option(id: 'C', label: 'C', text: 'CO2'),
          Option(id: 'D', label: 'D', text: 'NaCl'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'chq2',
        text: 'Which element has the atomic number 1?',
        options: [
          Option(id: 'A', label: 'A', text: 'Hydrogen'),
          Option(id: 'B', label: 'B', text: 'Helium'),
          Option(id: 'C', label: 'C', text: 'Oxygen'),
          Option(id: 'D', label: 'D', text: 'Carbon'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'chq3',
        text: 'What is NaCl commonly known as?',
        options: [
          Option(id: 'A', label: 'A', text: 'Sugar'),
          Option(id: 'B', label: 'B', text: 'Salt'),
          Option(id: 'C', label: 'C', text: 'Baking Soda'),
          Option(id: 'D', label: 'D', text: 'Vinegar'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'chq4',
        text: 'What is the pH of pure water?',
        options: [
          Option(id: 'A', label: 'A', text: '7'),
          Option(id: 'B', label: 'B', text: '0'),
          Option(id: 'C', label: 'C', text: '14'),
          Option(id: 'D', label: 'D', text: '1'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'chq5',
        text: 'Which gas is released during photosynthesis?',
        options: [
          Option(id: 'A', label: 'A', text: 'Oxygen'),
          Option(id: 'B', label: 'B', text: 'Carbon Dioxide'),
          Option(id: 'C', label: 'C', text: 'Nitrogen'),
          Option(id: 'D', label: 'D', text: 'Hydrogen'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'chq6',
        text: 'Which acid is found in lemons?',
        options: [
          Option(id: 'A', label: 'A', text: 'Citric Acid'),
          Option(id: 'B', label: 'B', text: 'Sulfuric Acid'),
          Option(id: 'C', label: 'C', text: 'Acetic Acid'),
          Option(id: 'D', label: 'D', text: 'Hydrochloric Acid'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'chq7',
        text: 'Which metal is liquid at room temperature?',
        options: [
          Option(id: 'A', label: 'A', text: 'Mercury'),
          Option(id: 'B', label: 'B', text: 'Lead'),
          Option(id: 'C', label: 'C', text: 'Gold'),
          Option(id: 'D', label: 'D', text: 'Silver'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'chq8',
        text: 'What is the chemical formula of table sugar?',
        options: [
          Option(id: 'A', label: 'A', text: 'C6H12O6'),
          Option(id: 'B', label: 'B', text: 'C12H22O11'),
          Option(id: 'C', label: 'C', text: 'CH3COOH'),
          Option(id: 'D', label: 'D', text: 'NaCl'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'chq9',
        text: 'Which element is known as the “King of Chemicals”?',
        options: [
          Option(id: 'A', label: 'A', text: 'Sulfur'),
          Option(id: 'B', label: 'B', text: 'Sulfuric Acid'),
          Option(id: 'C', label: 'C', text: 'Nitrogen'),
          Option(id: 'D', label: 'D', text: 'Chlorine'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'chq10',
        text: 'Which gas is responsible for global warming?',
        options: [
          Option(id: 'A', label: 'A', text: 'Carbon Dioxide'),
          Option(id: 'B', label: 'B', text: 'Oxygen'),
          Option(id: 'C', label: 'C', text: 'Nitrogen'),
          Option(id: 'D', label: 'D', text: 'Hydrogen'),
        ],
        correctOptionId: 'A',
      ),
    ],
  ),

// sci_quiz3: Biology Essentials (15 questions)
  QuizDetail(
    id: 'sci_quiz3',
    title: 'Biology Essentials Quiz',
    description: 'Test your understanding of fundamental biology topics.',
    pointsPerCorrect: 10,
    totalQuestions: 15,
    duration: '15 min',
    rules: ['10 points per correct answer', 'No negative marks'],
    questions: [
      Question(
        id: 'bioq1',
        text: 'What is the powerhouse of the cell?',
        options: [
          Option(id: 'A', label: 'A', text: 'Nucleus'),
          Option(id: 'B', label: 'B', text: 'Mitochondria'),
          Option(id: 'C', label: 'C', text: 'Ribosome'),
          Option(id: 'D', label: 'D', text: 'Chloroplast'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'bioq2',
        text: 'DNA stands for?',
        options: [
          Option(id: 'A', label: 'A', text: 'Deoxyribonucleic Acid'),
          Option(id: 'B', label: 'B', text: 'Deoxynucleic Acid'),
          Option(id: 'C', label: 'C', text: 'Dicarboxy Nucleic Acid'),
          Option(id: 'D', label: 'D', text: 'Diatomic Nucleic Acid'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'bioq3',
        text: 'Which organ filters blood in humans?',
        options: [
          Option(id: 'A', label: 'A', text: 'Heart'),
          Option(id: 'B', label: 'B', text: 'Kidney'),
          Option(id: 'C', label: 'C', text: 'Liver'),
          Option(id: 'D', label: 'D', text: 'Lungs'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'bioq4',
        text: 'Which process do plants use to make food?',
        options: [
          Option(id: 'A', label: 'A', text: 'Respiration'),
          Option(id: 'B', label: 'B', text: 'Photosynthesis'),
          Option(id: 'C', label: 'C', text: 'Transpiration'),
          Option(id: 'D', label: 'D', text: 'Digestion'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'bioq5',
        text: 'Which blood cells help fight infection?',
        options: [
          Option(id: 'A', label: 'A', text: 'Red Blood Cells'),
          Option(id: 'B', label: 'B', text: 'White Blood Cells'),
          Option(id: 'C', label: 'C', text: 'Platelets'),
          Option(id: 'D', label: 'D', text: 'Plasma'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'bioq6',
        text: 'What is the basic unit of life?',
        options: [
          Option(id: 'A', label: 'A', text: 'Organ'),
          Option(id: 'B', label: 'B', text: 'Cell'),
          Option(id: 'C', label: 'C', text: 'Tissue'),
          Option(id: 'D', label: 'D', text: 'Organism'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'bioq7',
        text: 'Which part of the cell contains genetic material?',
        options: [
          Option(id: 'A', label: 'A', text: 'Nucleus'),
          Option(id: 'B', label: 'B', text: 'Mitochondria'),
          Option(id: 'C', label: 'C', text: 'Ribosome'),
          Option(id: 'D', label: 'D', text: 'Cytoplasm'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'bioq8',
        text: 'Which macronutrient is the main source of energy?',
        options: [
          Option(id: 'A', label: 'A', text: 'Proteins'),
          Option(id: 'B', label: 'B', text: 'Carbohydrates'),
          Option(id: 'C', label: 'C', text: 'Fats'),
          Option(id: 'D', label: 'D', text: 'Vitamins'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'bioq9',
        text: 'Which system in the human body controls hormones?',
        options: [
          Option(id: 'A', label: 'A', text: 'Nervous System'),
          Option(id: 'B', label: 'B', text: 'Endocrine System'),
          Option(id: 'C', label: 'C', text: 'Respiratory System'),
          Option(id: 'D', label: 'D', text: 'Circulatory System'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'bioq10',
        text: 'Which organ is responsible for pumping blood?',
        options: [
          Option(id: 'A', label: 'A', text: 'Lungs'),
          Option(id: 'B', label: 'B', text: 'Heart'),
          Option(id: 'C', label: 'C', text: 'Kidney'),
          Option(id: 'D', label: 'D', text: 'Liver'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'bioq11',
        text: 'Which vitamin is produced when skin is exposed to sunlight?',
        options: [
          Option(id: 'A', label: 'A', text: 'Vitamin A'),
          Option(id: 'B', label: 'B', text: 'Vitamin B12'),
          Option(id: 'C', label: 'C', text: 'Vitamin D'),
          Option(id: 'D', label: 'D', text: 'Vitamin C'),
        ],
        correctOptionId: 'C',
      ),
      Question(
        id: 'bioq12',
        text: 'Which organelle is responsible for protein synthesis?',
        options: [
          Option(id: 'A', label: 'A', text: 'Ribosome'),
          Option(id: 'B', label: 'B', text: 'Golgi Apparatus'),
          Option(id: 'C', label: 'C', text: 'Mitochondria'),
          Option(id: 'D', label: 'D', text: 'Lysosome'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'bioq13',
        text: 'Which blood component helps in clotting?',
        options: [
          Option(id: 'A', label: 'A', text: 'Platelets'),
          Option(id: 'B', label: 'B', text: 'Red Blood Cells'),
          Option(id: 'C', label: 'C', text: 'White Blood Cells'),
          Option(id: 'D', label: 'D', text: 'Plasma'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'bioq14',
        text: 'Which part of the brain controls balance?',
        options: [
          Option(id: 'A', label: 'A', text: 'Cerebrum'),
          Option(id: 'B', label: 'B', text: 'Cerebellum'),
          Option(id: 'C', label: 'C', text: 'Medulla'),
          Option(id: 'D', label: 'D', text: 'Hypothalamus'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'bioq15',
        text: 'Which type of blood cells carry oxygen?',
        options: [
          Option(id: 'A', label: 'A', text: 'White Blood Cells'),
          Option(id: 'B', label: 'B', text: 'Red Blood Cells'),
          Option(id: 'C', label: 'C', text: 'Platelets'),
          Option(id: 'D', label: 'D', text: 'Plasma'),
        ],
        correctOptionId: 'B',
      ),
    ],
  ),


  // Mathematics Quizzes

// math_quiz1: Algebra (8 questions)
  QuizDetail(
    id: 'math_quiz1',
    title: 'Algebra Quiz',
    description: 'Solve algebraic problems and equations.',
    pointsPerCorrect: 10,
    totalQuestions: 8,
    duration: '8 min',
    rules: ['10 points per correct answer', 'No negative marks'],
    questions: [
      Question(
        id: 'alg1',
        text: 'Solve: 2x + 5 = 15',
        options: [
          Option(id: 'A', label: 'A', text: 'x = 5'),
          Option(id: 'B', label: 'B', text: 'x = 10'),
          Option(id: 'C', label: 'C', text: 'x = 4'),
          Option(id: 'D', label: 'D', text: 'x = 2'),
        ],
        correctOptionId: 'C',
      ),
      Question(
        id: 'alg2',
        text: 'Simplify: (x^2 * x^3)',
        options: [
          Option(id: 'A', label: 'A', text: 'x^5'),
          Option(id: 'B', label: 'B', text: 'x^6'),
          Option(id: 'C', label: 'C', text: 'x^9'),
          Option(id: 'D', label: 'D', text: 'x^1'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'alg3',
        text: 'Solve for y: 3y - 9 = 0',
        options: [
          Option(id: 'A', label: 'A', text: 'y = 3'),
          Option(id: 'B', label: 'B', text: 'y = 6'),
          Option(id: 'C', label: 'C', text: 'y = 0'),
          Option(id: 'D', label: 'D', text: 'y = -3'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'alg4',
        text: 'Factorize: x^2 - 9',
        options: [
          Option(id: 'A', label: 'A', text: '(x - 3)(x + 3)'),
          Option(id: 'B', label: 'B', text: '(x - 9)(x + 1)'),
          Option(id: 'C', label: 'C', text: '(x - 1)(x + 9)'),
          Option(id: 'D', label: 'D', text: '(x - 2)(x + 2)'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'alg5',
        text: 'Simplify: 5x - 2x + 7',
        options: [
          Option(id: 'A', label: 'A', text: '3x + 7'),
          Option(id: 'B', label: 'B', text: '7x'),
          Option(id: 'C', label: 'C', text: '5x - 7'),
          Option(id: 'D', label: 'D', text: '2x + 7'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'alg6',
        text: 'Solve: 4x/2 = 8',
        options: [
          Option(id: 'A', label: 'A', text: 'x = 4'),
          Option(id: 'B', label: 'B', text: 'x = 2'),
          Option(id: 'C', label: 'C', text: 'x = 8'),
          Option(id: 'D', label: 'D', text: 'x = 16'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'alg7',
        text: 'Simplify: (2x + 3) - (x - 5)',
        options: [
          Option(id: 'A', label: 'A', text: 'x + 8'),
          Option(id: 'B', label: 'B', text: '3x - 2'),
          Option(id: 'C', label: 'C', text: 'x - 2'),
          Option(id: 'D', label: 'D', text: '2x + 2'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'alg8',
        text: 'Solve: 6x - 4 = 14',
        options: [
          Option(id: 'A', label: 'A', text: 'x = 3'),
          Option(id: 'B', label: 'B', text: 'x = 4'),
          Option(id: 'C', label: 'C', text: 'x = 5'),
          Option(id: 'D', label: 'D', text: 'x = 2'),
        ],
        correctOptionId: 'A',
      ),
    ],
  ),

// math_quiz2: Geometry (10 questions)
  QuizDetail(
    id: 'math_quiz2',
    title: 'Geometry Quiz',
    description: 'Test your understanding of geometric concepts.',
    pointsPerCorrect: 10,
    totalQuestions: 10,
    duration: '10 min',
    rules: ['10 points per correct answer', 'No negative marks'],
    questions: [
      Question(
        id: 'geo1',
        text: 'What is the sum of angles in a triangle?',
        options: [
          Option(id: 'A', label: 'A', text: '180°'),
          Option(id: 'B', label: 'B', text: '90°'),
          Option(id: 'C', label: 'C', text: '360°'),
          Option(id: 'D', label: 'D', text: '270°'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'geo2',
        text: 'How many sides does a hexagon have?',
        options: [
          Option(id: 'A', label: 'A', text: '5'),
          Option(id: 'B', label: 'B', text: '6'),
          Option(id: 'C', label: 'C', text: '7'),
          Option(id: 'D', label: 'D', text: '8'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'geo3',
        text: 'What is the area of a rectangle?',
        options: [
          Option(id: 'A', label: 'A', text: 'length × width'),
          Option(id: 'B', label: 'B', text: 'length + width'),
          Option(id: 'C', label: 'C', text: '2 × (length + width)'),
          Option(id: 'D', label: 'D', text: 'length × height'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'geo4',
        text: 'A square has how many right angles?',
        options: [
          Option(id: 'A', label: 'A', text: '2'),
          Option(id: 'B', label: 'B', text: '3'),
          Option(id: 'C', label: 'C', text: '4'),
          Option(id: 'D', label: 'D', text: '1'),
        ],
        correctOptionId: 'C',
      ),
      Question(
        id: 'geo5',
        text: 'The circumference of a circle is calculated as?',
        options: [
          Option(id: 'A', label: 'A', text: 'π × r²'),
          Option(id: 'B', label: 'B', text: '2 × π × r'),
          Option(id: 'C', label: 'C', text: 'π × d²'),
          Option(id: 'D', label: 'D', text: 'π × r'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'geo6',
        text: 'What is a polygon with 8 sides called?',
        options: [
          Option(id: 'A', label: 'A', text: 'Hexagon'),
          Option(id: 'B', label: 'B', text: 'Octagon'),
          Option(id: 'C', label: 'C', text: 'Heptagon'),
          Option(id: 'D', label: 'D', text: 'Nonagon'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'geo7',
        text: 'The sum of angles in a quadrilateral is?',
        options: [
          Option(id: 'A', label: 'A', text: '180°'),
          Option(id: 'B', label: 'B', text: '360°'),
          Option(id: 'C', label: 'C', text: '270°'),
          Option(id: 'D', label: 'D', text: '90°'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'geo8',
        text: 'A triangle with all sides equal is called?',
        options: [
          Option(id: 'A', label: 'A', text: 'Scalene'),
          Option(id: 'B', label: 'B', text: 'Isosceles'),
          Option(id: 'C', label: 'C', text: 'Equilateral'),
          Option(id: 'D', label: 'D', text: 'Right Triangle'),
        ],
        correctOptionId: 'C',
      ),
      Question(
        id: 'geo9',
        text: 'What is the perimeter of a square with side length 5?',
        options: [
          Option(id: 'A', label: 'A', text: '20'),
          Option(id: 'B', label: 'B', text: '25'),
          Option(id: 'C', label: 'C', text: '15'),
          Option(id: 'D', label: 'D', text: '10'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'geo10',
        text: 'A right angle measures?',
        options: [
          Option(id: 'A', label: 'A', text: '90°'),
          Option(id: 'B', label: 'B', text: '180°'),
          Option(id: 'C', label: 'C', text: '45°'),
          Option(id: 'D', label: 'D', text: '60°'),
        ],
        correctOptionId: 'A',
      ),
    ],
  ),

// math_quiz3: Calculus (15 questions)
  QuizDetail(
    id: 'math_quiz3',
    title: 'Calculus Quiz',
    description: 'Test your understanding of basic calculus concepts.',
    pointsPerCorrect: 10,
    totalQuestions: 15,
    duration: '15 min',
    rules: ['10 points per correct answer', 'No negative marks'],
    questions: [
      Question(
        id: 'calc1',
        text: 'What is the derivative of x²?',
        options: [
          Option(id: 'A', label: 'A', text: '2x'),
          Option(id: 'B', label: 'B', text: 'x²'),
          Option(id: 'C', label: 'C', text: 'x'),
          Option(id: 'D', label: 'D', text: '2'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc2',
        text: 'The integral of 1/x dx is?',
        options: [
          Option(id: 'A', label: 'A', text: 'ln|x| + C'),
          Option(id: 'B', label: 'B', text: '1/x² + C'),
          Option(id: 'C', label: 'C', text: 'x + C'),
          Option(id: 'D', label: 'D', text: 'e^x + C'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc3',
        text: 'The derivative of sin(x) is?',
        options: [
          Option(id: 'A', label: 'A', text: 'cos(x)'),
          Option(id: 'B', label: 'B', text: '-cos(x)'),
          Option(id: 'C', label: 'C', text: 'sin(x)'),
          Option(id: 'D', label: 'D', text: '-sin(x)'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc4',
        text: 'The derivative of cos(x) is?',
        options: [
          Option(id: 'A', label: 'A', text: 'sin(x)'),
          Option(id: 'B', label: 'B', text: '-sin(x)'),
          Option(id: 'C', label: 'C', text: 'cos(x)'),
          Option(id: 'D', label: 'D', text: '-cos(x)'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'calc5',
        text: 'The integral of 2x dx is?',
        options: [
          Option(id: 'A', label: 'A', text: 'x² + C'),
          Option(id: 'B', label: 'B', text: '2x² + C'),
          Option(id: 'C', label: 'C', text: 'x + C'),
          Option(id: 'D', label: 'D', text: 'x²/2 + C'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc6',
        text: 'The derivative of e^x is?',
        options: [
          Option(id: 'A', label: 'A', text: 'x e^(x-1)'),
          Option(id: 'B', label: 'B', text: 'e^x'),
          Option(id: 'C', label: 'C', text: 'x e^x'),
          Option(id: 'D', label: 'D', text: '1'),
        ],
        correctOptionId: 'B',
      ),
      Question(
        id: 'calc7',
        text: 'The derivative of ln(x) is?',
        options: [
          Option(id: 'A', label: 'A', text: '1/x'),
          Option(id: 'B', label: 'B', text: 'ln(x)'),
          Option(id: 'C', label: 'C', text: 'x'),
          Option(id: 'D', label: 'D', text: 'x²'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc8',
        text: 'The integral of x dx is?',
        options: [
          Option(id: 'A', label: 'A', text: 'x²/2 + C'),
          Option(id: 'B', label: 'B', text: 'x² + C'),
          Option(id: 'C', label: 'C', text: '2x + C'),
          Option(id: 'D', label: 'D', text: '1/x + C'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc9',
        text: 'The derivative of x^3 is?',
        options: [
          Option(id: 'A', label: 'A', text: '3x²'),
          Option(id: 'B', label: 'B', text: 'x²'),
          Option(id: 'C', label: 'C', text: '3x³'),
          Option(id: 'D', label: 'D', text: 'x³'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc10',
        text: 'The integral of 3x² dx is?',
        options: [
          Option(id: 'A', label: 'A', text: 'x³ + C'),
          Option(id: 'B', label: 'B', text: '3x³ + C'),
          Option(id: 'C', label: 'C', text: 'x² + C'),
          Option(id: 'D', label: 'D', text: '3x² + C'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc11',
        text: 'The derivative of tan(x) is?',
        options: [
          Option(id: 'A', label: 'A', text: 'sec²(x)'),
          Option(id: 'B', label: 'B', text: 'cos²(x)'),
          Option(id: 'C', label: 'C', text: '-sec²(x)'),
          Option(id: 'D', label: 'D', text: 'sin²(x)'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc12',
        text: 'The integral of 1/(1 + x²) dx is?',
        options: [
          Option(id: 'A', label: 'A', text: 'arctan(x) + C'),
          Option(id: 'B', label: 'B', text: 'arcsin(x) + C'),
          Option(id: 'C', label: 'C', text: 'ln|x| + C'),
          Option(id: 'D', label: 'D', text: '1/(x² + 1)'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc13',
        text: 'The derivative of a constant is?',
        options: [
          Option(id: 'A', label: 'A', text: '0'),
          Option(id: 'B', label: 'B', text: '1'),
          Option(id: 'C', label: 'C', text: 'The constant itself'),
          Option(id: 'D', label: 'D', text: 'x'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc14',
        text: 'The integral of 0 dx is?',
        options: [
          Option(id: 'A', label: 'A', text: 'C'),
          Option(id: 'B', label: 'B', text: '0'),
          Option(id: 'C', label: 'C', text: 'x'),
          Option(id: 'D', label: 'D', text: '1'),
        ],
        correctOptionId: 'A',
      ),
      Question(
        id: 'calc15',
        text: 'The derivative of x^n is?',
        options: [
          Option(id: 'A', label: 'A', text: 'n * x^(n-1)'),
          Option(id: 'B', label: 'B', text: 'x^(n-1)'),
          Option(id: 'C', label: 'C', text: 'n * x^n'),
          Option(id: 'D', label: 'D', text: 'x^n / n'),
        ],
        correctOptionId: 'A',
      ),
    ],
  ),


  QuizDetail(
    id: 'uiux',
    title: 'UI UX Design Quiz',
    description: 'Brief explanation about this quiz',
    pointsPerCorrect: 10,
    totalQuestions: 8,
    duration: '8 min',
    rules: [
      '10 points awarded for a correct answer and no marks for an incorrect answer',
      'Tap on options to select the correct answer',
      'Tap on the bookmark icon to save interesting questions',
      'Click submit if you are sure you want to complete all the quizzes',
    ],
    questions: [
      Question(
        id: 'q1',
        text: 'What is the meaning of UI UX Design?',
        options: [
          Option(id: 'A', label: 'A', text: 'User Interface and User Experience'),
          Option(id: 'B', label: 'B', text: 'User Input and Unique Experience'),
          Option(id: 'C', label: 'C', text: 'Unified Interaction and UX System'),
          Option(id: 'D', label: 'D', text: 'User Interface and User Experience'),
          Option(id: 'E', label: 'E', text: 'Universal Interface and UX Design'),
        ],
        correctOptionId: 'A',
      ),
      // Add more questions...
    ],
  ),

  QuizDetail(
    id: 'graphic',
    title: 'Graphic Design Quiz',
    description: 'Short intro for Graphic Design quiz.',
    pointsPerCorrect: 10,
    totalQuestions: 10,
    duration: '10 min',
    rules: [
      '10 points per correct answer',
      'No negative marks',
      'You can bookmark questions',
    ],
    questions: [
      Question(
        id: 'gq1',
        text: 'Which tool is commonly used for vector graphics?',
        options: [
          Option(id: 'A', label: 'A', text: 'Adobe Illustrator'),
          Option(id: 'B', label: 'B', text: 'Photoshop'),
          Option(id: 'C', label: 'C', text: 'Figma'),
          Option(id: 'D', label: 'D', text: 'MS Paint'),
        ],
        correctOptionId: 'A',
      ),
      // more questions...
    ],
  ),
];
