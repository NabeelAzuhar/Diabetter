import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:you_wanna_live/breakfast.dart';

import 'user_data.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({Key? key}) : super(key: key);

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  DateTime dateTime = DateTime.now();
  final bloodSugarController = TextEditingController();
  final insulinController = TextEditingController();
  final carbsController = TextEditingController();
  final commentController = TextEditingController();

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system
              // navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
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

  String makeDoubleDigit(int num) {
    if (num / 10 < 1) {
      return '0$num';
    } else {
      return num.toString();
    }
  }

  void addNewEntry() {
    String date = '${dateTime.day}${dateTime.month}${dateTime.year}';
    String time = '${makeDoubleDigit(dateTime.hour)}:${makeDoubleDigit(dateTime.minute)}';
    String bloodSugar = bloodSugarController.text;
    String insulin = insulinController.text;
    String carbs = carbsController.text;
    String comment = commentController.text;
    List<String> newData = [time, bloodSugar, insulin, carbs, comment];

    if (UserData.userData.containsKey(date) && UserData.userData[date] != null) {
      List<String> previousValue = (UserData.userData[date] ?? ['error']).toList();
      UserData.userData[date] = previousValue + newData;
    } else {
    UserData.userData.addEntries({
      date: [time, bloodSugar, insulin, carbs, comment]
    }.entries);
  }

    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => BreakfastPage()));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    bloodSugarController.dispose();
    insulinController.dispose();
    carbsController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
            middle: const Text(
              'Ioanadie?',
              style: TextStyle(fontSize: 20),
            )),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Add New Entry',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  color: CupertinoColors.systemGrey6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Date',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            CupertinoButton(
                              onPressed: () => _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: dateTime,
                                  mode: CupertinoDatePickerMode.date,
                                  use24hFormat: true,
                                  // This is called when the user changes the date.
                                  onDateTimeChanged: (DateTime newDate) {
                                    setState(() => dateTime = newDate);
                                  },
                                ),
                              ),
                              child: Text(
                                  '${dateTime.day} ${getMonth(dateTime.month)} ${dateTime.year}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Time',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            CupertinoButton(
                              onPressed: () => _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: dateTime,
                                  mode: CupertinoDatePickerMode.time,
                                  use24hFormat: true,
                                  // This is called when the user changes the date.
                                  onDateTimeChanged: (DateTime newDate) {
                                    setState(() => dateTime = newDate);
                                  },
                                ),
                              ),
                              child: Text(
                                  '${makeDoubleDigit(dateTime.hour)}:${makeDoubleDigit(dateTime.minute)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Blood Sugar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: SizedBox(
                                width: 100,
                                child: CupertinoTextField(
                                  controller: bloodSugarController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Insulin',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: SizedBox(
                                width: 100,
                                child: CupertinoTextField(
                                  controller: insulinController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Carbohydrates',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: SizedBox(
                                width: 100,
                                child: CupertinoTextField(
                                  controller: carbsController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text('Comments',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        SizedBox(
                          height: 100,
                          child: CupertinoTextField(
                            controller: commentController,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoButton(
                      color: CupertinoColors.systemBlue,
                      child: const Text(
                        'Add Entry',
                        style: TextStyle(
                          fontSize: 18,
                          color: CupertinoColors.white,
                        ),
                      ),
                      onPressed: () => addNewEntry(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
