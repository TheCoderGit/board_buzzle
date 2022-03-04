import 'package:board_buzzle/pages/home_page/Components/game_timer.dart';
import 'package:flutter/material.dart';

class PageTop extends StatelessWidget {
  const PageTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(Icons.alarm),
            SizedBox(
              width: 8,
            ),
            GameTimer(),
          ],
        ),
        decoration: const BoxDecoration(),
      ),
    );
  }
}
