class Tile {
  int? columnValue;
  int? rowValue;
  int? value;
  int? correctPosition;
  int boardSize = 4;

  //   int? get value => _value;
  // set value(int? val) => _value = val;

  // int? get columnValue => _columnValue;
  // set columnValue(int? c) => _columnValue = c;

  // int? get rowValue => _rowValue;
  // set rowValue(int? r) => _rowValue = r;

  // int? get correctPosition => _correctPosition;
  // set correctPosition(int? cp) => _correctPosition = cp;

  Tile.setAll(
    bs,
    c,
    r,
    v,
    cp,
  ) {
    boardSize = bs;
    columnValue = c;
    rowValue = r;
    value = v;
    correctPosition = cp;
  }

  @override
  String toString() {
    return "$columnValue - $rowValue value: $value correct position: $correctPosition\n";
  }
}
