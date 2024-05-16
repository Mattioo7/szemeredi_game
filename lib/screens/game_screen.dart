import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:szemeredi_game/models/game_state.dart';
import 'package:szemeredi_game/utils/ffi_bindings.dart';
import 'package:szemeredi_game/widgets/number_tile.dart';
import 'package:szemeredi_game/widgets/player_info.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.sequenceLength,
    required this.numberOfRandomizedNumbers,
    required this.maxRandomNumber,
  });

  final int sequenceLength;
  final int numberOfRandomizedNumbers;
  final int maxRandomNumber;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  _GameScreenState() {
    dylib = DynamicLibrary.open('game_engine/libengine.so');
    gameEngine = SzemerediGameEngine(dylib);
  }

  @override
  void initState() {
    super.initState();
    final init = gameEngine.api_init();
    log('Init: $init');
    final setup = gameEngine.api_setup(
      widget.sequenceLength,
      widget.numberOfRandomizedNumbers,
      widget.maxRandomNumber,
    );
    log('Setup: $setup');

    if (init != 0 || setup != 0) {
      Navigator.pop(context);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong, please try again.'),
          ),
        );
      });
    }

    final state = gameEngine.api_get_state();
    gameState = GameState.fromState(state);
  }

  late final DynamicLibrary dylib;
  late final SzemerediGameEngine gameEngine;
  late final GameState gameState;

  bool isPlayerTurn = true;
  bool isPlay = true;

  Future<void> playerTurn(int number) async {
    setState(() {
      if (isPlayerTurn && isPlay) {
        gameEngine.api_move(number);
        gameState.white.add(number);
        isPlayerTurn = false;
        computerTurn();
      }
    });
  }

  Future<void> computerTurn() async {
    var whoWon = gameEngine.api_check_who_won();

    if (whoWon != PLAY) {
      log('whoWon (first): $whoWon');
      isPlay = false;

      await displayWinnerDialog(whoWon);
      return;
    }

    // TODO: delete
    await Future<void>.delayed(const Duration(seconds: 1));

    setState(() {
      if (isPlay) {
        final pickedNumber = gameEngine.api_think();
        log('Computer picked: $pickedNumber');
        gameEngine.api_move(pickedNumber);
        gameState.black.add(pickedNumber);
        isPlayerTurn = true;
      }
    });

    whoWon = gameEngine.api_check_who_won();

    if (whoWon != PLAY) {
      log('whoWon (second): $whoWon');
      isPlay = false;

      await displayWinnerDialog(whoWon);
      return;
    }
  }

  Future<void> displayWinnerDialog(int whoWon) async {
    var title = '';
    var content = '';
    switch (whoWon) {
      case WHITE:
        title = 'Congratulations!';
        content = 'You won!';
      case BLACK:
        title = 'Computer won!';
        content = 'You lost!';
      case DRAW:
        title = 'Hmmm';
        content = 'Draw';
      default:
        title = 'Interesting, lib returned:';
        content = 'whoWon: $whoWon';
    }

    await showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    ).then(
      (value) => {
        Navigator.pop(context),
        gameEngine.api_clean(),
        gameEngine.api_finish(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Expanded(
            flex: 8,
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: widget.maxRandomNumber,
              itemBuilder: (context, index) {
                int colorCode;
                if (!gameState.set.contains(index)) {
                  colorCode = 3;
                } else {
                  colorCode = gameState.white.contains(index)
                      ? 1
                      : gameState.black.contains(index)
                          ? 2
                          : 0;
                }

                final isSelected = gameState.white.contains(index) ||
                    gameState.black.contains(index);

                return NumberTile(
                  number: index,
                  colorCode: colorCode,
                  onPressed: isSelected || colorCode == 3 ? null : playerTurn,
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayerInfo(
                  playerName: 'Player',
                  selectedNumbers: gameState.white,
                  color: Colors.blue,
                ),
                PlayerInfo(
                  playerName: 'Computer',
                  selectedNumbers: gameState.black,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
