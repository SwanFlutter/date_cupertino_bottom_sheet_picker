import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';
import 'package:flutter/material.dart';

class New extends StatelessWidget {
  const New({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('New')),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            DateCupertinoBottomSheetPicker.dateTimePickerPersian(
              minWidth: 0.9,
              onDateAndTimeChanged: (
                dateTime,
                formattedDate,
                formattedDateWithDay,
                timeOfDay,
                timeOfDayString,
                timeOfDayPersianString,
              ) {
                debugPrint(
                  "dateTime: $dateTime, formattedDate: $formattedDate, formattedDateWithDay: $formattedDateWithDay, timeOfDay: $timeOfDay, timeOfDayString: $timeOfDayString , timeOfDayPersianString: $timeOfDayPersianString",
                );
              },
            ),
            const SizedBox(height: 20),
            DateCupertinoBottomSheetPicker.datePickerPersian(
              minWidth: 0.9,
              onChanged: (dateTime, formattedDate, formattedDateWithDay) {
                debugPrint(
                  "dateTime: $dateTime, formattedDate: $formattedDate, formattedDateWithDay: $formattedDateWithDay",
                );
              },
            ),
            const SizedBox(height: 20),
            DateCupertinoBottomSheetPicker.dateTimePickerGregorian(
              minWidth: 0.9,
              confirmButtonConfig: ConfirmButtonConfig(
                text: 'text',
                style: const TextStyle(color: Colors.red),
                color: Colors.green,
                height: 75,
              ),
              onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
                debugPrint(
                  "dateTime: $dateTime, formattedDate: $formattedDate, formattedDateWithDay: $formattedDateWithDay",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
