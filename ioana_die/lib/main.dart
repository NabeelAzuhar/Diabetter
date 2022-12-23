import 'package:flutter/cupertino.dart';
import '/breakfast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
          scaffoldBackgroundColor: CupertinoColors.white,
          brightness: Brightness.light),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BreakfastPage();
  }
}
