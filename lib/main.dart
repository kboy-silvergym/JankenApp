import 'dart:math';

import 'package:flutter/material.dart';
import 'package:janken_app/result_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  _JankenPageState createState() => _JankenPageState();
}

const String goo = '✊️';
const String choki = '✌️';
const String par = '✋';

class _JankenPageState extends State<JankenPage> {
  String myHand = '';
  String computerHand = '';
  String result = '';
  int currentRound = 0;
  int winCount = 0;
  int drawCount = 0;
  int loseCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('じゃんけん'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentRound != 0 ? '$winCount勝$loseCount敗$drawCount引き分け' : '',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    currentRound != 0 ? '第$currentRound回戦' : 'じゃんけん5回勝負！',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    result,
                    style: TextStyle(
                      fontSize: 60,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    computerHand,
                    style: TextStyle(fontSize: 60, color: Colors.red),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    myHand,
                    style: TextStyle(fontSize: 60),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      selectHand(goo);
                    },
                    child: const Text(goo),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectHand(choki);
                    },
                    child: const Text(choki),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectHand(par);
                    },
                    child: const Text(par),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectHand(String selectedHand) {
    print(selectedHand);
    myHand = selectedHand;
    generateComputerHand(); // コンピューターの手を決める。
    judge();
    currentRound += 1;

    if (currentRound == 5) {
      resetAndShowResult();
    }

    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);
    computerHand = randomNumberToHand(randomNumber);
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return goo;
      case 1:
        return choki;
      case 2:
        return par;
      default:
        return goo;
    }
  }

  String randomNumberToHand2(int randomNumber) {
    if (randomNumber == 0) {
      return goo;
    } else if (randomNumber == 1) {
      return choki;
    } else {
      return par;
    }
  }

  String randomNumberToHand3(int randomNumber) {
    final hands = [goo, choki, par];
    return hands[randomNumber];
  }

  void judge() {
    if (myHand == computerHand) {
      result = '引き分け';
      drawCount += 1;
    } else if ((myHand == goo && computerHand == choki) ||
        (myHand == choki && computerHand == par) ||
        (myHand == par && computerHand == goo)) {
      result = '勝ち';
      winCount += 1;
    } else {
      result = '負け';
      loseCount += 1;
    }
  }

  void resetAndShowResult() async {
    String finalResult;
    if (winCount > loseCount) {
      finalResult = '勝ち';
    } else if (loseCount > winCount) {
      finalResult = '負け';
    } else {
      finalResult = '引き分け';
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          winCount: winCount,
          drawCount: drawCount,
          loseCount: loseCount,
          finalResult: finalResult,
        ),
        fullscreenDialog: true,
      ),
    );

    currentRound = 0;
    winCount = 0;
    drawCount = 0;
    loseCount = 0;
    result = '';
    myHand = '';
    computerHand = '';

    setState(() {});
  }
}
