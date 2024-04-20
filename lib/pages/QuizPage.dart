import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_futebol/pages/ResultPage.dart';
import 'quiz_data.dart';
import 'quiz_names.dart';

class QuizPage extends StatefulWidget {
  final int quizIndex;

  QuizPage({required this.quizIndex});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  bool correctAnswer = false;

  void _answerQuestion(String answer) {
    if (_answered) return;

    setState(() {
      _answered = true;
      if (quizData[widget.quizIndex][_currentQuestionIndex]['correctAnswer'] == answer) {
        _score++;
        correctAnswer = true;
      } else {
        correctAnswer = false;
      }
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _answered = false;
        correctAnswer = false;
        if (_currentQuestionIndex < quizData[widget.quizIndex].length - 1) {
          _currentQuestionIndex++;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ResultPage(score: _score, totalQuestions: quizData[widget.quizIndex].length, questions: quizData[widget.quizIndex])),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = quizData[widget.quizIndex][_currentQuestionIndex]['options'].cast<String>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          quizNames[widget.quizIndex],
          style: const TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.black, 
        iconTheme: const IconThemeData(color: Colors.white), 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              Text(
                'Pergunta ${_currentQuestionIndex + 1} de ${quizData[widget.quizIndex].length}',
                style: const TextStyle(fontSize: 20.0, color: Colors.black), 
              ),
              const SizedBox(height: 20.0),
              Text(
                quizData[widget.quizIndex][_currentQuestionIndex]['question'],
                style: const TextStyle(fontSize: 24.0, color: Colors.black), 
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0), 
              Column(
                children: options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _answerQuestion(option);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black;
                            }
                            return _answered
                                ? (option == quizData[widget.quizIndex][_currentQuestionIndex]['correctAnswer']
                                    ? Colors.green
                                    : Colors.red)
                                : Colors.black;
                          },
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text(
                        option,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
