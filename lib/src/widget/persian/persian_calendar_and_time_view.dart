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
    yearController = FixedExtentScrollController(
        initialItem: getSelectedYearIndex(currentDate));
    monthController = FixedExtentScrollController(
        initialItem: getSelectedMonthIndex(currentDate));
    dayController = FixedExtentScrollController(
        initialItem: getSelectedDayIndex(currentDate));
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
    final timeParts = widget.initialTime.split(':');
    selectedHour = int.parse(timeParts[0]);
    selectedMinute = int.parse(timeParts[1]);
    isAM = selectedHour < 12;
    hourController = FixedExtentScrollController(initialItem: selectedHour);
    minuteController = FixedExtentScrollController(initialItem: selectedMinute);
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
                  selectedHour = isAM
                      ? value
                      : value + 13; // تنظیم ساعت برای صبح یا بعد از ظهر
                  updateTime();
                });
              },
              childCount: isAM ? 13 : 12, // تعداد ساعت‌های قابل نمایش
              itemBuilder: (context, index) {
                final hour =
                    isAM ? index : index + 13; // تعیین ساعت بر اساس حالت
                return Center(
                  child: Text(
                    convertToPersianDigits(hour),
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
    final formattedHour = selectedHour.toString().padLeft(2, '0');
    final formattedMinute = selectedMinute.toString().padLeft(2, '0');
    final period = isAM ? 'صبح' : 'بعد از ظهر';
    final timeString = '$formattedHour:$formattedMinute $period';
    widget.onTimeChanged(timeString);
  }
}
