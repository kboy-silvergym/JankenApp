import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    Key? key,
    required this.winCount,
    required this.drawCount,
    required this.loseCount,
    required this.finalResult,
  }) : super(key: key);

  final int winCount;
  final int drawCount;
  final int loseCount;
  final String finalResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5回勝負の結果'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 32,
            ),
            Text(
              '$winCount勝$loseCount敗$drawCount引き分け',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              '$finalResult',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
