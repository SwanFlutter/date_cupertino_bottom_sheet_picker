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

  /// A callback function that is called when the date is changed.
  final Function(Jalali)? onDateChanged;

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
  /// - [onDateChanged]: A callback function that is called when the date is changed.
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
    this.onDateChanged,
    required this.timeAndDate,
  });

  @override
  State<TimeAndDatePersian> createState() => _TimeAndDatePersianState();
}

class _TimeAndDatePersianState extends State<TimeAndDatePersian> {
  late String displayTimeAndDate;
  late Jalali _currentDate;
  late TimeOfDay _selectedTime;
  static bool animationHasRunOnce = false;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.currentDate;
    _selectedTime = widget.selectedTime;
    displayTimeAndDate = formatDateTimeForIranNew(_currentDate, _selectedTime);
  }

  @override
  void didUpdateWidget(TimeAndDatePersian oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentDate != oldWidget.currentDate ||
        widget.selectedTime != oldWidget.selectedTime) {
      _currentDate = widget.currentDate;
      _selectedTime = widget.selectedTime;
      displayTimeAndDate =
          formatDateTimeForIranNew(_currentDate, _selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Widget dateTimeWidget;
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
              endIndent: 0),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: PersianTimePicker(
              dividerColor: theme.colorScheme.primary,
              onTimeChanged: (String timeString) {
                TimeOfDay time = stringToTimeOfDay(timeString);
                widget.onTimeChanged(time);
                if (mounted) {
                  setState(() {
                    _selectedTime = time;
                    displayTimeAndDate =
                        formatDateTimeForIranNew(_currentDate, time);
                  });
                }
              },
              initialTime:
                  "${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')} ${_selectedTime.period == DayPeriod.am ? 'صبح' : 'بعد از ظهر'}",
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
            selectedDate: _currentDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            minAge: widget.minAge,
            dividerColor: widget.dividerColor,
            onDateChanged: (Jalali jalali) {
              if (mounted) {
                setState(() {
                  _currentDate = jalali;
                  widget.currentDate = jalali;
                  displayTimeAndDate =
                      formatDateTimeForIranNew(jalali, _selectedTime);
                });
                // Notify parent widget about the date change
                widget.onDateChanged?.call(jalali);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildDateTimeText(ThemeData theme) {
    return Text(
      displayTimeAndDate,
      style: TextStyle(
          fontSize: theme.textTheme.headlineSmall!.fontSize,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary),
      textAlign: TextAlign.center,
    );
  }
}
