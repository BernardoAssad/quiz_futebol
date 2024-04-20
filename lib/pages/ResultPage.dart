import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Map<String, dynamic>> questions;

  ResultPage({required this.score, required this.totalQuestions, required this.questions});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> wrongAnswers = [];
    for (int i = 0; i < questions.length; i++) {
      if (questions[i]['correctAnswer'] != questions[i]['options'][0]) {
        wrongAnswers.add(questions[i]);
      }
    }

    int correctAnswers = score;

    String message;
    if (correctAnswers < 5) {
      message = "Nossa, você não conhece sobre esse time.";
    } else if (correctAnswers < totalQuestions) {
      message = "Você foi bem!";
    } else {
      message = "Você é um fanático!";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resultado',
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.black, 
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Parabéns, você concluiu o Quiz!',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Pontuação: $correctAnswers/$totalQuestions',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              message,
              style: const TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
