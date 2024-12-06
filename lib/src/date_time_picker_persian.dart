import 'package:date_cupertino_bottom_sheet_picker/src/extensions/default.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/cancel_buttom.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/confirm_button.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/text_feild_config.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/persian/view_widget_persian.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

/// This file contains extensions and widgets for handling and formatting Persian (Jalali) dates
/// and times in Flutter applications. It includes utility methods for converting and formatting
/// dates and times in Persian, as well as a customizable Persian date-time picker widget.

/// Extensions for formatting Jalali dates.
extension JalaliExtensionsTime on Jalali {
  /// Formats the Jalali date into a full Persian date string including the day name.
  /// Example output: "شنبه 01 فروردین 74"
  String formatPersianFullDateWithDay() {
    final persianDayNames = [
      'شنبه',
      'یک‌شنبه',
      'دوشنبه',
      'سه‌شنبه',
      'چهارشنبه',
      'پنج‌شنبه',
      'جمعه'
    ];
    final persianMonthNames = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند'
    ];
    final dayOfWeek = toDateTime().weekday % 7;
    final f = NumberFormat("00", "fa");
    return '${persianDayNames[dayOfWeek]} ${f.format(day)} ${persianMonthNames[month - 1]} ${f.format(year % 100)}';
  }

  /// Formats the Jalali date into a simple Persian date string.
  /// Example output: "1402 / 07 / 12"
  String formatFullDate() {
    final f = farsiNumberFormatter();
    return '${f.format(year)} / ${f.format(month)} / ${f.format(day)}';
  }

  /// Returns a [NumberFormat] configured for Persian numbers.
  NumberFormat farsiNumberFormatter() {
    return NumberFormat("##", "fa");
  }
}

/// Extensions for formatting [TimeOfDay] objects.
extension TimeOfDayExtension on TimeOfDay {
  /// Formats the [TimeOfDay] into a 24-hour time string.
  /// Example output: "13:45"
  String formatTime() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Formats the [TimeOfDay] into a Persian time string.
  /// Example output: "۱۳:۴۵"
  String formatPersianTime() {
    final f = NumberFormat("00", "fa");
    return '${f.format(hour)}:${f.format(minute)}';
  }

  String formatPersianTimeNew() {
    final f = NumberFormat("00", "fa");
    final persianHour = f.format(hour);
    final persianMinute = f.format(minute);
    final period = this.period == DayPeriod.am ? 'صبح' : 'بعد از ظهر';
    return '$persianHour:$persianMinute $period';
  }
}

/// A callback type for handling date and time changes.
typedef OnDateAndTimeChange = void Function(
    Jalali dateTime,
    String formattedDate,
    String formattedDateWithDay,
    TimeOfDay timeOfDay,
    String timeOfDayString,
    String timeOfDayPersianString);

/// A customizable Persian date and time picker widget.
class DateTimePickerPersian extends StatefulWidget {
  /// The background color of the bottom sheet.
  final Color? backgroundColorBottomSheet;

  /// The configuration for the confirm button.
  final ConfirmButtonConfig? confirmButtonConfig;

  /// The configuration for the cancel button.
  final CancelButtonConfig? cancelButtonConfig;

  /// The color of the divider.
  final Color dividerColor;

  /// The elevation of the bottom sheet.
  final double? elevation;

  /// The first date that can be selected.
  final Jalali firstDate;

  /// The last date that can be selected.
  final Jalali lastDate;

  /// The minimum age that can be selected.
  final num minAge;

  /// A callback function that is called when the date and time changes.
  final OnDateAndTimeChange? onDateAndTimeChanged;

  /// The horizontal padding of the bottom sheet.
  final double paddingHorizontal;

  /// The vertical padding of the bottom sheet.
  final double paddingVertical;

  /// The currently selected date.
  final Jalali selectedDate;

  /// The shape of the bottom sheet.
  final ShapeBorder? shapeBottomSheet;

  /// The minimum width of the bottom sheet.
  final double minWidth;

  /// The border for the text field.
  final InputBorder? border;

  /// The text displayed for the time picker.
  final String? timeText;

  /// The style of the time picker text.
  final TextStyle? timeTextStyle;

  /// The decoration for the text field.
  final TextFieldDecoration? textFieldDecoration;

