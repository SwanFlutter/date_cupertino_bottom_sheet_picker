import 'package:date_cupertino_bottom_sheet_picker/src/date_picker_persian.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/date_time_picker_gregorian.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/date_time_picker_persian.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/extensions/default.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/cancel_buttom.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/confirm_button.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/text_feild_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

export 'package:date_cupertino_bottom_sheet_picker/src/widget/global/cancel_buttom.dart';
export 'package:date_cupertino_bottom_sheet_picker/src/widget/global/confirm_button.dart';
export 'package:date_cupertino_bottom_sheet_picker/src/widget/global/text_feild_config.dart';

/// A callback function that is called when the date changes.
typedef OnDateChange = void Function(
    DateTime dateTime, String formattedDate, String formattedDateWithDay);

/// A widget that displays a Cupertino-style date picker in a bottom sheet.
class DateCupertinoBottomSheetPicker extends StatefulWidget {
  /// The height of the form field.
  final double height;

  /// The minimum width of the form field, between 0 and 1 in percent.
  final double minWidth;

  /// Specifies the padding at the top and bottom.
  final double paddingVertical;

  /// Specifies padding on the left and right.
  final double paddingHorizontal;

  /// The border for the text field.
  final InputBorder? border;

  /// The border radius for the form.
  final double borderRadius;

  /// The shadow for the bottom sheet.
  final double? elevation;

  /// The border radius for the bottom sheet.
  final ShapeBorder? shapeBottomSheet;

  /// The background color for the bottom sheet.
  final Color? backgroundColorBottomSheet;

  /// Creates an age limit, any number you enter will not be available below that age.
  final num minAge;

  /// The currently selected date.
  final DateTime selectedDate;

  /// The minimum year that the picker can be scrolled.
  final DateTime firstDate;

  /// The maximum year that the picker can be scrolled.
  final DateTime lastDate;

  /// Gets the date from the user when they select a date in the picker.
  final OnDateChange? onTimeChanged;

  /// The decoration for the text field.
  final TextFieldDecoration? textFieldDecoration;

  /// The color of the divider.
  final Color dividerColor;

  /// The configuration for the confirm button.
  final ConfirmButtonConfig? confirmButtonConfig;

  /// The configuration for the cancel button.
  final CancelButtonConfig? cancelButtonConfig;

  /// Creates a [DateCupertinoBottomSheetPicker] widget.
  ///
  /// Optional parameters:
  /// - [shapeBottomSheet]: The border radius for the bottom sheet.
  /// - [border]: The border for the text field.
  /// - [firstDate]: The minimum year that the picker can be scrolled.
  /// - [lastDate]: The maximum year that the picker can be scrolled.
  /// - [selectedDate]: The currently selected date.
  /// - [dividerColor]: The color of the divider.
  /// - [textFieldDecoration]: The decoration for the text field.
  /// - [height]: The height of the form field.
  /// - [minWidth]: The minimum width of the form field, between 0 and 1 in percent.
  /// - [paddingVertical]: Specifies the padding at the top and bottom.
  /// - [paddingHorizontal]: Specifies padding on the left and right.
  /// - [elevation]: The shadow for the bottom sheet.
  /// - [minAge]: Creates an age limit, any number you enter will not be available below that age.
  /// - [backgroundColorBottomSheet]: The background color for the bottom sheet.
  /// - [borderRadius]: The border radius for the form.
  /// - [onTimeChanged]: Gets the date from the user when they select a date in the picker.
  /// - [confirmButtonConfig]: The configuration for the confirm button.
  /// - [cancelButtonConfig]: The configuration for the cancel button.
  DateCupertinoBottomSheetPicker({
    super.key,
    ShapeBorder? shapeBottomSheet,
    InputBorder? border,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? selectedDate,
    this.dividerColor = Colors.grey,
    this.textFieldDecoration,
    this.height = 20,
    this.minWidth = 1.0,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.elevation = 20,
    this.minAge = 0,
    this.backgroundColorBottomSheet,
    this.borderRadius = 12.0,
    this.onTimeChanged,
    this.confirmButtonConfig,
    this.cancelButtonConfig,
  })  : selectedDate = selectedDate ?? DateTime(1995, 4, 21),
        firstDate = firstDate ?? DateTime(1960, 1, 1),
        lastDate = lastDate ??= DateTime(2060),
        border = border ?? const OutlineInputBorder(),
        shapeBottomSheet = shapeBottomSheet ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        super();

