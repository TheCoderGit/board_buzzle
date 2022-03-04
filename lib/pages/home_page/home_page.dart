import 'package:flutter/material.dart';

import '../pages.dart';

enum ScreenSize { small, normal, large, extraLarge }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  ScreenSize getSize(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceWidth > 900) return ScreenSize.extraLarge;
    if (deviceWidth > 600) return ScreenSize.large;
    if (deviceWidth > 300) return ScreenSize.normal;
    return ScreenSize.small;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getSize(context) == ScreenSize.extraLarge
            ? const HomePageExtraLarge()
            : getSize(context) == ScreenSize.large
                ? const HomePageLarge()
                : getSize(context) == ScreenSize.normal
                    ? const HomePageNormal()
                    : const HomePageSmall(),
      ),
    );
  }
}
