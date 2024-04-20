import 'package:flutter/material.dart';
import 'package:quiz_futebol/pages/QuizPage.dart';
import 'quiz_names.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz de Futebol',
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.black, 
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(quizNames.length, (index) {
            String quizName = quizNames[index];
            String imageName = '${quizName.toLowerCase().replaceAll(' ', '_')}.png';
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage(quizIndex: index)),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3.0, // Sombra suave
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getImageForName(imageName),
                    Text(
                      quizName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _getImageForName(String name) {
    String imagePath = 'assets/images/$name';
    return Image.asset(
      imagePath,
      width: 100,
      height: 100,
    );
  }
}
