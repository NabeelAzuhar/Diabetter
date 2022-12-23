import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BreakfastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
          middle: const Text(
            'Ioanadie?',
            style: TextStyle(fontSize: 20),
          ),
          trailing: CupertinoButton(
              child: Icon(CupertinoIcons.add), onPressed: () {}),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
          child: Center(
              child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70),
                child: Text(
                  'Breakfast',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.black),
                ),
              ),
              SizedBox(
                height: 500,
                child: ListView(
                  children: [
                    Card(
                      color: CupertinoColors.systemGrey6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
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
                                userDataColumns(
                                    '07:59', '200', '2', '20', 'Dead'),
                                userDataColumns(
                                    '07:59', '200', '2', '20', 'Dead'),
                                userDataColumns(
                                    '07:59', '200', '2', '20', 'Dead'),
                                userDataColumns(
                                    '07:59', '200', '2', '20', 'Dead'),
                                userDataColumns(
                                    '07:59', '200', '2', '20', 'Dead'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      color: CupertinoColors.systemGrey6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                                userDataColumns(
                                    '07:59', '200', '2', '20', 'Dead')
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
          )),
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
