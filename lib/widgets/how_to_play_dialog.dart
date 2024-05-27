import 'package:flutter/material.dart';

class HowToPlayDialog extends StatelessWidget {
  const HowToPlayDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Jak grać?'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Cel gry:'),
            Text(
                'Celem gry jest ułożenie monochromatycznego ciągu arytmetycznego o zadanej długości k.'),
            SizedBox(height: 10),
            Text('Dane wejściowe:'),
            Text('- Liczba naturalna k (długość ciągu arytmetycznego).'),
            Text('- Liczba naturalna x (liczba elementów w zbiorze X).'),
            Text('- Liczba naturalna m (zakres zbioru, z którego losujemy 0..m).'),
            SizedBox(height: 10),
            Text('Przygotowanie gry:'),
            Text('1. Komputer losuje zbiór X złożony z x liczb naturalnych.'),
            Text('2. Każdy gracz otrzymuje swój unikalny kolor.'),
            SizedBox(height: 10),
            Text('Przebieg gry:'),
            Text(
                '1. Gra rozpoczyna się od losowania zbioru X przez komputer.'),
            Text('2. Gracze wykonują ruchy na zmianę.'),
            Text(
                '3. Ruch gracza polega na wybraniu jednej niepokolorowanej liczby ze zbioru X i pokolorowaniu jej swoim kolorem.'),
            Text(
                '4. Gra toczy się do momentu, aż któryś z graczy ułoży monochromatyczny ciąg arytmetyczny o długości k.'),
            SizedBox(height: 10),
            Text('Zasady wygranej:'),
            Text(
                'Grę wygrywa ten gracz, który jako pierwszy ułoży monochromatyczny ciąg arytmetyczny o długości k.'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Zamknij'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
