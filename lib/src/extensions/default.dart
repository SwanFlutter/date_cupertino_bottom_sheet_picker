import 'package:date_cupertino_bottom_sheet_picker/src/date_time_picker_persian.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension DefaultExtension on Object {
  /// Convert a number to Persian digits

  String convertToPersianDigitsForNew(String number) {
    final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return number.replaceAllMapped(RegExp(r'\d'), (match) {
      return persianDigits[int.parse(match.group(0)!)];
    });
  }

  String convertTimeToPersianForNew(TimeOfDay time) {
    final hour =
        time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final period = time.hour < 12 ? 'صبح' : 'بعد از ظهر';
    final persianHour =
        convertToPersianDigitsForNew(hour.toString().padLeft(2, '0'));
    final persianMinute =
        convertToPersianDigitsForNew(time.minute.toString().padLeft(2, '0'));
    return '$persianHour:$persianMinute $period';
  }

  String convertToPersianDigits(int number) {
    final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return number.toString().replaceAllMapped(RegExp(r'\d'), (match) {
      return persianDigits[int.parse(match.group(0)!)];
    });
  }

  String convertToEnglishDigits(int number) {
    final englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    return number.toString().replaceAllMapped(RegExp(r'\d'), (match) {
      return englishDigits[int.parse(match.group(0)!)];
    });
  }

  String convertTimeToStringEnglish(TimeOfDay time) {
    final hour =
        time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final period = time.hour < 12 ? 'AM' : 'PM';
    final englishHour = hour.toString().padLeft(2, '0');
    final englishMinute = time.minute.toString().padLeft(2, '0');
    return '$englishHour:$englishMinute $period';
  }

  String viewFormatDateTimeFor(DateTime dateTime, TimeOfDay time) {
// Format time to 24-hour format
    final formattedTime = convertTimeToStringEnglish(time);

//
    final formattedDate = dateTime.formatFullDate();

    return '$formattedDate  -  $formattedTime';
  }

  /// Convert a TimeOfDay to Persian formatted time
  String convertTimeToPersian(TimeOfDay time) {
    final persianHour = convertToPersianDigits(time.hour);
    final persianMinute = convertToPersianDigits(time.minute);
    return '$persianHour:${persianMinute.padLeft(2, '0')}';
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
// Remove extra spaces and convert to lowercase
    timeString = timeString.trim().toLowerCase();

// Separate time and period (AM/PM)
    List<String> parts = timeString.split(' ');
    String timePart = parts[0];
    String? period = parts.length > 1 ? parts[1] : null;

// Separate hour and minute
    List<String> timeComponents = timePart.split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

// Set the time based on the period (AM/PM)
    if (period != null) {
      if ((period == 'PM' || period == 'pm') && hour != 12) {
        hour += 12;
      } else if ((period == 'Morning' || period == 'am') && hour == 12) {
        hour = 0;
      }
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  // Function to format date and time to 24-hour format and match with Iran's time zone
  String formatDateTimeForIran(Jalali jalaliDate, TimeOfDay time) {
// Format time to 24-hour format
    final formattedTime = convertTimeToPersian(time);

//
    final formattedDate = jalaliDate.formatFullDate();

    return '$formattedDate -  $formattedTime';
  }

  String formatDateTimeForIranNew(Jalali jalaliDate, TimeOfDay time) {
// Format time to 24-hour format
    final formattedTime = convertTimeToPersianForNew(time);

//
    final formattedDate = jalaliDate.formatFullDate();

    return '$formattedDate -  $formattedTime';
  }
}

extension DateTimeExtension on DateTime {
  String formatFullDateWithDay() {
    final englishDayNames = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];
    final englishMonthNames = [
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
    final dayOfWeek = weekday % 7;
    final f = NumberFormat("00", "en");
    return '${englishDayNames[dayOfWeek]} ${f.format(day)} ${englishMonthNames[month - 1]} ${f.format(year % 100)}';
  }

  String formatFullDate() {
    final f = NumberFormat("00", "en");
    return '${f.format(year)} / ${f.format(month)} / ${f.format(day)}';
  }
}
