import 'package:flutter/material.dart';
import 'package:szemeredi_game/widgets/number_tile.dart';

class PlayerInfo {
  PlayerInfo({required this.name, required this.longestSequence});

  final String name;
  final int longestSequence;
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<int> numbers = List.generate(20, (index) => index + 1);
  final List<PlayerInfo> players = [
    PlayerInfo(name: 'Player 1', longestSequence: 5), // Example data
    PlayerInfo(name: 'Player 2', longestSequence: 3), // Example data
  ];

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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return NumberTile(
                  number: numbers[index],
                  colorCode: 0,
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: players.map(_buildPlayerSection).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSection(PlayerInfo player) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blue, // Consider varying the color by player or other criteria
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(player.name, style: const TextStyle(color: Colors.white)),
            Text('Longest: ${player.longestSequence}', style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
