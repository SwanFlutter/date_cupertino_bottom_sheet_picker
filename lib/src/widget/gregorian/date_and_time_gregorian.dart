// ignore_for_file: must_be_immutable

import 'package:date_cupertino_bottom_sheet_picker/src/date_time_picker_gregorian.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/extensions/default.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/gregorian/GregorianTimePicker.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/gregorian/calendar_view_date.dart';
import 'package:fade_animation_delayed/fade_animation_delayed.dart';
import 'package:flutter/material.dart';

class DateAndTimeGregorian extends StatefulWidget {
  /// The current date.
  late DateTime currentDate;

  /// The selected time.
  late TimeOfDay selectedTime;

  /// The selected date.
  final DateTime selectedDate;

  /// The first date that can be selected.
  final DateTime firstDate;

  /// The last date that can be selected.
  final DateTime lastDate;

  /// The minimum age that can be selected.
  final num minAge;

  /// The color of the divider.
  final Color dividerColor;

  /// A callback function that is called when the time is changed.
  final Function(TimeOfDay, DateTime) onTimeChanged;

  /// The date and time combined.
  final String timeAndDate;

  final DateTimePickerGregorian dateCupertinoBottomSheetPicker;

  /// Creates a [DateAndTimeGregorian] widget.
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
  DateAndTimeGregorian({
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
    required this.dateCupertinoBottomSheetPicker,
  });

  @override
  State<DateAndTimeGregorian> createState() => _DateAndTimeGregorianState();
}

class _DateAndTimeGregorianState extends State<DateAndTimeGregorian> {
  late String displayTimeAndDate;

  // متغیر استاتیک که در کل برنامه حفظ می‌شود
  static bool animationHasRunOnce = false;

  @override
  void initState() {
    super.initState();
    displayTimeAndDate = widget.timeAndDate;
  }

  @override
  void didUpdateWidget(DateAndTimeGregorian oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentDate != widget.currentDate ||
        oldWidget.selectedTime != widget.selectedTime) {
      setState(() {
        displayTimeAndDate =
            viewFormatDateTimeFor(widget.currentDate, widget.selectedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Widget dateTimeWidget;

    // بررسی اینکه آیا انیمیشن قبلاً اجرا شده یا نه
    if (!animationHasRunOnce) {
      dateTimeWidget = FadeAnimationDelayed(
        delay: const Duration(milliseconds: 700),
        slideDirection: SlideDirection.rightToLeft,
        child: buildDateTimeText(theme),
      );
    } else {
      dateTimeWidget = buildDateTimeText(theme);
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          dateTimeWidget,
          SizedBox(height: 10),
          Divider(
            thickness: 1,
            color: theme.colorScheme.primary,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: GregorianTimePicker(
              dividerColor: theme.colorScheme.primary,
              onTimeChanged: (String timeString) {
                TimeOfDay time = stringToTimeOfDay(timeString);
                if (widget.selectedTime != time) {
                  widget.selectedTime = time;
                  widget.onTimeChanged(time, widget.currentDate);
                  setState(() {
                    displayTimeAndDate = viewFormatDateTimeFor(
                      widget.currentDate,
                      time,
                    );
                  });
                }
              },
              initialTime:
                  "${widget.selectedTime.hour}:${widget.selectedTime.minute.toString().padLeft(2, '0')} ${widget.selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}",
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 1,
            color: theme.colorScheme.primary,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          CalendarViewDate(
            minAge: widget.minAge,
            selectedDate: widget.currentDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            dateCupertinoBottomSheetPicker:
                widget.dateCupertinoBottomSheetPicker,
            onChange: (DateTime dateTime) {
              if (mounted && widget.currentDate != dateTime) {
                setState(() {
                  widget.currentDate = dateTime;
                  displayTimeAndDate = viewFormatDateTimeFor(
                    dateTime,
                    widget.selectedTime,
                  );
                });
                widget.onTimeChanged(widget.selectedTime, dateTime);
              }
            },
          ),
        ],
      ),
    );
  }

  // Helper method to build the date-time text widget
  Widget buildDateTimeText(ThemeData theme) {
    return Text(
      displayTimeAndDate,
      style: TextStyle(
        fontSize: theme.textTheme.headlineSmall!.fontSize,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.primary,
      ),
      textAlign: TextAlign.center,
    );
  }
}
