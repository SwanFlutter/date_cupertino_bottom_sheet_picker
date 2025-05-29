// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

/// Gregorian
class GregorianTimePicker extends StatefulWidget {
  final String initialTime;
  final Function(String time) onTimeChanged;
  final Color dividerColor;

  const GregorianTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
    required this.dividerColor,
  });

  @override
  State<GregorianTimePicker> createState() => _GregorianTimePickerState();
}

class _GregorianTimePickerState extends State<GregorianTimePicker> {
  late int selectedHour;
  late int selectedMinute;
  late bool isAM;
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  @override
  void initState() {
    super.initState();
    try {
      debugPrint("Initial time: ${widget.initialTime}");
      final timeParts = widget.initialTime.split(':');
      int rawHour = int.parse(timeParts[0]);

      // Safeguard against invalid format
      final minuteAndPeriod = timeParts[1].split(' ');
      selectedMinute = int.parse(minuteAndPeriod[0]);

      // Check for AM/PM
      String period =
          minuteAndPeriod.length > 1 ? minuteAndPeriod[1].toUpperCase() : '';
      isAM = period == 'AM';

      // Convert 24-hour format to 12-hour format for display
      if (rawHour == 0) {
        selectedHour = 12; // 0 hour in 24-hour format is 12 AM
        isAM = true;
      } else if (rawHour == 12) {
        selectedHour = 12; // 12 hour in 24-hour format is 12 PM
        isAM = false;
      } else if (rawHour > 12) {
        selectedHour = rawHour - 12; // Convert PM hours
        isAM = false;
      } else {
        selectedHour = rawHour; // AM hours stay the same
        isAM = true;
      }

      // Override AM/PM if explicitly specified
      if (period == 'PM') {
        isAM = false;
      } else if (period == 'AM') {
        isAM = true;
      }

      // Ensure selectedHour is between 1-12 for the picker
      if (selectedHour == 0) selectedHour = 12;
      if (selectedHour > 12) selectedHour = selectedHour % 12;
      if (selectedHour == 0) selectedHour = 12;

      debugPrint(
          "Parsed time: Hour=$selectedHour, Minute=$selectedMinute, isAM=$isAM");

      // Initialize controllers with correct positions
      hourController =
          FixedExtentScrollController(initialItem: (selectedHour - 1) % 12);
      minuteController =
          FixedExtentScrollController(initialItem: selectedMinute);
    } catch (e) {
      // Fallback to default time in case of error
      selectedHour = 12;
      selectedMinute = 0;
      isAM = true;
      hourController = FixedExtentScrollController(initialItem: 0);
      minuteController = FixedExtentScrollController(initialItem: 0);
      debugPrint(
          'Invalid initialTime format: ${widget.initialTime}, error: $e, defaulting to 12:00 AM.');
    }
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
                  selectedHour = value + 1;
                  updateTime();
                });
              },
              childCount: 12,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    (index + 1).toString(),
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
                    index.toString().padLeft(2, '0'),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 60,
              scrollController:
                  FixedExtentScrollController(initialItem: isAM ? 0 : 1),
              onSelectedItemChanged: (value) {
                setState(() {
                  isAM = value == 0;
                  updateTime();
                });
              },
              children: [
                Center(child: Text('AM', style: TextStyle(fontSize: 18))),
                Center(child: Text('PM', style: TextStyle(fontSize: 18))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTime() {
    // Convert 12-hour format to 24-hour format
    final hour = (isAM && selectedHour == 12)
        ? 0 // 12 AM is 00 in 24-hour format
        : (!isAM && selectedHour < 12)
            ? selectedHour + 12 // PM hours add 12 (except 12 PM)
            : selectedHour; // AM hours and 12 PM stay as is

    // Format the time string
    final formattedHour = hour.toString().padLeft(2, '0');
    final formattedMinute = selectedMinute.toString().padLeft(2, '0');
    final period = isAM ? 'AM' : 'PM';

    // Create the time string in the format "HH:MM AM/PM"
    final timeString = '$formattedHour:$formattedMinute $period';
    debugPrint(
        'Updated time: $timeString (hour=$hour, selectedHour=$selectedHour, isAM=$isAM)');

    // Pass the formatted time string to the callback
    widget.onTimeChanged(timeString);
  }
}
