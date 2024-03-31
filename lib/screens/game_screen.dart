import 'package:flutter/material.dart';
import 'package:szemeredi_game/widgets/number_tile.dart';
import 'package:szemeredi_game/widgets/player_info.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<int> numbers = List.generate(20, (index) => index + 1);
  List<int> selectedNumbersPlayer = [];
  List<int> selectedNumbersComputer = [];
  bool playerTurn = true;

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
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                final number = numbers[index];
                final colorCode = selectedNumbersPlayer.contains(number)
                    ? 1
                    : selectedNumbersComputer.contains(number)
                        ? 2
                        : 0;
                final isSelected = selectedNumbersPlayer.contains(number) ||
                    selectedNumbersComputer.contains(number);

                return NumberTile(
                  number: numbers[index],
                  colorCode: colorCode,
                  onPressed: isSelected
                      ? null
                      : (number) {
                          setState(() {
                            if (playerTurn) {
                              selectedNumbersPlayer.add(number);
                            } else {
                              selectedNumbersComputer.add(number);
                            }
                            playerTurn = !playerTurn;
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
                  selectedNumbers: selectedNumbersPlayer,
                ),
                PlayerInfo(
                  playerName: 'Computer',
                  selectedNumbers: selectedNumbersComputer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
