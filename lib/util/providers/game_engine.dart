import 'dart:async';

import 'package:board_buzzle/models/tile.dart';
import 'package:flutter/foundation.dart';

/// this will detect the game status to apply deferent actions
enum GameStatus { firstRun, started, shuffled, playing, solved }

///the engine for the game you can use [firstRun] to start the board, then [shuffleTiles]
///to shuffle the tiles and start the game.
///[boardSize] is the maximum number of rows x columns
///[boardTotalTiles] the total number of tiles in the board
///[emptyTile] is detecting the empty tile to swap it when click on a tile beside it
class GameEngine extends ChangeNotifier {
  // essential Variables
  var gamestatus = GameStatus.firstRun;
  int boardSize = 4;
  int boardTotalTiles = 0;
  List<Tile> boardTiles = <Tile>[];
  List faceValues = [];
  List positions = [];
  List pos = [];
  Tile? emptyTile;
  int numberOfMoves = 0;
  int correctTiles = 0;

  // the time in seconds to send to the home page
  final ValueNotifier<int> timeInSeconds = ValueNotifier(0);

  //using the timer to create a seconds timer
  Timer? _timer;

// this to generat all the essential data to be used in starting the game
  _generateStartValues() {
    boardTotalTiles = boardSize * boardSize;
    gamestatus = GameStatus.firstRun;
    correctTiles = 0;
    numberOfMoves = 0;
    positions.clear();
    faceValues.clear();
    boardTiles.clear();
    //dimentions for every tile
    for (var c = 0; c < boardSize; c++) {
      for (var r = 0; r < boardSize; r++) {
        List pos = [];
        pos.add(c);
        pos.add(r);
        positions.add(pos);
      }
    }
    // the values for every tile
    faceValues.addAll(List.generate(boardTotalTiles, (index) => index + 1));
  }

  //this to generate a complete list of tiles with its complete data
  List<Tile> generateTiles(List pos, List values) {
    final List<Tile> tiles = [];
    for (var i = 0; i < faceValues.length; i++) {
      final tile = Tile.setAll(
        boardSize,
        pos[i][1],
        pos[i][0],
        values[i],
        values[i],
      );
      tiles.add(tile);
    }

    notifyListeners();
    return tiles;
  }

  //the start
  firstRun() {
    //generate values
    _generateStartValues();
    //add values to the tiles list
    boardTiles.addAll(generateTiles(positions, faceValues));
    //detect the empty tile position
    emptyTile =
        boardTiles.where((element) => element.value == boardTotalTiles).first;

    notifyListeners();
  }

  //for playing , need to shuffle the tiles to reorder it
  shuffleTiles() {
    if (_timer != null) {
      timeInSeconds.value = 0;
      _timer!.cancel();
    }

    //change to shufffled
    gamestatus = GameStatus.shuffled;
    //shuffle the positions
    positions.shuffle();
    //clear the existing tiles lit
    boardTiles.clear();
    //and new tiles after shuffled
    boardTiles.addAll(generateTiles(positions, faceValues));
    //detect the emty tile
    emptyTile =
        boardTiles.where((element) => element.value == boardTotalTiles).first;
    checkCorrectTiles();
    numberOfMoves = 0;
    notifyListeners();
    //reset the timer
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        timeInSeconds.value++;
      },
    );
  }

  int getTileCurrentPosition(Tile tile) {
    return (tile.columnValue! + (tile.rowValue! * boardSize) + 1);
  }

  //check if tile is movable
  bool movable(Tile tile) {
    int? ec = emptyTile?.columnValue; //empty tile column
    int? er = emptyTile?.rowValue; //empty tile row
    //tile in the same column of emty tile
    if (tile.columnValue == ec) {
      //tile is one row above or below
      if (tile.rowValue == (er! + 1) || tile.rowValue == (er - 1)) {
        return true;
      }
    }
    //tile in the same row of emty tile
    if (tile.rowValue == er) {
      //tile is one column right or left
      if (tile.columnValue == (ec! + 1) || tile.columnValue == (ec - 1)) {
        return true;
      }
    }
    return false;
  }

  //when click the tile swap it with the empty tile
  swapTile(Tile thisTile) {
    if (gamestatus == GameStatus.shuffled) {
      gamestatus == GameStatus.playing;
    }
    int? tempC = thisTile.columnValue;
    int? tempR = thisTile.rowValue;

    thisTile.columnValue = emptyTile?.columnValue;
    thisTile.rowValue = emptyTile?.rowValue;

    // int index =
    //     boardTiles.indexWhere((element) => element.value == emptyTile?.value);
    // boardTiles.removeAt(index);
    // boardTiles.insert(index, thisTile);;
    emptyTile?.columnValue = tempC;
    emptyTile?.rowValue = tempR;
    checkCorrectTiles();
    checkWin();
    notifyListeners();
  }

  //test positions to check for win
  bool checkWin() {
    bool t = false;
    for (var i = 0; i < boardTotalTiles; i++) {
      if (boardTiles[i].correctPosition ==
          getTileCurrentPosition(boardTiles[i])) {
        t = true;
      } else {
        t = false;
        break;
      }
    }
    if (t) {
      gamestatus = GameStatus.solved;
      _timer?.cancel();
    }
    notifyListeners();
    return t;
  }

  checkCorrectTiles() {
    int counter = 0;
    for (var i = 0; i < boardTotalTiles; i++) {
      if (boardTiles[i].value == getTileCurrentPosition(boardTiles[i])) {
        counter++;
      }
    }
    correctTiles = counter;
    notifyListeners();
  }

  @override
  void dispose() {
    //dispose the time

    _timer?.cancel();
    super.dispose();
  }
}
