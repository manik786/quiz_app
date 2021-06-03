import 'package:flutter/material.dart';
import 'QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
          backgroundColor: Colors.black38,
        ),
        backgroundColor: Colors.grey[900],
        body: QuizApp(),
      ),
    ),
  );
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentQuestion = 0;
  List<Icon> answerRecord = [];

  checkAnswer(bool usersAnswer) {
    if (usersAnswer == quizBrain.questions[currentQuestion].answer) {
      answerRecord.add(
        Icon(Icons.check, color: Colors.green, size: 30),
      );
    } else {
      answerRecord.add(
        Icon(Icons.close, color: Colors.red, size: 30),
      );
    }

    if (currentQuestion == quizBrain.questions.length - 1) {
      answerRecord = [];
      currentQuestion = 0;
      Alert(
        context: context,
        title: 'FINISHED!',
        desc: 'You\'ve reached the end of the quiz.',
      ).show();
    } else {
      currentQuestion++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: answerRecord,
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  "${quizBrain.questions[currentQuestion].questionText}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      checkAnswer(true);
                    });
                  },
                  child: Text(
                    "TRUE",
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      checkAnswer(false);
                    });
                  },
                  child: Text(
                    "FALSE",
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
