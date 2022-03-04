import 'package:board_buzzle/util/providers/game_engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameTimer extends StatelessWidget {
  const GameTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = Provider.of<GameEngine>(context, listen: false).timeInSeconds;
    return ValueListenableBuilder<int>(
      valueListenable: time,
      builder: (_, time, __) {
        return Text(
          viewAsTime(time),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        );
      },
    );
  }

  String viewAsTime(int time) {
    final duration = Duration(seconds: time);
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours.remainder(24).toString().padLeft(2, '0');

    return "$hours : $minutes : $seconds";
  }
}
