import 'dart:math';
import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/models.dart';
import '../services/storage_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String? _selectedCategory;
  List<QuizQuestion> _activeQuestions = [];
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _quizCompleted = false;

  List<String> get _categories {
    return quizQuestions.map((q) => q.category).toSet().toList()..sort();
  }

  void _startQuiz(String? category) {
    List<QuizQuestion> questions;
    if (category == null || category == 'All') {
      questions = List.of(quizQuestions);
    } else {
      questions = quizQuestions.where((q) => q.category == category).toList();
    }
    questions.shuffle(Random());
    if (questions.length > 15) questions = questions.sublist(0, 15);

    setState(() {
      _selectedCategory = category ?? 'All';
      _activeQuestions = questions;
      _currentIndex = 0;
      _score = 0;
      _selectedAnswer = null;
      _answered = false;
      _quizCompleted = false;
    });
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _activeQuestions[_currentIndex].correctIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _activeQuestions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      setState(() => _quizCompleted = true);
      StorageService.saveQuizScore(_selectedCategory ?? 'All', _score);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_activeQuestions.isEmpty) {
      return _buildCategorySelection();
    }
    if (_quizCompleted) {
      return _buildResults();
    }
    return _buildQuizQuestion();
  }

  Widget _buildCategorySelection() {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz - Test Your Knowledge')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Icon(Icons.quiz,
                    size: 56,
                    color: theme.colorScheme.primary.withOpacity(0.3)),
                const SizedBox(height: 16),
                const Text(
                  'Constitutional Quiz',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Test your knowledge of the Indian Constitution and laws.\n'
                  'Choose a category to begin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                // All categories button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _startQuiz('All'),
                    icon: const Icon(Icons.shuffle),
                    label: const Text('All Categories (Random 15)'),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(18)),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 12),
                Text(
                  'Or pick a category:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(height: 12),
                ..._categories.map((cat) {
                  final count =
                      quizQuestions.where((q) => q.category == cat).length;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _startQuiz(cat),
                        style: OutlinedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(cat,
                                style: const TextStyle(fontSize: 14)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '$count Qs',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizQuestion() {
    final theme = Theme.of(context);
    final question = _activeQuestions[_currentIndex];
    final progress = (_currentIndex + 1) / _activeQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('$_selectedCategory Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => setState(() {
            _activeQuestions = [];
            _quizCompleted = false;
          }),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentIndex + 1} of ${_activeQuestions.length}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      'Score: $_score',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    question.category,
                    style:
                        const TextStyle(fontSize: 11, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),

                // Question
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.question,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...List.generate(question.options.length, (i) {
                          Color? bgColor;
                          Color? borderColor;
                          IconData? trailingIcon;

                          if (_answered) {
                            if (i == question.correctIndex) {
                              bgColor = Colors.green.withOpacity(0.1);
                              borderColor = Colors.green;
                              trailingIcon = Icons.check_circle;
                            } else if (i == _selectedAnswer &&
                                i != question.correctIndex) {
                              bgColor = Colors.red.withOpacity(0.1);
                              borderColor = Colors.red;
                              trailingIcon = Icons.cancel;
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () => _selectAnswer(i),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  border: Border.all(
                                    color: borderColor ??
                                        (_selectedAnswer == i
                                            ? theme.colorScheme.primary
                                            : Colors.grey.withOpacity(0.3)),
                                    width: _selectedAnswer == i ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedAnswer == i
                                            ? theme.colorScheme.primary
                                                .withOpacity(0.1)
                                            : Colors.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      child: Text(
                                        String.fromCharCode(65 + i),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: _selectedAnswer == i
                                              ? theme.colorScheme.primary
                                              : null,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        question.options[i],
                                        style:
                                            const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    if (trailingIcon != null)
                                      Icon(trailingIcon,
                                          color: borderColor, size: 22),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // Explanation
                if (_answered) ...[
                  const SizedBox(height: 12),
                  Card(
                    color: Colors.amber.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.lightbulb,
                                  color: Colors.amber, size: 20),
                              SizedBox(width: 8),
                              Text('Explanation',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            question.explanation,
                            style:
                                const TextStyle(fontSize: 13, height: 1.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16)),
                      child: Text(
                        _currentIndex < _activeQuestions.length - 1
                            ? 'Next Question'
                            : 'See Results',
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    final theme = Theme.of(context);
    final percentage = (_score / _activeQuestions.length * 100).round();
    String grade;
    Color gradeColor;
    String message;

    if (percentage >= 90) {
      grade = 'A+';
      gradeColor = Colors.green;
      message = 'Outstanding! You are a true Nagrik scholar! 🏆';
    } else if (percentage >= 75) {
      grade = 'A';
      gradeColor = Colors.teal;
      message = 'Excellent understanding of the Constitution!';
    } else if (percentage >= 60) {
      grade = 'B';
      gradeColor = Colors.blue;
      message = 'Good job! Keep learning and you\'ll master it.';
    } else if (percentage >= 40) {
      grade = 'C';
      gradeColor = Colors.orange;
      message = 'Fair attempt. Read more about the Constitution.';
    } else {
      grade = 'D';
      gradeColor = Colors.red;
      message = 'Keep studying! Knowledge is power.';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => setState(() {
            _activeQuestions = [];
            _quizCompleted = false;
          }),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: gradeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: gradeColor, width: 4),
                  ),
                  child: Text(
                    grade,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: gradeColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '$_score / ${_activeQuestions.length}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$percentage% correct',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _startQuiz(_selectedCategory),
                    icon: const Icon(Icons.replay),
                    label: const Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() {
                      _activeQuestions = [];
                      _quizCompleted = false;
                    }),
                    icon: const Icon(Icons.category),
                    label: const Text('Choose Another Category'),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16)),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
