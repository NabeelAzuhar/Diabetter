import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BreakfastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'BREAKFAST',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 500,
          child: ListView(
            children: [
              Card(
                color: CupertinoColors.systemGrey3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, bottom: 5, right: 5),
                      child: Text(
                        '19 November 2022',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(2),
                        },
                        children: [
                          columnHeaders(),
                          userDataColumns('07:59', '200', '2', '20', 'Dead'),
                          userDataColumns('07:59', '200', '2', '20', 'Dead'),
                          userDataColumns('07:59', '200', '2', '20', 'Dead'),
                          userDataColumns('07:59', '200', '2', '20', 'Dead'),
                          userDataColumns('07:59', '200', '2', '20', 'Dead'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                color: CupertinoColors.systemGrey3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, bottom: 5, right: 5),
                      child: Text(
                        '20 November 2022',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(2),
                        },
                        children: [
                          columnHeaders(),
                          userDataColumns('07:59', '200', '2', '20', 'Dead')
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

TableRow dateHeader(int day, String monthYear) {
  return TableRow(children: [
    Row(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 20,
          width: 40,
          color: CupertinoColors.systemGrey.withOpacity(0.5),
          child: Center(
            child: Text(day.toString()),
          ),
        ),
      ),
      Text(monthYear)
    ])
  ]);
}

TableRow columnHeaders() {
  return TableRow(children: [
    Center(
      child: Container(
        height: 20,
        child: Text(
          'Time',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
    Center(
      child: Text(
        'Sugar',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Insulin',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Carbs',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Comments',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    )
  ]);
}

TableRow userDataColumns(time, sugar, insulin, carbs, comment) {
  return TableRow(children: [
    Center(
        child: Container(
      height: 20,
      child: Text(time),
    )),
    Center(child: Text(sugar)),
    Center(child: Text(insulin)),
    Center(child: Text(carbs)),
    Center(child: Text(comment)),
  ]);
}
