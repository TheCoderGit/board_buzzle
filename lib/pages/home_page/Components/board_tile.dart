import 'package:board_buzzle/util/infos/infos.dart';
import 'package:board_buzzle/util/providers/game_engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/tile.dart';

class BoardTile extends StatelessWidget {
  final double tileSize;
  final int boardColumns;
  final VoidCallback tapped;
  final Tile tile;
  const BoardTile({
    Key? key,
    required this.tileSize,
    required this.boardColumns,
    required this.tapped,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<GameEngine>();
    return AnimatedPositioned(
      duration:
          Duration(milliseconds: Infos.values.changePositionAnimationDuration),
      left: tileSize * (tile.columnValue!.toInt()),
      top: tileSize * (tile.rowValue!.toInt()),
      child: GestureDetector(
        onTap: tapped,
        child: AnimatedContainer(
          decoration: engine.boardTotalTiles != tile.value
              ? BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Infos.colors.tileShadow,
                      blurRadius: 5,
                    )
                  ],
                  color: engine.boardTotalTiles == tile.value
                      ? Infos.colors.transparentTile
                      : Infos.colors.tileColor,
                )
              : const BoxDecoration(),
          duration:
              Duration(milliseconds: Infos.values.changeColorAnimationDuration),
          height: tileSize - Infos.values.tilesSpacing,
          width: tileSize - Infos.values.tilesSpacing,
          alignment: Alignment.center,
          child: engine.boardSize * engine.boardSize == tile.value
              ? const Text("")
              : Text(
                  "${tile.value}",
                  style: TextStyle(
                      color: engine.getTileCurrentPosition(tile) ==
                              tile.correctPosition
                          ? Infos.colors.rightPlacedTileColor
                          : Infos.colors.wrongPlacedTileColor,
                      fontSize: tileSize * 0.4,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
// engine.getTileCurrentPosition(tile) == tile.correctPosition
//                   ? Infos.colors.rightPlacedTileColor
//                   : Infos.colors.wrongPlacedTileColor,