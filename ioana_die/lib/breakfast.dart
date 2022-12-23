import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_data.dart';

import 'add_entry.dart';

class BreakfastPage extends StatelessWidget {
  final List dateList = UserData.userData.keys.toList();

  BreakfastPage({Key? key}) : super(key: key);

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
              child: const Icon(CupertinoIcons.add),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const AddEntry()));
              }),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
            child: Center(
                child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Breakfast',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black),
                  ),
                ),
                SizedBox(
                  height: 600,
                  child: ListView(
                    children: userCardsList(dateList),
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}

String getMonth(int month) {
  switch (month) {
    case 1:
      {
        return 'January';
      }
    case 2:
      {
        return 'February';
      }
    case 3:
      {
        return 'March';
      }
    case 4:
      {
        return 'April';
      }
    case 5:
      {
        return 'May';
      }
    case 6:
      {
        return 'June';
      }
    case 7:
      {
        return 'July';
      }
    case 8:
      {
        return 'August';
      }
    case 9:
      {
        return 'September';
      }
    case 10:
      {
        return 'October';
      }
    case 11:
      {
        return 'November';
      }
    case 12:
      {
        return 'December';
      }
    default:
      return 'Error';
  }
}

TableRow dateHeader(int day, String monthYear) {
  return TableRow(children: [
    Row(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
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
  return const TableRow(children: [
    Center(
      child: SizedBox(
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
        child: SizedBox(
      height: 20,
      child: Text(time),
    )),
    Center(child: Text(sugar)),
    Center(child: Text(insulin)),
    Center(child: Text(carbs)),
    Center(child: Text(comment)),
  ]);
}

Card dataCard(String date, List<String> dateData) {
  // Formatting the date in the database into the format that will be displayed on the card
  String day = date.substring(0, 2);
  String month = date.substring(2, 4);
  month = getMonth(int.parse(month));
  String year = date.substring(4);
  String cardDate = '$day $month $year';

  // Finding number of entries for each date
  double totalEntries = (dateData.length / 5);

  // Creating a card
  return Card(
    // Card design
    color: CupertinoColors.systemGrey6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
          child: Text(
            cardDate,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(2),
            },
            children: [
              // Column Headers
              columnHeaders(),
              // Filling card with formatted user data
              for (var entry = 0; entry < totalEntries; entry++)
                userDataColumns(
                    dateData[(entry * 5)],
                    dateData[(entry * 5) + 1],
                    dateData[(entry * 5) + 2],
                    dateData[(entry * 5) + 3],
                    dateData[(entry * 5) + 4]),
            ],
          ),
        )
      ],
    ),
  );
}

List<Widget> userCardsList(List dateList) {
  List<Widget> cardList = [];
  for (int i = 0; i < dateList.length; i++) {
    cardList.add(
        // Text('Hi'));
        dataCard(dateList[i], UserData.userData[dateList[i]] ?? ['error']));
  }
  return cardList;
}