  static Widget datePickerPersian({
    /// The background color of the bottom sheet.
    final Color? backgroundColorBottomSheet,

    /// The configuration for the confirm button.
    final ConfirmButtonConfig? confirmButtonConfig,

    /// The configuration for the cancel button.
    final CancelButtonConfig? cancelButtonConfig,

    /// The color of the divider.
    final Color dividerColor = Colors.black,

    /// The elevation of the bottom sheet.
    final double? elevation = 20,

    /// The first date that can be selected.
    final Jalali? firstDate,

    /// The last date that can be selected.
    final Jalali? lastDate,

    /// The minimum age that can be selected.
    final num minAge = 0,

    /// A callback function that is called when the date and time changes.
    final OnDateTimeChange? onChanged,

    /// The horizontal padding of the bottom sheet.
    final double paddingHorizontal = 0,

    /// The vertical padding of the bottom sheet.
    final double paddingVertical = 0,

    /// The currently selected date.
    final Jalali? selectedDate,

    /// The shape of the bottom sheet.
    final ShapeBorder? shapeBottomSheet,

    /// The configuration for the text field.
    final TextFieldDecoration? textFieldDecoration,

    /// The minimum width of the bottom sheet.
    final double minWidth = 1.0,
  }) {
    return DatePickerPersian(
      firstDate: firstDate ?? Jalali(1300, 1, 1),
      lastDate: lastDate ?? Jalali(1450, 1, 1),
      selectedDate: selectedDate ?? Jalali(1374, 1, 1),
      backgroundColorBottomSheet: backgroundColorBottomSheet,
      confirmButtonConfig: confirmButtonConfig,
      cancelButtonConfig: cancelButtonConfig,
      dividerColor: dividerColor,
      elevation: elevation,
      minAge: minAge,
      onTimeChanged: onChanged,
      paddingHorizontal: paddingHorizontal,
      paddingVertical: paddingVertical,
      shapeBottomSheet: shapeBottomSheet,
      textFieldConfig: textFieldDecoration,
      minWidth: minWidth,
    );
  }

