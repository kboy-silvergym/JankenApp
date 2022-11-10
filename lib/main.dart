import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  String myHand = goo;
  String computerHand = goo;
  String result = '引き分け';

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
            Text(
              result,
              style: TextStyle(
                fontSize: 60,
              ),
            ),
            const SizedBox(
              height: 16,
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
            const SizedBox(
              height: 16,
            ),
            Row(
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
    } else if ((myHand == goo && computerHand == choki) ||
        (myHand == choki && computerHand == par) ||
        (myHand == par && computerHand == goo)) {
      result = '勝ち';
    } else {
      result = '負け';
    }
  }
}
