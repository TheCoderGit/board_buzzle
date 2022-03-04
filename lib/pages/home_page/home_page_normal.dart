import 'package:board_buzzle/util/providers/game_engine.dart';
import 'package:flutter/material.dart';
import '../../util/infos/infos.dart';
import 'Components/board.dart';
import 'Components/control_buttons.dart';
import 'Components/page_top.dart';
import 'package:provider/provider.dart';

class HomePageNormal extends StatelessWidget {
  const HomePageNormal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<GameEngine>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        const PageTop(),
        Flexible(
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 200,
              maxHeight: 400,
              minWidth: 200,
              maxWidth: 400,
            ),
            child: const Board(),
          ),
        ),
        const ControlButtons(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    Infos.strings.gameName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "${engine.numberOfMoves} Moves || ${engine.correctTiles} Correct Tiles",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  'images/puzzle.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
