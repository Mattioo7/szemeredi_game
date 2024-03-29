import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:szemeredi_game/generated/ffi_bindings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState() {
    dylib = DynamicLibrary.open('game_engine/libengine.so');
    gameEngine = SzemerediGameEngine(dylib);
  }

  late final DynamicLibrary dylib;
  late final SzemerediGameEngine gameEngine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
    );
  }
}
