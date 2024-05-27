import 'dart:ffi';

import 'package:szemeredi_game/utils/ffi_bindings.dart';

class GameState {
  GameState(this.set, this.white, this.black, this.toMove);

  GameState.fromState(ApiState state)
      : set = convertFfiArrayToList(state.set1),
        white = convertFfiArrayToList(state.white),
        black = convertFfiArrayToList(state.black),
        toMove = state.to_move;

  List<int> set;
  List<int> white;
  List<int> black;
  int toMove;

  static List<int> convertFfiArrayToList(int value) {
    final result = <int>[];
    var index = 0;

    // Convert the integer to a binary string.
    final binaryString = value.toRadixString(2).padLeft(64, '0');

    // Reverse the string to start from the least significant bit.
    final reversedBinaryString = binaryString.split('').reversed.join();

    // Iterate over the binary string.
    for (var bitPosition = 0; bitPosition < reversedBinaryString.length; bitPosition++) {
      if (reversedBinaryString[bitPosition] == '1') {
        // If the character is '1', calculate the actual number represented by the bit.
        result.add(index);
      }
      index++;
    }

    return result;
  }

}