  DateTimePickerPersian({
    super.key,
    ShapeBorder? shapeBottomSheet,
    InputBorder? border,
    Jalali? firstDate,
    Jalali? lastDate,
    Jalali? selectedDate,
    this.textFieldDecoration,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.elevation = 20,
    this.minAge = 0,
    this.backgroundColorBottomSheet,
    this.dividerColor = Colors.black,
    this.confirmButtonConfig,
    this.cancelButtonConfig,
    this.timeText = 'چه ساعتی؟',
    this.timeTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
    this.onDateAndTimeChanged,
    this.minWidth = 0.9,
  })  : selectedDate = selectedDate ?? Jalali(1374, 1, 1),
        firstDate = firstDate ?? Jalali(1300, 1, 1),
        lastDate = lastDate ?? Jalali(1450, 1, 1),
        border = border ?? const OutlineInputBorder(),
        shapeBottomSheet = shapeBottomSheet ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        super();

  @override
  State<DateTimePickerPersian> createState() => _DateTimePickerPersianState();
  static bool _isInitialized = false;

  // مقداردهی داده‌های محلی برای زبان فارسی
  static Future<void> initializeDateFormattingIfNeeded() async {
    if (!_isInitialized) {
      await initializeDateFormatting('fa', null);
      _isInitialized = true;
    }
  }
}

class _DateTimePickerPersianState extends State<DateTimePickerPersian> {
  TextEditingController controller = TextEditingController();
  late Jalali currentDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();

    DateTimePickerPersian.initializeDateFormattingIfNeeded().then((_) {
      currentDate = widget.selectedDate;
      selectedTime = TimeOfDay.now();
      controller.text = formatDateTimeForIranNew(currentDate, selectedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * widget.minWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.paddingVertical,
          horizontal: widget.paddingHorizontal,
        ),
        child: TextField(
          readOnly: true,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          style: widget.textFieldDecoration?.style ??
              TextStyle(color: Colors.black),
          cursorColor: widget.textFieldDecoration?.cursorColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.textFieldDecoration?.height ?? 15.0,
                horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  widget.textFieldDecoration?.borderRadius ?? 12.0),
              borderSide: BorderSide(
                  color:
                      widget.textFieldDecoration?.borderColor ?? Colors.black,
                  width: widget.textFieldDecoration?.widthBorder ?? 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  widget.textFieldDecoration?.borderRadius ?? 12.0),
              borderSide: BorderSide(
                  color: widget.textFieldDecoration?.focusedBorderColor ??
                      Colors.black,
                  width: widget.textFieldDecoration?.widthFocusedBorder ?? 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  widget.textFieldDecoration?.borderRadius ?? 12.0),
              borderSide: BorderSide(
                  color: widget.textFieldDecoration?.enabledBorderColor ??
                      Colors.black,
                  width: widget.textFieldDecoration?.widthEnabledBorder ?? 1.0),
            ),
            fillColor: widget.textFieldDecoration?.fillColor ?? Colors.white,
            filled: widget.textFieldDecoration?.filled ?? true,
            errorStyle:
                TextStyle(color: widget.textFieldDecoration?.errorColor),
            hintText: widget.textFieldDecoration?.hintText,
            hintStyle: TextStyle(color: widget.textFieldDecoration?.hintColor),
            labelText: widget.textFieldDecoration?.labelText,
            labelStyle:
                TextStyle(color: widget.textFieldDecoration?.labelTaxtColor),
            errorText: widget.textFieldDecoration?.errorText,
            prefix: Text(
              widget.textFieldDecoration?.prefix ?? '',
            ),
            prefixStyle: widget.textFieldDecoration?.prefixStyle ??
                TextStyle(fontSize: 20, color: Colors.black),
            suffixIcon: InkResponse(
              onTap: () => onShowCalendarClick(context),
              child: Icon(
                  widget.textFieldDecoration?.icon ?? Icons.calendar_month,
                  color: widget.textFieldDecoration?.iconColor ?? Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  void onShowCalendarClick(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      elevation: widget.elevation,
      backgroundColor: widget.backgroundColorBottomSheet ??
          Theme.of(context).colorScheme.inversePrimary,
      shape: widget.shapeBottomSheet,
      builder: (BuildContext context) {
        return ViewWidgetPersian(
          widget: widget,
          currentDate: currentDate,
          selectedTime: selectedTime,
          timeAndDate: controller.text,
        );
      },
    );

    if (result != null &&
        result.containsKey('date') &&
        result.containsKey('time')) {
      setState(
        () {
          currentDate = result['date'] as Jalali;

// Convert time string to TimeOfDay
          selectedTime = stringToTimeOfDay(result['time'] as String);

// Format date and time for display
          controller.text = formatDateTimeForIranNew(currentDate, selectedTime);

// Convert dateString to Jalali for use in callback

// Call callback with correct Jalali
          widget.onDateAndTimeChanged?.call(
              currentDate,
              currentDate.formatFullDate(),
              currentDate.formatPersianFullDateWithDay(),
              selectedTime,
              selectedTime.formatPersianTime(),
              selectedTime.formatPersianTimeNew());
        },
      );
    }
  }
}
