import 'package:flutter/cupertino.dart';
import '/breakfast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
          scaffoldBackgroundColor: CupertinoColors.systemGreen,
          brightness: Brightness.light),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
      child: BreakfastPage(),
    ));
  }
}
