import 'package:board_buzzle/pages/pages.dart';
import 'package:board_buzzle/util/infos/infos.dart';
import 'package:board_buzzle/util/providers/game_engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Infos.strings.gameName,
      theme: ThemeData(
        primarySwatch: Infos.colors.primarySwatch,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Infos.colors.buttonColor),
        ),
      ),
      home: ChangeNotifierProvider(
          create: (context) => GameEngine(), child: const HomePage()),
    );
  }
}
