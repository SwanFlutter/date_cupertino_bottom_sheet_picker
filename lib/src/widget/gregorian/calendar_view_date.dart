import 'package:date_cupertino_bottom_sheet_picker/src/date_time_picker_gregorian.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A widget that displays a calendar view for selecting a date.
class CalendarViewDate extends StatefulWidget {
  /// The minimum age that can be selected.
  final num minAge;

  /// The currently selected date.
  final DateTime selectedDate;

  /// The first date that can be selected.
  final DateTime firstDate;

  /// The last date that can be selected.
  final DateTime lastDate;

  /// A [DateTimePickerGregorian] widget to display the date picker.
  final DateTimePickerGregorian dateCupertinoBottomSheetPicker;

  /// A callback function that is called when the date changes.
  final Function(DateTime dateTime) onChange;

  /// Creates a [CalendarViewDate] widget.
  ///
  /// Required parameters:
  /// - [minAge]: The minimum age that can be selected.
  /// - [selectedDate]: The currently selected date.
  /// - [firstDate]: The first date that can be selected.
  /// - [lastDate]: The last date that can be selected.
  /// - [dateCupertinoBottomSheetPicker]: A [DateTimePickerGregorian] widget to display the date picker.
  /// - [onChange]: A callback function that is called when the date changes.
  const CalendarViewDate({
    super.key,
    required this.minAge,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.dateCupertinoBottomSheetPicker,
    required this.onChange,
  });

  @override
  State<CalendarViewDate> createState() => _CalendarViewDateState();
}

class _CalendarViewDateState extends State<CalendarViewDate> {
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;
  late DateTime currentDate;

  @override
  void didUpdateWidget(covariant CalendarViewDate oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChange(currentDate);
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    currentDate = widget.selectedDate;

    yearController = FixedExtentScrollController(
        initialItem: getSelectedYearIndex(currentDate));
    monthController = FixedExtentScrollController(
        initialItem: getSelectedMonthIndex(currentDate));
    dayController = FixedExtentScrollController(
        initialItem: getSelectedDayIndex(currentDate));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.50,
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: yearController,
                      diameterRatio: 1.0,
                      itemExtent: 40,
                      onSelectedItemChanged: (value) async {
                        final y = getYears()[value];
                        final m = currentDate.month;
                        int dayCount = getDaysInMonth(y, m).length;
                        if (dayCount <= getSelectedDayIndex(currentDate)) {
                          final days = getDaysInMonth(y, m);
                          currentDate = DateTime(y, m, days.last);
                          dayController.jumpToItem(days.length - 1);
                        } else {
                          currentDate = DateTime(y, m, currentDate.day);
                        }
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            getYears()[index].toString(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                      childCount: getYears().length - widget.minAge.toInt(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: monthController,
                      diameterRatio: 1.0,
                      itemExtent: 40,
                      onSelectedItemChanged: (value) async {
                        final beforeDay = getSelectedDayIndex(currentDate);
                        int dayCount =
                            getDaysInMonth(currentDate.year, value + 1).length;
                        if (dayCount <= beforeDay) {
                          final days =
                              getDaysInMonth(currentDate.year, value + 1);
                          currentDate =
                              DateTime(currentDate.year, value + 1, days.last);
                          dayController.animateToItem(
                            days.length - 1,
                            curve: Curves.bounceIn,
                            duration: const Duration(milliseconds: 300),
                          );
                        } else {
                          currentDate = DateTime(
                              currentDate.year, value + 1, currentDate.day);
                        }
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            getMonths()[index],
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                      childCount: getMonths().length,
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: dayController,
                      diameterRatio: 1.0,
                      itemExtent: 40,
                      onSelectedItemChanged: (value) async {
                        currentDate = DateTime(
                            currentDate.year, currentDate.month, value + 1);
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            getDaysInMonth(
                                    currentDate.year, currentDate.month)[index]
                                .toString(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                      childCount:
                          getDaysInMonth(currentDate.year, currentDate.month)
                              .length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }

  int getMonthlyDate({required int year, required int month}) {
    int day = 0;
    switch (month) {
      case 1:
        day = 31;
        break;
      case 2:
        day = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28;
        break;
      case 3:
        day = 31;
        break;
      case 4:
        day = 30;
        break;
      case 5:
        day = 31;
        break;
      case 6:
        day = 30;
        break;
      case 7:
        day = 31;
        break;
      case 8:
        day = 31;
        break;
      case 9:
        day = 30;
        break;
      case 10:
        day = 31;
        break;
      case 11:
        day = 30;
        break;
      case 12:
        day = 31;
        break;

      default:
        day = 30;
        break;
    }
    return day;
  }

  List<int> getDaysInMonth(int year, int month) {
    // generate a list of days in the given month and year
    int numDays = getMonthlyDate(
      year: year,
      month: month,
    );
    return List.generate(numDays, (index) => index + 1);
  }

  List<int> getYears() {
    final startYear = widget.firstDate.year;
    final endYear = widget.lastDate.year;

    return List.generate(endYear - startYear + 1, (index) => startYear + index);
  }

  List<String> getMonths() {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
  }

  String getMonthName(int month) {
    return getMonths()[month - 1];
  }

  int getSelectedDayIndex(DateTime date) {
    return getDaysInMonth(date.year, date.month).indexOf(date.day);
  }

  int getSelectedYearIndex(DateTime date) {
    return getYears().indexOf(date.year);
  }

  int getSelectedMonthIndex(DateTime date) {
    return getMonths().indexOf(getMonthName(date.month));
  }
}
