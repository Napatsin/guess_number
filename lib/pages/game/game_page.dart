// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:guess_number/game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _controller = TextEditingController();
  final _game = Game(maxRandom: 100);
  var _feedbackText = '';
  var _boxCount = 0;
  var _showBox = true;

  @override
  Widget build(BuildContext context) {
    var pinkBox = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(width: 20, height: 20, color: Colors.pink),
    );
    var blueBox = Container(width: 20, height: 20, color: Colors.blue);

    var boxList = <Widget>[];
    for (int i = 0; i < _boxCount; i++) {
      boxList.add(pinkBox);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.accessibility,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(width: 10),
            Text('GUESS THE NUMBER'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _showBox ? boxList : [],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: Text(
                      'Please guess the number between 1 and 100',
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your guess',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: OutlinedButton(
                      onPressed: () {
                        //todo:
                        var input = _controller.text;
                        var guess = int.tryParse(input);

                        var result = _game.doGuess(guess!);
                        setState(() {
                          if (result == GuessResult.correct) {
                            _feedbackText = 'Correct!';
                          } else if (result == GuessResult.tooHigh) {
                            _feedbackText = 'Too high, please try again';
                          } else {
                            _feedbackText = 'Too low, please try again';
                          }
                        });
                        print(input);
                      },
                      child: Text('GUESS'),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _boxCount++;
                      });
                    },
                    child: Text('TEST'),
                  ),
                  OutlinedButton(
                    onPressed: (){
                      setState(() {
                        _showBox = !_showBox;
                      });
                    },
                    child: Text('TOGGLE'),
                  ),
                ],
              ),
            ),
            Text(_feedbackText),
          ],
        ),
      ),
    );
  }
}
