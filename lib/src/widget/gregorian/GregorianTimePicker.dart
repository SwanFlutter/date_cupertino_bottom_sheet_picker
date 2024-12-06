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
      final timeParts = widget.initialTime.split(':');
      selectedHour = int.parse(timeParts[0]);

      // Safeguard against invalid format
      final minuteAndPeriod = timeParts[1].split(' ');
      selectedMinute = int.parse(minuteAndPeriod[0]);
      isAM = minuteAndPeriod.length > 1 &&
          minuteAndPeriod[1].toUpperCase() == 'AM';

      hourController =
          FixedExtentScrollController(initialItem: selectedHour % 12);
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
          'Invalid initialTime format: ${widget.initialTime}, defaulting to 12:00 AM.');
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
    final hour = (isAM && selectedHour == 12)
        ? 0
        : (isAM ? selectedHour : selectedHour + 12);
    final formattedHour = hour.toString().padLeft(2, '0');
    final formattedMinute = selectedMinute.toString().padLeft(2, '0');
    final period = isAM ? 'AM' : 'PM';
    final timeString = '$formattedHour:$formattedMinute $period';
    widget.onTimeChanged(timeString);
  }
}
