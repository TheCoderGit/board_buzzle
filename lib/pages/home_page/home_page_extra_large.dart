import 'package:flutter/material.dart';
import '../../util/infos/infos.dart';
import '../../util/providers/game_engine.dart';
import 'Components/board.dart';
import 'Components/control_buttons.dart';
import 'Components/page_top.dart';
import 'package:provider/provider.dart';

class HomePageExtraLarge extends StatelessWidget {
  const HomePageExtraLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<GameEngine>();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const PageTop(),
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
            Flexible(
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 200,
                  maxHeight: 550,
                  minWidth: 200,
                  maxWidth: 550,
                ),
                child: const Board(),
              ),
            ),
          ],
        ),
        const ControlButtons(),
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
    );
  }
}
