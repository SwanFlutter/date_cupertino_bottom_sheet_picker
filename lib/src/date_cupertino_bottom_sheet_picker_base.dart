import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

typedef OnDateChange = void Function(DateTime dateTime);

///=============================================================================
class DateCupertinoBottomSheetPicker extends StatefulWidget {
  /// Height FormField
  final double height;

  /// Form field width between 0 and 1 in percent
  final double width;

  ///Specifies the padding at the top and bottom.
  final double paddingVertical;

  ///Specifies padding on the left and right.
  final double paddingHorizontal;

  /// Border for text field.
  final InputBorder? border;

  /// BorderRadius Form
  final double borderRadius;

  ///LabelText for text field.
  final String? labelText;

  /// Shadow for BottomSheet.
  final double? elevation;

  /// BorderRadius for BottomSheet.
  final ShapeBorder? shapeBottomSheet;

  ///BottomSheet Color
  final Color? backgroundColor;

  ///It creates an age limit, any number you enter will not be available below that age.
  final num minAge;

  /// The currently selected date.
  final DateTime selectedDate;

  /// Minimum year that the picker can be scrolled.
  final DateTime firstDate;

  /// Maximum year that the picker an be scrolled.
  final DateTime lastDate;
  final OnDateChange? onChanged;

  DateCupertinoBottomSheetPicker({
    super.key,
    ShapeBorder? shapeBottomSheet,
    InputBorder? border,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? selectedDate,
    this.height = 20,
    this.width = 1.0,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.labelText = 'Date of birth...',
    this.elevation = 20,
    this.minAge = 0,
    this.backgroundColor = Colors.white,
    this.borderRadius = 12.0,
    this.onChanged,
  })  : selectedDate = selectedDate ?? DateTime(1995, 4, 21),
        firstDate = firstDate ?? DateTime(1960, 1, 1),
        lastDate = lastDate ??= DateTime(2060),
        border = border ?? const OutlineInputBorder(),
        shapeBottomSheet = shapeBottomSheet ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        super();

  @override
  State<DateCupertinoBottomSheetPicker> createState() => _DateCupertinoBottomSheetPickerState();
}

///============================================================================
class _DateCupertinoBottomSheetPickerState extends State<DateCupertinoBottomSheetPicker>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = widget.selectedDate;
    controller = TextEditingController();
    controller.text = widget.selectedDate.toString().split(' ')[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * widget.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.paddingVertical,
          horizontal: widget.paddingHorizontal,
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.symmetric(vertical: widget.height, horizontal: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius)),
            labelText: widget.labelText,
            suffixIcon: InkResponse(
              onTap: onShowCalendarClick,
              child: const Icon(Icons.calendar_month_rounded),
            ),
          ),
        ),
      ),
    );
  }

  void onShowCalendarClick() async {
    final aCtr = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 1));

    final res = await showModalBottomSheet(

      isScrollControlled: true,
      transitionAnimationController: aCtr,
      elevation: widget.elevation,
      backgroundColor: widget.backgroundColor,
      shape: widget.shapeBottomSheet,
      context: context,
      builder: (BuildContext context) {
        return CalendarView(
          minAge: widget.minAge,
          selectedDate: currentDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );
      },
    );

    if (res is DateTime) {
      currentDate = res;
      controller.text = currentDate.toString().split(' ')[0];
      widget.onChanged?.call(currentDate);
    }
  }
}

