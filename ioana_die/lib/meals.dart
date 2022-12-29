import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_data.dart';
import 'add_entry.dart';

class MealPage extends StatefulWidget {
  const MealPage({Key? key}) : super(key: key);
  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  // pagNumber will be used to ensure that the right meal page is loaded
  int pageNumber = 0;

  // A function that returns a TableRow object containing the date in DD MMM YYYY format
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

// A function that returns a TableRow with all the column headers for the data to be organized in
  TableRow columnHeaders() {
    return const TableRow(children: [
      // Time in HH:MM format
      TableCell(
          child: Center(
        child: SizedBox(
          height: 22,
          child: Text(
            'Time',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      )),
      // Blood Sugar
      TableCell(
        child: Center(
            child: SizedBox(
          height: 22,
          child: Text(
            'Sugar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
      ),
      // Insulin levels
      TableCell(
        child: Center(
            child: SizedBox(
                height: 22,
                child: Text(
                  'Insulin',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
      ),
      // Carbohydrate intake
      TableCell(
        child: Center(
            child: SizedBox(
                height: 22,
                child: Text(
                  'Carbs',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
      ),
      // Comments or remarks from the user
      TableCell(
          child: Center(
              child: SizedBox(
                  height: 22,
                  child: Text(
                    'Comments',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )))),
      // Delete?
      TableCell(
          child: Center(
              child: SizedBox(
        height: 22,
        child: Text(
          'Delete?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ))),
    ]);
  }

// A function that returns a TableRow containing one entry to the table
  TableRow userDataColumns(
      int index, String date, time, sugar, insulin, carbs, comment) {
    return TableRow(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          color: CupertinoColors.systemGrey5,
        ),
        children: [
          TableCell(
            child: Center(child: Text(time)),
          ),
          TableCell(child: Center(child: Text(sugar))),
          TableCell(child: Center(child: Text(insulin))),
          TableCell(child: Center(child: Text(carbs))),
          TableCell(
            child: Center(
                child: Text(
              comment,
              textAlign: TextAlign.center,
            )),
          ),
          TableCell(
            child: Center(
                child: IconButton(
              onPressed: () {
                deleteRow(index, date, [time, sugar, insulin, carbs, comment]);
              },
              icon: const Icon(CupertinoIcons.delete, size: 20),
            )),
          )
        ]);
  }

  void deleteRow(int index, String date, List currentData) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Are you sure you want to delete this entry?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            onPressed: () {
              List<String> oldData = UserData.userData[index][date]!;
              for (int i = 0; i < oldData.length; i = i + 5) {
                if (oldData[i] == currentData[0] &&
                    oldData[i + 1] == currentData[1] &&
                    oldData[i + 2] == currentData[2] &&
                    oldData[i + 3] == currentData[3] &&
                    oldData[i + 4] == currentData[4]) {
                  oldData.removeRange(i, i + 5);
                  if (oldData.isEmpty) {
                    UserData.userData[index].remove(date);
                  } else{
                    UserData.userData[index][date] = oldData;
                  }
                  break;
                }
              }
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

// A function that returns a Card containing the Date header, the column headers and the entries recorded on that day
  Card dataCard(int index, String date, List<String> dateData) {
    // Formatting the date in the database into the format that will be displayed on the card
    String day = date.substring(0, 2);
    String month = date.substring(2, 4);
    month = getMonth(int.parse(month));
    String year = date.substring(4);
    String cardDate = '$day $month $year';

    // Finding number of entries for each date
    int totalEntries = dateData.length ~/ 5;

    // Creating a card
    return Card(
      // Card design
      color: CupertinoColors.systemGrey6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
            child: Text(
              cardDate,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              // border: const TableBorder(
              //   horizontalInside:
              //       BorderSide(width: 1, color: CupertinoColors.systemGrey),
              // ),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(2),
                5: FlexColumnWidth(1),
              },
              children: [
                // Column Headers
                columnHeaders(),
                // Filling card with formatted user data in reverse order (the latest being at the top)
                for (var entry = totalEntries - 1; entry >= 0; entry--)
                  userDataColumns(
                      index,
                      date,
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

// A function that returns a List of Cards that contain all the days with all the user entries
  List<Widget> userCardsList(int index) {
    // Creating a List of all the days when entries have been recorded for any meal
    final List dateList = UserData.userData[index].keys.toList();
    List<Widget> cardList = [];
    // Filling up each card with the date and entries from oldest card to newest card
    for (int i = 0; i < dateList.length; i++) {
      cardList.add(dataCard(index, dateList[i],
          UserData.userData[index][dateList[i]] ?? ['error']));
    }
    // Reversing the order of the cards so that the latest card is first
    cardList = cardList.reversed.toList();
    return cardList;
  }

// A function that returns a SafeArea which layouts the template upon which the cards will be displayed
  SafeArea mealPage(String meal, int index) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                meal,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black),
              ),
            ),
            SizedBox(
              height: 600,
              child: ListView(
                children: userCardsList(index),
              ),
            ),
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // idx ensure the right meal name is fed to the Add Entry page
    late int idx;
    // returning the layout of the meals page
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemGrey.withOpacity(1),
          middle: const Text(
            'Ioanadie?',
            style: TextStyle(fontSize: 20),
          ),
          // removes the back button
          automaticallyImplyLeading: false,
          // implements a plus sign button that will lead to the Add Entry page
          trailing: CupertinoButton(
              child: const Icon(CupertinoIcons.add),
              onPressed: () async {
                pageNumber = await Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => AddEntry(
                              mealIndex: idx,
                            )));
                setState(() {});
              }),
        ),
        // PageView.builder implements 6 horizontally scrollable pages, each containing a meal
        child: PageView.builder(
          controller: PageController(initialPage: pageNumber),
          itemBuilder: (BuildContext context, int index) {
            // initilaizing the mealName and idx that will be used to create the cards and pass data to the Add Entry page
            String mealName;
            idx = index;

            // index 0 to 5 corresponds to the six meal times
            switch (index) {
              case 0:
                mealName = 'Breakfast';
                break;
              case 1:
                mealName = 'Morning Tea';
                break;
              case 2:
                mealName = 'Lunch';
                break;
              case 3:
                mealName = 'Supper';
                break;
              case 4:
                mealName = 'Dinner';
                break;
              case 5:
                mealName = 'Dessert';
                break;
              default:
                mealName = 'Error';
            }

            return mealPage(mealName, index);
          },
          itemCount: 6,
        ));
  }
}

// A function returns a String containing the name of the month for the corresponding month number inputted
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
