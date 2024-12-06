// ignore_for_file: must_be_immutable, duplicate_import

import 'package:date_cupertino_bottom_sheet_picker/src/extensions/default.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/persian/persian_calendar_and_time_view.dart';
import 'package:fade_animation_delayed/fade_animation_delayed.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

/// [TimeAndDatePersian] is a widget that displays a date and time picker in Persian.
///
/// It takes in several parameters to customize its behavior and appearance.
class TimeAndDatePersian extends StatefulWidget {
  /// The current date.
  late Jalali currentDate;

  /// The selected time.
  late TimeOfDay selectedTime;

  /// The selected date.
  final Jalali selectedDate;

  /// The first date that can be selected.
  final Jalali firstDate;

  /// The last date that can be selected.
  final Jalali lastDate;

  /// The minimum age that can be selected.
  final num minAge;

  /// The color of the divider.
  final Color dividerColor;

  /// A callback function that is called when the time is changed.
  final Function(TimeOfDay) onTimeChanged;

  /// The date and time combined.
  final String timeAndDate;

  /// Creates a [TimeAndDatePersian] widget.
  ///
  /// Required parameters:
  /// - [currentDate]: The current date.
  /// - [selectedTime]: The selected time.
  /// - [selectedDate]: The selected date.
  /// - [firstDate]: The first date that can be selected.
  /// - [lastDate]: The last date that can be selected.
  /// - [minAge]: The minimum age that can be selected.
  /// - [dividerColor]: The color of the divider.
  /// - [onTimeChanged]: A callback function that is called when the time is changed.
  /// - [timeAndDate]: The date and time combined.
  TimeAndDatePersian({
    super.key,
    required this.currentDate,
    required this.selectedTime,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.minAge,
    required this.dividerColor,
    required this.onTimeChanged,
    required this.timeAndDate,
  });

  @override
  State<TimeAndDatePersian> createState() => _TimeAndDatePersianState();
}

class _TimeAndDatePersianState extends State<TimeAndDatePersian> {
  late String displayTimeAndDate;

  @override
  void initState() {
    super.initState();
    displayTimeAndDate = widget.timeAndDate;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimationDelayed(
            delay: const Duration(milliseconds: 700),
            slideDirection: SlideDirection.rightToLeft,
            child: Text(
              displayTimeAndDate,
              style: TextStyle(
                  fontSize: theme.textTheme.headlineSmall!.fontSize,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Divider(
              thickness: 1,
              color: theme.colorScheme.primary,
              indent: 0,
              endIndent: 0),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: PersianTimePicker(
              dividerColor: theme.colorScheme.primary,
              onTimeChanged: (String timeString) {
                TimeOfDay time = stringToTimeOfDay(timeString);
                widget.onTimeChanged(time);
                setState(() {
                  widget.selectedTime = time;
                  displayTimeAndDate =
                      formatDateTimeForIran(widget.currentDate, time);
                });
              },
              initialTime: "8:00",
            ),
          ),
          SizedBox(height: 10),
          Divider(
              thickness: 1,
              color: theme.colorScheme.primary,
              indent: 0,
              endIndent: 0),
          SizedBox(height: 10),
          PersianDatePicker(
            selectedDate: widget.selectedDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            minAge: widget.minAge,
            dividerColor: widget.dividerColor,
            onDateChanged: (Jalali jalali) {
              setState(() {
                widget.currentDate = jalali;
              });
            },
          ),
        ],
      ),
    );
  }
}
