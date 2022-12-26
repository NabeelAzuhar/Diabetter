import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_data.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({Key? key, required this.mealIndex}) : super(key: key);
  final int mealIndex;

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  // dateTime reflects the current time
  DateTime dateTime = DateTime.now();
  // initilaizing controllers to collect data
  final bloodSugarController = TextEditingController();
  final insulinController = TextEditingController();
  final carbsController = TextEditingController();
  final commentController = TextEditingController();
  // initilizing the meal names
  final List<String> _mealNames = <String>[
    'Breakfast',
    'Morning Tea',
    'Lunch',
    'Supper',
    'Dinner',
    'Dessert'
  ];
  // initilizing two variables to control data flow
  bool selectedMealBool = false;
  late int selectedMeal;

  // A fucntion that creates a popup dialog from the bottom
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

  // A function that creates a pop up alert dialog to ensure that the user has entered their blood sugar levels
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Please enter your blood sugar level'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // A function that records the data entered in the form and updates the userData database
  void addNewEntry() {
    // Extracting data from the form in a format that is consistent with the database
    String time =
        '${makeDoubleDigit(dateTime.hour)}:${makeDoubleDigit(dateTime.minute)}';
    String bloodSugar = bloodSugarController.text;
    String insulin = insulinController.text;
    String carbs = carbsController.text;
    String comment = commentController.text;
    
    // Creating a list that reflects the key and value of the map in the database
    String date = '${dateTime.day}${dateTime.month}${dateTime.year}';
    List<String> newData = [time, bloodSugar, insulin, carbs, comment];

    // Error check that will pop up an Alert Dialog if the blood sugar data is empty
    if (bloodSugar == '') {
      _showAlertDialog(context);
      return;
    }

    // If check to update data if input date is present and to add a new record if the input date is not present
    if (UserData.userData[selectedMeal].containsKey(date) &&
        UserData.userData[selectedMeal][date] != null) {
      List<String> previousValue =
          (UserData.userData[selectedMeal][date] ?? ['error']).toList();
      UserData.userData[selectedMeal][date] = previousValue + newData;
    } else {
      UserData.userData[selectedMeal].addEntries({
        date: [time, bloodSugar, insulin, carbs, comment]
      }.entries);
    }

    // Returns to the meals page while passing along information of which meals page the user is to be directed to
    Navigator.pop(context, selectedMeal);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    bloodSugarController.dispose();
    insulinController.dispose();
    carbsController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Keeps the selectedMeal value at the value of the page from which the user was directed from
    if (selectedMealBool == false) {
      selectedMeal = widget.mealIndex;
      selectedMealBool = true;
    }
    return CupertinoPageScaffold(
        // to prevent resizing problems from the occurance of the modal popup window
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
            middle: const Text(
              'Ioanadie?',
              style: TextStyle(fontSize: 20),
            )),
        child: 
        // Creating the template to fill in user data
        SafeArea(
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
                // One card that contains all the user data inputs followed by a button to submit the data
                Card(
                  color: CupertinoColors.systemGrey6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Data entry for meal time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Meal',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            CupertinoButton(
                              onPressed: () => _showDialog(
                                CupertinoPicker(
                                    magnification: 1.22,
                                    squeeze: 1.2,
                                    useMagnifier: true,
                                    itemExtent: 32.0,
                                    scrollController:
                                    // Ensures that the picker begins at the meal time from which the user clicked the add button
                                        FixedExtentScrollController(
                                            initialItem: widget.mealIndex),
                                    // changes the item as the picker is scrolled
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        selectedMeal = selectedItem;
                                      });
                                    },
                                    // list of all the available picker options
                                    children: List<Widget>.generate(
                                        _mealNames.length, (int index) {
                                      return Center(
                                        child: Text(
                                          _mealNames[index],
                                        ),
                                      );
                                    })),
                              ),
                              // shows currently chosen option on the form
                              child: Text(_mealNames[selectedMeal],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  )),
                            ),
                          ],
                        ),
                        // Data entry for date
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
                              // shows currently chosen on the form
                              child: Text(
                                  '${dateTime.day} ${getMonth(dateTime.month)} ${dateTime.year}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  )),
                            ),
                          ],
                        ),
                        // Data entry for time
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
                              // shows currently chosen on the form
                              child: Text(
                                  '${makeDoubleDigit(dateTime.hour)}:${makeDoubleDigit(dateTime.minute)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  )),
                            ),
                          ],
                        ),
                        // Data entry for blood sugar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Blood Sugar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: SizedBox(
                                width: 100,
                                child: CupertinoTextField(
                                  controller: bloodSugarController,
                                  // to allow for only numerical input
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Data entry for insulin level
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Insulin',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: SizedBox(
                                width: 100,
                                child: CupertinoTextField(
                                  controller: insulinController,
                                  // to allow for only numerical input
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Data entry for carbohydrate intake
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Carbohydrates',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: SizedBox(
                                width: 100,
                                child: CupertinoTextField(
                                  controller: carbsController,
                                  // to allow for only numerical input
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Data entry for user comments or remarks
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
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Button to submit data
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

// A function that returns a String representation of any one digit number as two digit  numbers
String makeDoubleDigit(int num) {
  if (num / 10 < 1) {
    return '0$num';
  } else {
    return num.toString();
  }
}