  static Widget dateTimePickerGregorian({
    /// The height of the form field.
    final double height = 20,

    /// The minimum width of the form field, between 0 and 1 in percent.
    final double minWidth = 0.9,

    /// Specifies the padding at the top and bottom.
    final double paddingVertical = 0,

    /// Specifies padding on the left and right.
    final double paddingHorizontal = 0,

    /// The border for the text field.
    final InputBorder? border = const OutlineInputBorder(),

    /// The border radius for the form.
    final double borderRadius = 12.0,

    /// The shadow for the bottom sheet.
    final double? elevation = 20,

    /// The border radius for the bottom sheet.
    final ShapeBorder? shapeBottomSheet = const OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))),

    /// The background color for the bottom sheet.
    final Color? backgroundColorBottomSheet = Colors.white,

    /// Creates an age limit, any number you enter will not be available below that age.
    final num minAge = 0,

    /// The currently selected date.
    final DateTime? selectedDate,

    /// The minimum year that the picker can be scrolled.
    final DateTime? firstDate,

    /// The maximum year that the picker can be scrolled.
    final DateTime? lastDate,

    /// Gets the date from the user when they select a date in the picker.
    final OnDateChange? onTimeChanged,

    /// The decoration for the text field.
    final TextFieldDecoration? textFieldDecoration,

    /// The color of the divider.
    final Color dividerColor = Colors.grey,

    /// The configuration for the confirm button.
    final ConfirmButtonConfig? confirmButtonConfig,

    /// The configuration for the cancel button.
    final CancelButtonConfig? cancelButtonConfig,

    /// The text for the time.
    final String timeText = 'What time?',

    /// The text style for the time.
    final TextStyle? timeTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
  }) {
    return DateTimePickerGregorian(
      height: height,
      minWidth: minWidth,
      paddingVertical: paddingVertical,
      paddingHorizontal: paddingHorizontal,
      border: border,
      borderRadius: borderRadius,
      elevation: elevation,
      shapeBottomSheet: shapeBottomSheet,
      backgroundColorBottomSheet: backgroundColorBottomSheet,
      minAge: minAge,
      selectedDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1950, 1, 1),
      lastDate: lastDate ?? DateTime(2050, 1, 1),
      onTimeChanged: onTimeChanged,
      textFieldDecoration: textFieldDecoration,
      dividerColor: dividerColor,
      confirmButtonConfig: confirmButtonConfig,
      cancelButtonConfig: cancelButtonConfig,
      timeText: timeText,
      timeTextStyle: timeTextStyle,
    );
  }

  static Widget dateTimePickerPersian({
    /// The background color of the bottom sheet.
    final Color? backgroundColorBottomSheet,

    /// The configuration for the confirm button.
    final ConfirmButtonConfig? confirmButtonConfig,

    /// The configuration for the cancel button.
    final CancelButtonConfig? cancelButtonConfig,

    /// The color of the divider.
    final Color dividerColor = Colors.black,

    /// The elevation of the bottom sheet.
    final double? elevation = 20,

    /// The first date that can be selected.
    final Jalali? firstDate,

    /// The last date that can be selected.
    final Jalali? lastDate,

    /// The minimum age that can be selected.
    final num minAge = 0,

    /// A callback function that is called when the date and time changes.
    final OnDateAndTimeChange? onDateAndTimeChanged,

    /// The horizontal padding of the bottom sheet.
    final double paddingHorizontal = 0,

    /// The vertical padding of the bottom sheet.
    final double paddingVertical = 0,

    /// The currently selected date.
    final Jalali? selectedDate,

    /// The shape of the bottom sheet.
    final ShapeBorder? shapeBottomSheet,

    /// The minimum width of the bottom sheet.
    final double minWidth = 0.9,

    /// The border for the text field.
    final InputBorder? border = const OutlineInputBorder(),

    /// The text displayed for the time picker.
    final String? timeText = 'چه ساعتی؟',

    /// The style of the time picker text.
    final TextStyle? timeTextStyle,

    /// The decoration for the text field.
    final TextFieldDecoration? textFieldDecoration,
  }) {
    return DateTimePickerPersian(
      backgroundColorBottomSheet: backgroundColorBottomSheet,
      confirmButtonConfig: confirmButtonConfig,
      cancelButtonConfig: cancelButtonConfig,
      dividerColor: dividerColor,
      elevation: elevation,
      firstDate: firstDate,
      lastDate: lastDate,
      minAge: minAge,
      onDateAndTimeChanged: onDateAndTimeChanged,
      paddingHorizontal: paddingHorizontal,
      paddingVertical: paddingVertical,
      selectedDate: selectedDate,
      shapeBottomSheet: shapeBottomSheet,
      minWidth: minWidth,
      border: border,
      timeText: timeText,
      timeTextStyle: timeTextStyle,
      textFieldDecoration: textFieldDecoration,
    );
  }

  @override
  State<DateCupertinoBottomSheetPicker> createState() =>
      _DateCupertinoBottomSheetPickerState();
}

