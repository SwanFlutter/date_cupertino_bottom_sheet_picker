// ignore_for_file: must_be_immutable

import 'package:date_cupertino_bottom_sheet_picker/src/date_time_picker_persian.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/persian/persian_calendar_and_time_view.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/persian/time_and_date_persian.dart';
import 'package:fade_animation_delayed/fade_animation_delayed.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

/// [ViewWidgetPersian] is a widget that displays a date and time.
///
/// It takes in a [DateTimePickerPersian] widget, a [currentDate] of type [Jalali],
/// a [selectedTime] of type [TimeOfDay], and a [timeAndDate] of type [String].
class ViewWidgetPersian extends StatefulWidget {
  /// The current date.
  Jalali currentDate;

  /// The selected time.
  TimeOfDay selectedTime;

  /// The date and time combined.
  String timeAndDate;

  /// The [DateTimePickerPersian] widget.
  DateTimePickerPersian widget;

  /// Creates a [ViewWidgetPersian].
  ///
  /// Required parameters:
  /// - [widget]: The [DateTimePickerPersian] widget.
  /// - [currentDate]: The current date.
  /// - [selectedTime]: The selected time.
  /// - [timeAndDate]: The date and time combined.
  ViewWidgetPersian({
    super.key,
    required this.widget,
    required this.currentDate,
    required this.selectedTime,
    required this.timeAndDate,
  });

  @override
  State<ViewWidgetPersian> createState() => _ViewWidgetPersianState();
}

class _ViewWidgetPersianState extends State<ViewWidgetPersian> {
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
    var widgets = widget.widget;
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
                    PersianDatePicker(
                      selectedDate: widgets.selectedDate,
                      firstDate: widgets.firstDate,
                      lastDate: widgets.lastDate,
                      minAge: widgets.minAge,
                      dividerColor: widgets.dividerColor,
                      onDateChanged: (Jalali jalali) {
                        setState(() {
                          widget.currentDate = jalali;
                        });
                      },
                    ),
                    TimeAndDatePersian(
                      timeAndDate: widget.timeAndDate,
                      selectedTime: widget.selectedTime,
                      currentDate: widget.currentDate,
                      dividerColor: widgets.dividerColor,
                      selectedDate: widget.currentDate,
                      firstDate: widgets.firstDate,
                      lastDate: widgets.lastDate,
                      minAge: widgets.minAge,
                      onTimeChanged: (TimeOfDay newTime) {
                        setState(() {
                          widget.selectedTime = newTime;
                        });
                      },
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
                      widgets.timeText ?? 'دریافت زمان',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
                          widgets.cancelButtonConfig?.text ?? 'بازگشت',
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
                          String formattedTime =
                              '${widget.selectedTime.hour}:${widget.selectedTime.minute.toString().padLeft(2, '0')} ${widget.selectedTime.period == DayPeriod.am ? 'صبح' : 'بعد از ظهر'}';
                          Navigator.of(context).pop({
                            'date': widget.currentDate,
                            'time': formattedTime,
                          });
                        },
                        child: Text(
                          widgets.confirmButtonConfig?.text ?? "انتخاب",
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
