import 'package:flutter/cupertino.dart';

class BreakfastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(
          'BREAKFAST',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CupertinoColors.systemBlue.withOpacity(0.5)),
          child: Table(
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: CupertinoColors.white,
                    child: Center(
                      child: Text('19'),
                    ),
                  ),
                ),
                Text(' November 2022')
              ])
            ],
          ),
        ),
      ]),
    );
  }
}
