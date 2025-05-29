// ignore_for_file: must_be_immutable

import 'package:date_cupertino_bottom_sheet_picker/src/date_time_picker_gregorian.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/extensions/default.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/gregorian/calendar_view_date.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/gregorian/date_and_time_gregorian.dart';
import 'package:flutter/material.dart';

/// [ViewWidgetGregorian] is a widget that displays a date and time.
///
/// It takes in a [DateTimePickerGregorian] widget, a [currentDate] of type [DateTime],
/// a [selectedTime] of type [TimeOfDay], and a [timeAndDate] of type [String].
class ViewWidgetGregorian extends StatefulWidget {
  /// The current date.
  DateTime currentDate;

  /// The selected time.
  TimeOfDay selectedTime;

  /// The date and time combined.
  String timeAndDate;

  /// The [DateCupertinoBottomSheetPicker] widget.
  DateTimePickerGregorian dateTimePickerGregorian;

  /// Creates a [ViewWidgetGregorian].
  ///
  /// Required parameters:
  /// - [dateCupertinoBottomSheetPicker]: The [DateCupertinoBottomSheetPicker] widget.
  /// - [currentDate]: The current date.
  /// - [selectedTime]: The selected time.
  /// - [timeAndDate]: The date and time combined.
  ViewWidgetGregorian({
    super.key,
    required this.currentDate,
    required this.selectedTime,
    required this.timeAndDate,
    required this.dateTimePickerGregorian,
  });

  @override
  State<ViewWidgetGregorian> createState() => _ViewWidgetGregorianState();
}

class _ViewWidgetGregorianState extends State<ViewWidgetGregorian> {
  late PageController _pageController;
  late DateTime _modalCurrentDate;
  late TimeOfDay _modalSelectedTime;
  late String _modalTimeAndDateString;

  @override
  void initState() {
    super.initState();
    _modalCurrentDate = widget.currentDate;
    _modalSelectedTime = widget.selectedTime;
    _modalTimeAndDateString = viewFormatDateTimeFor(
      _modalCurrentDate,
      _modalSelectedTime,
    );
    _pageController = PageController()
      ..addListener(() {
        // Only rebuild if page actually changed
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        _pageController.hasClients ? (_pageController.page ?? 0) : 0;
    ThemeData themeData = Theme.of(context);
    var widgets = widget.dateTimePickerGregorian;
    Size size = MediaQuery.of(context).size;

    double buttonHeight;
    double minWidth;

    if (size.width <= 346) {
      buttonHeight = 35.0;
      minWidth = 100.0;
    } else if (size.width <= 460) {
      buttonHeight = 45.0;
      minWidth = 150.0;
    } else if (size.width >= 585) {
      buttonHeight = 60.0;
      minWidth = 270.0;
    } else {
      buttonHeight = size.width * 0.1;
      minWidth = size.width * 0.45;
    }

    return SizedBox(
      height: 400 + progress * 160,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    CalendarViewDate(
                      minAge: widgets.minAge,
                      selectedDate: _modalCurrentDate,
                      firstDate: widgets.firstDate,
                      lastDate: widgets.lastDate,
                      dateCupertinoBottomSheetPicker: widgets,
                      onChange: (DateTime dateTime) {
                        setState(() {
                          _modalCurrentDate = dateTime;
                          _modalTimeAndDateString = viewFormatDateTimeFor(
                            _modalCurrentDate,
                            _modalSelectedTime,
                          );
                        });
                      },
                    ),
                    DateAndTimeGregorian(
                      timeAndDate: _modalTimeAndDateString,
                      selectedTime: _modalSelectedTime,
                      currentDate: _modalCurrentDate,
                      dividerColor: widgets.dividerColor,
                      selectedDate: _modalCurrentDate,
                      firstDate: widgets.firstDate,
                      lastDate: widgets.lastDate,
                      minAge: widgets.minAge,
                      onTimeChanged: (TimeOfDay newTime, DateTime newDate) {
                        if (_modalSelectedTime != newTime ||
                            _modalCurrentDate != newDate) {
                          setState(() {
                            _modalSelectedTime = newTime;
                            _modalCurrentDate = newDate;
                            _modalTimeAndDateString = viewFormatDateTimeFor(
                              _modalCurrentDate,
                              _modalSelectedTime,
                            );
                          });
                        }
                      },
                      dateCupertinoBottomSheetPicker: widgets,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (progress == 0)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  _pageController
                      .animateToPage(
                        1,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.ease,
                      )
                      .then((_) {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: widgets.timeColorBottom ?? themeData.primaryColor,
                  ),
                  child: Center(
                    child: Text(widgets.timeText, style: widgets.timeTextStyle),
                  ),
                ),
              ),
            ),
          if (progress == 1.0)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      minWidth:
                          widgets.cancelButtonConfig?.minWidth ?? minWidth,
                      height:
                          widgets.cancelButtonConfig?.height ?? buttonHeight,
                      color: widgets.cancelButtonConfig?.color ?? Colors.red,
                      shape: widgets.cancelButtonConfig?.shape ??
                          const StadiumBorder(),
                      onPressed: () {
                        _pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.ease,
                        );
                      },
                      child: Text(
                        widgets.cancelButtonConfig?.text ?? 'Cancel',
                        style: widgets.cancelButtonConfig?.style ??
                            const TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      minWidth:
                          widgets.confirmButtonConfig?.minWidth ?? minWidth,
                      height:
                          widgets.confirmButtonConfig?.height ?? buttonHeight,
                      color: widgets.confirmButtonConfig?.color ?? Colors.blue,
                      shape: widgets.confirmButtonConfig?.shape ??
                          const StadiumBorder(),
                      onPressed: () {
                        DateTime combinedDateTime = DateTime(
                          _modalCurrentDate.year,
                          _modalCurrentDate.month,
                          _modalCurrentDate.day,
                          _modalSelectedTime.hour,
                          _modalSelectedTime.minute,
                        );
                        debugPrint(
                            "Returning combined date/time: $combinedDateTime (date: $_modalCurrentDate, time: $_modalSelectedTime)");
                        Navigator.of(context).pop(combinedDateTime);
                      },
                      child: Text(
                        widgets.confirmButtonConfig?.text ?? "Select",
                        style: widgets.confirmButtonConfig?.style ??
                            const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