///=============================================================================
class CalendarView extends StatefulWidget {
  final num minAge;
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const CalendarView({
    super.key,
    required this.minAge,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

///=============================================================================
class _CalendarViewState extends State<CalendarView> {
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = widget.selectedDate;

    yearController = FixedExtentScrollController(
        initialItem: getSelectedYearIndex(currentDate));
    monthController = FixedExtentScrollController(
        initialItem: getSelectedMonthIndex(currentDate));
    dayController = FixedExtentScrollController(
        initialItem: getSelectedDayIndex(currentDate));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                DateFormat('yyyy-MM-dd').format(currentDate.toLocal()),
                style: const TextStyle(
                    fontSize: 25.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(thickness: 1),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: yearController,
                      diameterRatio: 1.0,
                      itemExtent: 60,
                      onSelectedItemChanged: (value) async {
                        final y = getYears()[value];
                        final m = currentDate.month;

                        int dayCount = getDaysInMonth(y, m).length;

                        if (dayCount <= getSelectedDayIndex(currentDate)) {
                          final days = getDaysInMonth(y, m);
                          currentDate = DateTime(y, m, days.last);
                          dayController.jumpToItem(days.length - 1);
                        } else {
                          currentDate = DateTime(y, m, currentDate.day);
                        }

                        //monthController.jumpToItem(getSelectedMonthIndex(currentDate));
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            getYears()[index].toString(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                      childCount: getYears().length - widget.minAge.toInt(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: monthController,
                      diameterRatio: 1.0,
                      itemExtent: 60,
                      onSelectedItemChanged: (value) async {
                        final beforeDay = getSelectedDayIndex(currentDate);
                        int dayCount =
                            getDaysInMonth(currentDate.year, value + 1).length;

                        if (dayCount <= beforeDay) {
                          final days =
                          getDaysInMonth(currentDate.year, value + 1);

                          currentDate =
                              DateTime(currentDate.year, value + 1, days.last);

                          // dayController.jumpToItem(days.length - 1);
                          dayController.animateToItem(
                            days.length - 1,
                            curve: Curves.bounceIn,
                            duration: const Duration(microseconds: 750),
                          );
                        } else {
                          currentDate = DateTime(
                              currentDate.year, value + 1, currentDate.day);
                        }

                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            getMonths()[index],
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                      childCount: getMonths().length,
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: dayController,
                      diameterRatio: 1.0,
                      itemExtent: 60,
                      onSelectedItemChanged: (value) async {
                        currentDate = DateTime(
                            currentDate.year, currentDate.month, value + 1);
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            getDaysInMonth(
                                currentDate.year, currentDate.month)[index]
                                .toString(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                      childCount:
                      getDaysInMonth(currentDate.year, currentDate.month)
                          .length,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minWidth: size.width >= 540 ? 270.0 : size.width * 0.45,
                  height: 60,
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  minWidth: size.width >= 540 ? 270.0 : size.width * 0.45,
                  height: 60,
                  child: const Text('Selected'),
                  onPressed: () {
                    Navigator.pop(context, currentDate);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  int getMonthlyDate({required int year, required int month}) {
    int day = 0;
    switch (month) {
      case 1:
        day = 31;
        break;
      case 2:
        day = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28;
        break;
      case 3:
        day = 31;
        break;
      case 4:
        day = 30;
        break;
      case 5:
        day = 31;
        break;
      case 6:
        day = 30;
        break;
      case 7:
        day = 31;
        break;
      case 8:
        day = 31;
        break;
      case 9:
        day = 30;
        break;
      case 10:
        day = 31;
        break;
      case 11:
        day = 30;
        break;
      case 12:
        day = 31;
        break;

      default:
        day = 30;
        break;
    }
    return day;
  }

  List<int> getDaysInMonth(int year, int month) {
    // generate a list of days in the given month and year
    int numDays = getMonthlyDate(
      year: year,
      month: month,
    );
    return List.generate(numDays, (index) => index + 1);
  }

  List<int> getYears() {
    final startYear = widget.firstDate.year;
    final endYear = widget.lastDate.year;

    return List.generate(endYear - startYear + 1, (index) => startYear + index);
  }

  List<String> getMonths() {
    return [
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
  }

  String getMonthName(int month) {
    return getMonths()[month - 1];
  }

  int getSelectedDayIndex(DateTime date) {
    return getDaysInMonth(date.year, date.month).indexOf(date.day);
  }

  int getSelectedYearIndex(DateTime date) {
    return getYears().indexOf(date.year);
  }

  int getSelectedMonthIndex(DateTime date) {
    return getMonths().indexOf(getMonthName(date.month));
  }
}
