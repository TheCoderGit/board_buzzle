import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../util/infos/infos.dart';
import '../../../util/providers/game_engine.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<GameEngine>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          height: 1,
          color: Colors.deepPurple,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                child: Text(Infos.strings.buttonStartText),
                onPressed: engine.shuffleTiles,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: DropdownButton<int>(
                isExpanded: true,
                isDense: false,
                value: engine.boardSize,
                elevation: 16,
                items: const [
                  DropdownMenuItem(
                    child: Text(
                      '3 x 3   EASY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.cyan),
                    ),
                    value: 3,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      '4 x 4  MEDIUM',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                    value: 4,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      '5 x 5  HARD',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                    value: 5,
                  ),
                ],
                onChanged: (int? value) {
                  engine.boardSize = value!;
                  engine.firstRun();
                },
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          height: 1,
          color: Colors.deepPurple,
        ),
      ],
    );
  }
}
