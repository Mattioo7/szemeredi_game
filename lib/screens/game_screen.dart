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
    final setup = gameEngine.api_setup(widget.sequenceLength, widget.numberOfRandomizedNumbers, widget.maxRandomNumber);
    log('Setup: $setup');

    if (init != 0 || setup != 0) {
      Navigator.pop(context);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong, please try again.')),
        );
      });
    }

    final state = gameEngine.api_get_state();
    gameState = GameState.fromState(state);
  }

  late final DynamicLibrary dylib;
  late final SzemerediGameEngine gameEngine;
  late final GameState gameState;

  bool playerTurn = true;

  Future<void> computerTurn() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    setState(() {
      final pickedNumber = gameEngine.api_think();
      log('Computer picked: $pickedNumber');
      gameEngine.api_move(pickedNumber);
      gameState.black.add(pickedNumber);
      playerTurn = !playerTurn;
    });
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
              itemCount: gameState.set.length,
              itemBuilder: (context, index) {
                final number = gameState.set[index];
                final colorCode = gameState.white.contains(number)
                    ? 1
                    : gameState.black.contains(number)
                        ? 2
                        : 0;
                final isSelected = gameState.white.contains(number) ||
                    gameState.black.contains(number);

                return NumberTile(
                  number: gameState.set[index],
                  colorCode: colorCode,
                  onPressed: isSelected
                      ? null
                      : (number) {
                          setState(() {
                            if (playerTurn) {
                              gameState.white.add(number);
                              gameEngine.api_move(number);
                              playerTurn = !playerTurn;
                              if (!playerTurn) {
                                computerTurn();
                              }
                            }
                          });
                        },
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
