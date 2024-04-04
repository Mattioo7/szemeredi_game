import 'dart:math';

import 'package:flutter/material.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({
    super.key,
    required this.playerName,
    required this.selectedNumbers,
    required this.color,
  });

  final String playerName;
  final List<int> selectedNumbers;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(playerName, style: const TextStyle(color: Colors.white)),
            Text(
              'Longest: ${longestArithSeqLength(selectedNumbers)}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  int longestArithSeqLength(List<int> numbers) {
    numbers.sort();
    if (numbers.length <= 2) {
      return numbers.length;
    }

    var maxLength = 2;
    // Maps to store the length of the arithmetic sequence ending at each index
    final dp = List<Map<int, int>>.generate(numbers.length, (_) => {});

    for (var j = 1; j < numbers.length; j++) {
      for (var i = 0; i < j; i++) {
        final diff = numbers[j] - numbers[i];

        // If there's already a sequence with this difference ending at i,
        // extend it. Otherwise, start a new sequence of length 2.
        dp[j][diff] = (dp[i][diff] ?? 1) + 1;

        // Update the maximum length found so far
        maxLength = max(maxLength, dp[j][diff]!);
      }
    }

    return maxLength;
  }
}
