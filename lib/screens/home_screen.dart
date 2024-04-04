import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:szemeredi_game/screens/game_screen.dart';
import 'package:szemeredi_game/utils/ffi_bindings.dart';

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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sequenceLengthController = TextEditingController();
  final TextEditingController _numberOfRandomizedNumbersController = TextEditingController();
  final TextEditingController _maxRandomNumberController = TextEditingController();

  @override
  void dispose() {
    _sequenceLengthController.dispose();
    _numberOfRandomizedNumbersController.dispose();
    _maxRandomNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _sequenceLengthController,
                    decoration: const InputDecoration(
                      labelText: 'Length of Desired Sequence',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _numberOfRandomizedNumbersController,
                    decoration: const InputDecoration(
                      labelText: 'Number of Randomized Numbers',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _maxRandomNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Maximal Number for Randomization',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add validation or processing logic here if needed
                      Navigator.push(
                        context,
                        MaterialPageRoute<GameScreen>(
                          builder: (context) => GameScreen(
                            sequenceLength: int.parse(_sequenceLengthController.text),
                            numberOfRandomizedNumbers: int.parse(_numberOfRandomizedNumbersController.text),
                            maxRandomNumber: int.parse(_maxRandomNumberController.text),
                          ),
                          // Pass the settings to your game screen if needed
                        ),
                      );
                    },
                    child: const Text('Start Game'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
