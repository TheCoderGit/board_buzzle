import 'package:flutter/material.dart';

class Infos {
  //strings
  static Strings strings = Strings();

  //colors
  static MyColors colors = MyColors();

  //Values
  static MyValues values = MyValues();
}

class Strings {
  Strings();
  String get gameName => "Flutter Challenge";
  String get buttonStartText => "Start";
}

class MyColors {
  MyColors();
  MaterialColor primarySwatch = Colors.blue;
  Color? wrongPlacedTileColor = Colors.red;
  Color? rightPlacedTileColor = Colors.green[800];
  Color? tileColor = Colors.grey[200];
  Color tileShadow = Colors.black26;
  Color transparentTile = Colors.transparent;
  Color? boardColor = Colors.grey[200];
  Color? buttonColor = Colors.pink[800];
}

class MyValues {
  MyValues();
  int get changePositionAnimationDuration => 200;
  int get changeColorAnimationDuration => 500;
  int get tilesSpacing => 8;
}
