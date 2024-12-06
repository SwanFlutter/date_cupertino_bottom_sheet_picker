// ignore_for_file: must_be_immutable

import 'package:date_cupertino_bottom_sheet_picker/src/date_time_picker_gregorian.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/gregorian/calendar_view_date.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/gregorian/date_and_time_gregorian.dart';
import 'package:fade_animation_delayed/fade_animation_delayed.dart';
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

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
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
                      selectedDate: widgets.selectedDate,
                      firstDate: widgets.firstDate,
                      lastDate: widgets.lastDate,
                      dateCupertinoBottomSheetPicker:
                          widget.dateTimePickerGregorian,
                      onChange: (DateTime dateTime) {
                        setState(() {
                          widget.currentDate = dateTime;
                        });
                      },
                    ),
                    DateAndTimeGregorian(
                      timeAndDate: widget.timeAndDate,
                      selectedTime: widget.selectedTime,
                      currentDate: widget.currentDate,
                      dividerColor: widgets.dividerColor,
                      selectedDate: widget.currentDate,
                      firstDate: widgets.firstDate,
                      lastDate: widgets.lastDate,
                      minAge: widgets.minAge,
                      onTimeChanged: (TimeOfDay newTime) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            widget.selectedTime = newTime;
                          });
                        });
                      },
                      dateCupertinoBottomSheetPicker:
                          widget.dateTimePickerGregorian,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (progress == 0) // دکمه "Get Time" فقط در صفحه اول
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.ease);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: themeData.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      widgets.timeText,
                      style: widgets.timeTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          if (progress == 1)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: FadeAnimationDelayed(
                  delay: const Duration(milliseconds: 0),
                  slideDirection: SlideDirection.rightToLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        minWidth: minWidth,
                        height: buttonHeight,
                        color: widgets.cancelButtonConfig?.color ?? Colors.red,
                        shape: widgets.cancelButtonConfig?.shape ??
                            const StadiumBorder(),
                        onPressed: () {
                          _pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.ease);
                        },
                        child: Text(
                          widgets.cancelButtonConfig?.text ?? 'Cancel',
                          style: widgets.cancelButtonConfig?.style ??
                              const TextStyle(
                                color: Colors.white,
                              ),
                        ),
                      ),
                      MaterialButton(
                        minWidth: minWidth,
                        height: buttonHeight,
                        color:
                            widgets.confirmButtonConfig?.color ?? Colors.blue,
                        shape: widgets.confirmButtonConfig?.shape ??
                            const StadiumBorder(),
                        onPressed: () {
                          // فرمت زمان را به درستی تنظیم کنیم
                          //    String formattedTime = '${widget.selectedTime.hour}:${widget.selectedTime.minute.toString().padLeft(2, '0')}';

                          // ترکیب تاریخ و زمان
                          DateTime combinedDateTime = DateTime(
                              widget.currentDate.year,
                              widget.currentDate.month,
                              widget.currentDate.day,
                              widget.selectedTime.hour,
                              widget.selectedTime.minute);

                          Navigator.of(context).pop(combinedDateTime);
                        },
                        child: Text(
                          widgets.confirmButtonConfig?.text ?? "Select",
                          style: widgets.confirmButtonConfig?.style ??
                              const TextStyle(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
