import 'package:flutter/material.dart';
import 'package:szemeredi_game/screens/game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState();

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
        title: const Text('Szemeredi Game Demo'),
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
                    validator: (value) {
                      if (int.tryParse(value ?? '') == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _numberOfRandomizedNumbersController,
                    decoration: const InputDecoration(
                      labelText: 'Number of Randomized Numbers',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (int.tryParse(value ?? '') == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _maxRandomNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Maximal Number for Randomization',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (int.tryParse(value ?? '') == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (!(_formKey.currentState?.validate() ?? true)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter valid numbers')),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute<GameScreen>(
                          builder: (context) => GameScreen(
                            sequenceLength: int.tryParse(_sequenceLengthController.text) ?? 0,
                            numberOfRandomizedNumbers: int.tryParse(_numberOfRandomizedNumbersController.text) ?? 0,
                            maxRandomNumber: int.tryParse(_maxRandomNumberController.text) ?? 0,
                          ),
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
