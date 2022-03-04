import 'package:board_buzzle/pages/home_page/Components/board_tile.dart';
import 'package:board_buzzle/util/infos/infos.dart';
import 'package:board_buzzle/util/providers/game_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<GameEngine>();
    if (engine.gamestatus == GameStatus.firstRun) {
      // WidgetsBinding.instance!.addPostFrameCallback((_) {
      // engine.firstRun();
      // engine.gamestatus = GameStatus.started;
      //});
      Future.delayed(Duration.zero, () async {
        // force the orientation to be portrait
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        engine.firstRun();
        engine.gamestatus = GameStatus.started;
        //to test the dialog presentation
        // showWinDialog(context, engine.numberOfMoves,
        //     viewAsTime(engine.timeInSeconds.value));
      });
    } else if (engine.gamestatus == GameStatus.solved) {
      Future.delayed(Duration.zero, () async {
        showWinDialog(context, engine.numberOfMoves,
            viewAsTime(engine.timeInSeconds.value));
      });
    }
    return Padding(
      padding: const EdgeInsets.all(4),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 300,
            maxHeight: 300,
            minHeight: 200,
            minWidth: 200,
          ),
          decoration: BoxDecoration(
            color: Infos.colors.boardColor,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Infos.colors.tileShadow,
                blurRadius: 5,
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(Infos.values.tilesSpacing.toDouble(),
              Infos.values.tilesSpacing.toDouble(), 0, 0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: engine.boardTiles
                    .map(
                      (e) => BoardTile(
                        tileSize: constraints.maxWidth / engine.boardSize,
                        boardColumns: engine.boardSize,
                        tapped: () {
                          if (engine.gamestatus == GameStatus.shuffled ||
                              engine.gamestatus == GameStatus.playing) {
                            if (engine.movable(e)) {
                              engine.swapTile(e);
                              engine.numberOfMoves++;
                            }
                          }
                        },
                        tile: e,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

String viewAsTime(int time) {
  final duration = Duration(seconds: time);
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final hours = duration.inHours.remainder(24).toString().padLeft(2, '0');

  return "$hours : $minutes : $seconds";
}

void showWinDialog(BuildContext ctx, int moves, String time) {
  showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            "Congratulations !",
            style: TextStyle(color: Colors.green),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints.expand(
                  width: 200,
                  height: 200,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/win.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                  "Congratulations you Solved the Puzzle. you did it in: \n\n Time: $time \n Moves: $moves"),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text("OK"))
          ],
        );
      });
}
