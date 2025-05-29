import 'package:date_cupertino_bottom_sheet_picker/src/extensions/default.dart';
import 'package:flutter/cupertino.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PersianDatePicker extends StatefulWidget {
  final Jalali selectedDate;
  final Jalali firstDate;
  final Jalali lastDate;
  final Function(Jalali) onDateChanged;
  final num minAge;
  final Color dividerColor;

  const PersianDatePicker({
    super.key,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateChanged,
    required this.minAge,
    required this.dividerColor,
  });

  @override
  State<PersianDatePicker> createState() => _PersianDatePickerState();
}

class _PersianDatePickerState extends State<PersianDatePicker> {
  late Jalali currentDate;
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;

  @override
  void initState() {
    super.initState();
    currentDate = widget.selectedDate;

    // Log the initial date
    debugPrint("PersianDatePicker initState - Initial date: $currentDate");

    // Initialize the controllers
    yearController = FixedExtentScrollController(
        initialItem: getSelectedYearIndex(currentDate));
    monthController = FixedExtentScrollController(
        initialItem: getSelectedMonthIndex(currentDate));
    dayController = FixedExtentScrollController(
        initialItem: getSelectedDayIndex(currentDate));
  }

  @override
  void didUpdateWidget(PersianDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update the current date and controllers if the selected date has changed
    if (widget.selectedDate != oldWidget.selectedDate) {
      currentDate = widget.selectedDate;
      yearController.jumpToItem(getSelectedYearIndex(currentDate));
      monthController.jumpToItem(getSelectedMonthIndex(currentDate));
      dayController.jumpToItem(getSelectedDayIndex(currentDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CupertinoPicker.builder(
              scrollController: yearController,
              itemExtent: 60,
              onSelectedItemChanged: (value) {
                final y = getYears()[value];
                final m = currentDate.month;

                int dayCount = getDaysInMonth(y, m).length;
                if (dayCount <= getSelectedDayIndex(currentDate)) {
                  final days = getDaysInMonth(y, m);
                  currentDate = Jalali(y, m, days[days.length - 1]);
                } else {
                  currentDate = Jalali(y, m, currentDate.day);
                }

                widget.onDateChanged(currentDate);
                setState(() {});
              },
              childCount: getYears().length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    convertToPersianDigits(getYears()[index]),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: CupertinoPicker.builder(
              scrollController: monthController,
              itemExtent: 60,
              onSelectedItemChanged: (value) {
                final m = getMonths()[value];
                final y = currentDate.year;

                int dayCount = getDaysInMonth(y, m).length;
                if (dayCount <= getSelectedDayIndex(currentDate)) {
                  final days = getDaysInMonth(y, m);
                  currentDate = Jalali(y, m, days[days.length - 1]);
                } else {
                  currentDate = Jalali(y, m, currentDate.day);
                }

                widget.onDateChanged(currentDate);
                setState(() {});
              },
              childCount: getMonths().length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    convertToPersianDigits(getMonths()[index]),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: CupertinoPicker.builder(
              scrollController: dayController,
              itemExtent: 60,
              onSelectedItemChanged: (value) {
                final d = getDays()[value];
                final y = currentDate.year;
                final m = currentDate.month;

                currentDate = Jalali(y, m, d);

                widget.onDateChanged(currentDate);
                setState(() {});
              },
              childCount: getDays().length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    convertToPersianDigits(getDays()[index]),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<int> getYears() {
    return List<int>.generate(widget.lastDate.year - widget.firstDate.year + 1,
        (index) => widget.firstDate.year + index);
  }

  int getSelectedYearIndex(Jalali date) {
    return getYears().indexOf(date.year);
  }

  List<int> getMonths() {
    return List<int>.generate(12, (index) => index + 1);
  }

  int getSelectedMonthIndex(Jalali date) {
    return getMonths().indexOf(date.month);
  }

  List<int> getDays() {
    return List<int>.generate(
        Jalali(currentDate.year, currentDate.month, 1).monthLength,
        (index) => index + 1);
  }

  int getSelectedDayIndex(Jalali date) {
    return getDays().indexOf(date.day);
  }

  List<int> getDaysInMonth(int year, int month) {
    return List<int>.generate(
        Jalali(year, month, 1).monthLength, (index) => index + 1);
  }
}

/// Persian
/// A widget that displays a Persian time picker.
class PersianTimePicker extends StatefulWidget {
  /// The initial time to display.
  final String initialTime;

  /// A callback function that is called when the time changes.
  final Function(String time) onTimeChanged;

  /// The color of the divider.
  final Color dividerColor;

  /// Creates a [PersianTimePicker] widget.
  ///
  /// Required parameters:
  /// - [initialTime]: The initial time to display.
  /// - [onTimeChanged]: A callback function that is called when the time changes.
  /// - [dividerColor]: The color of the divider.
  const PersianTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
    required this.dividerColor,
  });

  @override
  State<PersianTimePicker> createState() => _PersianTimePickerState();
}

class _PersianTimePickerState extends State<PersianTimePicker> {
  late int selectedHour;
  late int selectedMinute;
  late bool isAM;
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  @override
  void initState() {
    super.initState();
    try {
      final timeParts = widget.initialTime.split(':');
      int rawHour = int.parse(timeParts[0]);

      // Safeguard against invalid format
      final minuteAndPeriod = timeParts[1].split(' ');
      selectedMinute = int.parse(minuteAndPeriod[0]);

      // Check for AM/PM
      String period = minuteAndPeriod.length > 1 ? minuteAndPeriod[1] : '';
      isAM = period == 'صبح';

      // Convert 24-hour format to 12-hour format for display
      if (rawHour == 0) {
        selectedHour = 12; // 0 hour in 24-hour format is 12 AM
        isAM = true;
      } else if (rawHour == 12) {
        selectedHour = 12; // 12 hour in 24-hour format is 12 PM
        isAM = false;
      } else if (rawHour > 12) {
        selectedHour = rawHour - 12; // Convert PM hours
        isAM = false;
      } else {
        selectedHour = rawHour; // AM hours stay the same
        isAM = true;
      }

      // Override AM/PM if explicitly specified
      if (period == 'بعد از ظهر') {
        isAM = false;
      } else if (period == 'صبح') {
        isAM = true;
      }

      // Ensure selectedHour is between 1-12 for the picker
      if (selectedHour == 0) selectedHour = 12;
      if (selectedHour > 12) selectedHour = selectedHour % 12;
      if (selectedHour == 0) selectedHour = 12;

      // Initialize controllers with correct positions
      hourController =
          FixedExtentScrollController(initialItem: (selectedHour - 1) % 12);
      minuteController =
          FixedExtentScrollController(initialItem: selectedMinute);
    } catch (e) {
      // Fallback to default time in case of error
      selectedHour = 12;
      selectedMinute = 0;
      isAM = true;
      hourController = FixedExtentScrollController(initialItem: 0);
      minuteController = FixedExtentScrollController(initialItem: 0);
    }
  }

  @override
  void didUpdateWidget(PersianTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTime != oldWidget.initialTime) {
      try {
        final timeParts = widget.initialTime.split(':');
        int rawHour = int.parse(timeParts[0]);
        final minuteAndPeriod = timeParts[1].split(' ');
        selectedMinute = int.parse(minuteAndPeriod[0]);
        String period = minuteAndPeriod.length > 1 ? minuteAndPeriod[1] : '';
        isAM = period == 'صبح';

        if (rawHour == 0) {
          selectedHour = 12;
          isAM = true;
        } else if (rawHour == 12) {
          selectedHour = 12;
          isAM = false;
        } else if (rawHour > 12) {
          selectedHour = rawHour - 12;
          isAM = false;
        } else {
          selectedHour = rawHour;
          isAM = true;
        }

        if (period == 'بعد از ظهر') {
          isAM = false;
        } else if (period == 'صبح') {
          isAM = true;
        }

        hourController.jumpToItem((selectedHour - 1) % 12);
        minuteController.jumpToItem(selectedMinute);
      } catch (e) {
        // Handle error silently
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CupertinoPicker.builder(
              scrollController: hourController,
              itemExtent: 60,
              onSelectedItemChanged: (value) {
                setState(() {
                  selectedHour = value + 1;
                  updateTime();
                });
              },
              childCount: 12,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    convertToPersianDigits(index + 1),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: CupertinoPicker.builder(
              scrollController: minuteController,
              itemExtent: 60,
              onSelectedItemChanged: (value) {
                setState(() {
                  selectedMinute = value;
                  updateTime();
                });
              },
              childCount: 60,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    convertToPersianDigits(index),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 60,
              scrollController:
                  FixedExtentScrollController(initialItem: isAM ? 0 : 1),
              onSelectedItemChanged: (value) {
                setState(() {
                  isAM = value == 0;
                  updateTime();
                });
              },
              children: [
                Center(child: Text('صبح', style: TextStyle(fontSize: 18))),
                Center(
                    child: Text('بعد از ظهر', style: TextStyle(fontSize: 18))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTime() {
    // Convert 12-hour format to 24-hour format
    final hour = (isAM && selectedHour == 12)
        ? 0 // 12 AM is 00 in 24-hour format
        : (!isAM && selectedHour < 12)
            ? selectedHour + 12 // PM hours add 12 (except 12 PM)
            : selectedHour; // AM hours and 12 PM stay as is

    // Format the time string
    final formattedHour = hour.toString().padLeft(2, '0');
    final formattedMinute = selectedMinute.toString().padLeft(2, '0');
    final period = isAM ? 'صبح' : 'بعد از ظهر';

    // Create the time string in the format "HH:MM صبح/بعد از ظهر"
    final timeString = '$formattedHour:$formattedMinute $period';

    // Pass the formatted time string to the callback
    widget.onTimeChanged(timeString);
  }
}