class _DateCupertinoBottomSheetPickerState
    extends State<DateCupertinoBottomSheetPicker>
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
    Widget textField = TextField(
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      textDirection: widget.textFieldDecoration?.textDirection,
      textAlign: widget.textFieldDecoration?.textAlign ?? TextAlign.start,
      controller: controller,
      style:
          widget.textFieldDecoration?.style ?? TextStyle(color: Colors.black),
      cursorColor: widget.textFieldDecoration?.cursorColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: widget.textFieldDecoration?.height ?? 15.0,
            horizontal: 10),
        border: widget.textFieldDecoration?.border ??
            (widget.textFieldDecoration?.widthBorder == 0.0
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        widget.textFieldDecoration?.borderRadius ?? 12.0),
                    borderSide: BorderSide(
                        color: widget.textFieldDecoration?.borderColor ??
                            Colors.black,
                        width: widget.textFieldDecoration?.widthBorder ?? 1.0),
                  )),
        focusedBorder: widget.textFieldDecoration?.widthFocusedBorder == 0.0
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    widget.textFieldDecoration?.borderRadius ?? 12.0),
                borderSide: BorderSide(
                    color: widget.textFieldDecoration?.focusedBorderColor ??
                        Colors.black,
                    width:
                        widget.textFieldDecoration?.widthFocusedBorder ?? 1.0),
              ),
        enabledBorder: widget.textFieldDecoration?.widthEnabledBorder == 0.0
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    widget.textFieldDecoration?.borderRadius ?? 12.0),
                borderSide: BorderSide(
                    color: widget.textFieldDecoration?.enabledBorderColor ??
                        Colors.black,
                    width:
                        widget.textFieldDecoration?.widthEnabledBorder ?? 1.0),
              ),
        fillColor: widget.textFieldDecoration?.fillColor ?? Colors.white,
        filled: widget.textFieldDecoration?.filled ?? true,
        errorStyle: TextStyle(color: widget.textFieldDecoration?.errorColor),
        hintText: widget.textFieldDecoration?.hintText,
        hintStyle: TextStyle(color: widget.textFieldDecoration?.hintColor),
        labelText: widget.textFieldDecoration?.labelText,
        labelStyle: TextStyle(color: widget.textFieldDecoration?.labelColor),
        errorText: widget.textFieldDecoration?.errorText,
        prefix: Text(
          widget.textFieldDecoration?.prefix ?? '',
        ),
        prefixStyle: widget.textFieldDecoration?.prefixStyle ??
            TextStyle(fontSize: 20, color: Colors.black),
        suffixIcon: widget.textFieldDecoration?.suffixIcon != null
            ? GestureDetector(
                onTap: widget.textFieldDecoration?.suffixIconOnTap ??
                    onShowCalendarClick,
                child: widget.textFieldDecoration!.suffixIcon,
              )
            : InkResponse(
                onTap: onShowCalendarClick,
                child: Icon(
                    widget.textFieldDecoration?.icon ?? Icons.calendar_month,
                    color:
                        widget.textFieldDecoration?.iconColor ?? Colors.black,
                    size: widget.textFieldDecoration?.iconSize ?? 24.0),
              ),
      ),
    );

    // Wrap in container if decoration properties are provided
    if (widget.textFieldDecoration?.containerDecoration != null ||
        widget.textFieldDecoration?.gradient != null ||
        widget.textFieldDecoration?.containerColor != null ||
        widget.textFieldDecoration?.boxShadow != null ||
        widget.textFieldDecoration?.containerPadding != null ||
        widget.textFieldDecoration?.containerMargin != null ||
        widget.textFieldDecoration?.containerWidth != null ||
        widget.textFieldDecoration?.containerHeight != null) {
      textField = Container(
        width: widget.textFieldDecoration?.containerWidth,
        height: widget.textFieldDecoration?.containerHeight,
        padding: widget.textFieldDecoration?.containerPadding,
        margin: widget.textFieldDecoration?.containerMargin,
        decoration: widget.textFieldDecoration?.containerDecoration ??
            BoxDecoration(
              color: widget.textFieldDecoration?.containerColor,
              gradient: widget.textFieldDecoration?.gradient,
              borderRadius: BorderRadius.circular(
                  widget.textFieldDecoration?.borderRadius ?? 12.0),
              boxShadow: widget.textFieldDecoration?.boxShadow,
            ),
        child: textField,
      );
    }

    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * widget.minWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.paddingVertical,
          horizontal: widget.paddingHorizontal,
        ),
        child: textField,
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
      backgroundColor: widget.backgroundColorBottomSheet ??
          Theme.of(context).colorScheme.inversePrimary,
      shape: widget.shapeBottomSheet,
      context: context,
      builder: (BuildContext context) {
        return CalendarView(
          minAge: widget.minAge,
          selectedDate: currentDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          dateCupertinoBottomSheetPicker: widget,
        );
      },
    );

    if (res is DateTime) {
      currentDate = res;
      controller.text = currentDate.toString().split(' ')[0];
      widget.onTimeChanged?.call(currentDate, currentDate.formatFullDate(),
          currentDate.formatFullDateWithDay());
    }
  }
}

///=============================================================================
class CalendarView extends StatefulWidget {
  final num minAge;
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateCupertinoBottomSheetPicker dateCupertinoBottomSheetPicker;

  const CalendarView({
    super.key,
    required this.minAge,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.dateCupertinoBottomSheetPicker,
  });

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

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

    return SizedBox(
      height: size.height * 0.50,
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              DateFormat('yyyy-MM-dd').format(currentDate.toLocal()),
              style:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Divider(
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: widget.dateCupertinoBottomSheetPicker.dividerColor),
          Expanded(
            child: SizedBox(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: yearController,
                      diameterRatio: 1.0,
                      itemExtent: 40,
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
                      itemExtent: 40,
                      onSelectedItemChanged: (value) async {
                        final beforeDay = getSelectedDayIndex(currentDate);
                        int dayCount =
                            getDaysInMonth(currentDate.year, value + 1).length;
                        if (dayCount <= beforeDay) {
                          final days =
                              getDaysInMonth(currentDate.year, value + 1);
                          currentDate =
                              DateTime(currentDate.year, value + 1, days.last);
                          dayController.animateToItem(
                            days.length - 1,
                            curve: Curves.bounceIn,
                            duration: const Duration(milliseconds: 300),
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
                      itemExtent: 40,
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
          ),
          const Divider(thickness: 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MaterialButton(
                    shape: widget.dateCupertinoBottomSheetPicker
                            .cancelButtonConfig?.shape ??
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                    height: widget.dateCupertinoBottomSheetPicker
                            .cancelButtonConfig?.height ??
                        50,
                    minWidth: widget.dateCupertinoBottomSheetPicker
                            .cancelButtonConfig?.minWidth ??
                        double.infinity,
                    color: widget.dateCupertinoBottomSheetPicker
                        .cancelButtonConfig?.color,
                    child: Text(
                      widget.dateCupertinoBottomSheetPicker.cancelButtonConfig
                              ?.text ??
                          'Cancel',
                      style: widget.dateCupertinoBottomSheetPicker
                              .cancelButtonConfig?.style ??
                          const TextStyle(color: Colors.black),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MaterialButton(
                    shape: widget.dateCupertinoBottomSheetPicker
                            .confirmButtonConfig?.shape ??
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                    color: widget.dateCupertinoBottomSheetPicker
                            .confirmButtonConfig?.color ??
                        Theme.of(context).primaryColor,
                    height: widget.dateCupertinoBottomSheetPicker
                            .confirmButtonConfig?.height ??
                        50,
                    minWidth: widget.dateCupertinoBottomSheetPicker
                            .confirmButtonConfig?.minWidth ??
                        double.infinity,
                    child: Text(
                      widget.dateCupertinoBottomSheetPicker.confirmButtonConfig
                              ?.text ??
                          'Selected',
                      style: widget.dateCupertinoBottomSheetPicker
                              .confirmButtonConfig?.style ??
                          const TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Navigator.pop(context, currentDate),
                  ),
                ),
              ],
            ),
          )
        ],
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
