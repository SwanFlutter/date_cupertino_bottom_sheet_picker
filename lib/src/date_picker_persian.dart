import 'package:date_cupertino_bottom_sheet_picker/src/extensions/default.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/cancel_buttom.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/confirm_button.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/text_feild_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

/// Extensions for the [Jalali] class.
extension JalaliExtensions on Jalali {
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

  /// Formats the date as a string in the format "year / month / day".
  String formatFullDate() {
    final f = farsiNumberFormatter();
    return '${f.format(year)} / ${f.format(month)} / ${f.format(day)}';
  }

  /// Returns a number formatter for Farsi numbers.
  NumberFormat farsiNumberFormatter() {
    return NumberFormat("##", "fa");
  }
}

/// A callback function that is called when the date and time changes.
typedef OnDateTimeChange = void Function(
    Jalali dateTime, String formattedDate, String formattedDateWithDay);

/// A widget that displays a Persian date picker.
class DatePickerPersian extends StatefulWidget {
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
  final OnDateTimeChange? onTimeChanged;

  /// The horizontal padding of the bottom sheet.
  final double paddingHorizontal;

  /// The vertical padding of the bottom sheet.
  final double paddingVertical;

  /// The currently selected date.
  final Jalali selectedDate;

  /// The shape of the bottom sheet.
  final ShapeBorder? shapeBottomSheet;

  /// The configuration for the text field.
  final TextFieldDecoration textFieldStyle;

  /// The minimum width of the bottom sheet.
  final double minWidth;

  /// Creates a [DatePickerPersian] widget.
  ///
  /// Optional parameters:
  /// - [backgroundColorBottomSheet]: The background color of the bottom sheet.
  /// - [confirmButtonConfig]: The configuration for the confirm button.
  /// - [cancelButtonConfig]: The configuration for the cancel button.
  /// - [dividerColor]: The color of the divider.
  /// - [elevation]: The elevation of the bottom sheet.
  /// - [minAge]: The minimum age that can be selected.
  /// - [onChanged]: A callback function that is called when the date and time changes.
  /// - [paddingHorizontal]: The horizontal padding of the bottom sheet.
  /// - [paddingVertical]: The vertical padding of the bottom sheet.
  /// - [minWidth]: The minimum width of the bottom sheet.
  /// - [textFieldConfig]: The configuration for the text field.
  DatePickerPersian({
    super.key,
    ShapeBorder? shapeBottomSheet,
    Jalali? firstDate,
    Jalali? lastDate,
    Jalali? selectedDate,
    this.backgroundColorBottomSheet,
    this.confirmButtonConfig,
    this.cancelButtonConfig,
    this.dividerColor = Colors.black,
    this.elevation = 20,
    this.minAge = 0,
    this.onTimeChanged,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
    this.minWidth = 1,
    TextFieldDecoration? textFieldConfig,
  })  : selectedDate = selectedDate ?? Jalali(1374, 1, 1),
        firstDate = firstDate ?? Jalali(1300, 1, 1),
        lastDate = lastDate ?? Jalali(1450, 1, 1),
        shapeBottomSheet = shapeBottomSheet ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        textFieldStyle = textFieldConfig ?? TextFieldDecoration(),
        super();

  @override
  State<DatePickerPersian> createState() => _DatePickerPersianState();
  static bool _isInitialized = false;

  static Future<void> initializeDateFormattingIfNeeded() async {
    if (!_isInitialized) {
      await initializeDateFormatting('fa', null);
      _isInitialized = true;
    }
  }
}

class _DatePickerPersianState extends State<DatePickerPersian>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late Jalali currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = widget.selectedDate;
    DatePickerPersian.initializeDateFormattingIfNeeded().then((_) {
      controller.text = currentDate.formatFullDate();
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
          style: widget.textFieldStyle.style,
          cursorColor: widget.textFieldStyle.cursorColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.textFieldStyle.height, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.textFieldStyle.borderRadius),
              borderSide: BorderSide(
                  color: widget.textFieldStyle.borderColor,
                  width: widget.textFieldStyle.widthBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.textFieldStyle.borderRadius),
              borderSide: BorderSide(
                  color: widget.textFieldStyle.focusedBorderColor,
                  width: widget.textFieldStyle.widthFocusedBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.textFieldStyle.borderRadius),
              borderSide: BorderSide(
                  color: widget.textFieldStyle.enabledBorderColor,
                  width: widget.textFieldStyle.widthEnabledBorder),
            ),
            fillColor: widget.textFieldStyle.fillColor,
            filled: widget.textFieldStyle.filled,
            errorStyle: TextStyle(color: widget.textFieldStyle.errorColor),
            hintText: widget.textFieldStyle.hintText,
            hintStyle: TextStyle(color: widget.textFieldStyle.hintColor),
            labelText: widget.textFieldStyle.labelText,
            labelStyle: TextStyle(color: widget.textFieldStyle.labelHintColor),
            errorText: widget.textFieldStyle.errorText,
            prefix: Text(
              widget.textFieldStyle.prefix.toString(),
            ),
            prefixStyle: widget.textFieldStyle.prefixStyle,
            suffixIcon: InkResponse(
              onTap: onShowCalendarClick,
              child: Icon(widget.textFieldStyle.icon,
                  color: widget.textFieldStyle.iconColor),
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
      reverseDuration: const Duration(seconds: 1),
    );

    final res = await showModalBottomSheet(
      isScrollControlled: true,
      transitionAnimationController: aCtr,
      elevation: widget.elevation,
      backgroundColor: widget.backgroundColorBottomSheet ??
          Theme.of(context).colorScheme.inversePrimary,
      shape: widget.shapeBottomSheet,
      context: context,
      builder: (BuildContext context) {
        return PersianCalendarView(
          minAge: widget.minAge,
          selectedDate: currentDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          widget: widget,
          onChanged: (newDate) {
            setState(() {
              currentDate = newDate;
              controller.text = currentDate.formatFullDate();
            });
          },
        );
      },
    );
    if (res is Jalali) {
      setState(() {
        currentDate = res;
        controller.text = currentDate.formatFullDate();
      });
      widget.onTimeChanged?.call(currentDate, currentDate.formatFullDate(),
          currentDate.formatPersianFullDateWithDay());
    }
  }
}

/// [PersianCalendarView] is a widget that displays a Persian calendar view.
///
/// It takes in several parameters to customize its behavior and appearance.
class PersianCalendarView extends StatefulWidget {
  /// The minimum age that can be selected.
  final num minAge;

  /// The currently selected date.
  final Jalali selectedDate;

  /// The first date that can be selected.
  final Jalali firstDate;

  /// The last date that can be selected.
  final Jalali lastDate;

  /// The [DatePickerPersian] widget.
  final DatePickerPersian widget;

  /// A callback function that is called when the date is changed.
  final Function(Jalali) onChanged;

  /// Creates a [PersianCalendarView] widget.
  ///
  /// Required parameters:
  /// - [minAge]: The minimum age that can be selected.
  /// - [selectedDate]: The currently selected date.
  /// - [firstDate]: The first date that can be selected.
  /// - [lastDate]: The last date that can be selected.
  /// - [widget]: The [DatePickerPersian] widget.
  /// - [onChanged]: A callback function that is called when the date is changed.
  const PersianCalendarView({
    super.key,
    required this.minAge,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.widget,
    required this.onChanged,
  });

  @override
  State<PersianCalendarView> createState() => _PersianCalendarViewState();
}

class _PersianCalendarViewState extends State<PersianCalendarView> {
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;
  late Jalali currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = widget.selectedDate;
    yearController = FixedExtentScrollController(
        initialItem: getSelectedYearIndex(currentDate));
    monthController = FixedExtentScrollController(
        initialItem: getSelectedMonthIndex(currentDate));
    dayController = FixedExtentScrollController(
        initialItem: getSelectedDayIndex(currentDate));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              currentDate.formatFullDate(),
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10), // Added space
          Divider(
            thickness: 1,
            color: widget.widget.dividerColor,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 10), // Added space
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: buildCupertinoPicker(
                    yearController,
                    getYears(),
                    (value) => onYearChanged(value),
                  ),
                ),
                Expanded(
                  child: buildCupertinoPicker(
                    monthController,
                    getMonths(),
                    (value) => onMonthChanged(value),
                  ),
                ),
                Expanded(
                  child: buildCupertinoPicker(
                    dayController,
                    getDays(),
                    (value) => onDayChanged(value),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Added space
          Divider(
            thickness: 1,
            color: widget.widget.dividerColor,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 20), // Added space
          buildButtonRow(context),
        ],
      ),
    );
  }

  // Function for building Cupertino pickers
  Widget buildCupertinoPicker(
    FixedExtentScrollController controller,
    List<int> items,
    Function(int) onSelectedItemChanged,
  ) {
    return CupertinoPicker.builder(
      scrollController: controller,
      diameterRatio: 1.0,
      itemExtent: 60,
      onSelectedItemChanged: onSelectedItemChanged,
      childCount: items.length,
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            convertToPersianDigits(items[index]).toString(),
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }

  void onYearChanged(int value) {
    final y = getYears()[value];
    final m = currentDate.month;
    currentDate = updateDateWithNewYearOrMonth(y, m);
    setState(() {});
  }

  void onMonthChanged(int value) {
    final m = getMonths()[value];
    final y = currentDate.year;
    currentDate = updateDateWithNewYearOrMonth(y, m);
    setState(() {});
  }

  void onDayChanged(int value) {
    final d = getDays()[value];
    currentDate = Jalali(currentDate.year, currentDate.month, d);
    widget.onChanged(currentDate);
    setState(() {});
  }

  Jalali updateDateWithNewYearOrMonth(int y, int m) {
    int dayCount = getDaysInMonth(y, m).length;
    if (dayCount <= currentDate.day) {
      final days = getDaysInMonth(y, m);
      return Jalali(y, m, days[days.length - 1]);
    } else {
      return Jalali(y, m, currentDate.day);
    }
  }

  // Button row
  Widget buildButtonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: buildMaterialButton(
              height: widget.widget.confirmButtonConfig?.height ?? 55,
              minWidth: widget.widget.confirmButtonConfig?.minWidth ??
                  double.infinity,
              color: widget.widget.confirmButtonConfig?.color ?? Colors.red,
              text: widget.widget.cancelButtonConfig?.text ?? 'بازگشت',
              onPressed: () => Navigator.of(context).pop(),
              shape: widget.widget.confirmButtonConfig?.shape ??
                  const StadiumBorder(),
              style: widget.widget.cancelButtonConfig?.style ??
                  const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: buildMaterialButton(
              height: widget.widget.confirmButtonConfig?.height ?? 55,
              minWidth: widget.widget.confirmButtonConfig?.minWidth ??
                  double.infinity,
              color: widget.widget.confirmButtonConfig?.color ?? Colors.blue,
              text: widget.widget.confirmButtonConfig?.text ?? 'انتخاب',
              onPressed: () => Navigator.of(context).pop(currentDate),
              shape: widget.widget.confirmButtonConfig?.shape ??
                  const StadiumBorder(),
              style: widget.widget.confirmButtonConfig?.style ??
                  const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Button builder
  Widget buildMaterialButton(
      {required double height,
      required double minWidth,
      required Color color,
      required String text,
      required Function() onPressed,
      required TextStyle? style,
      required ShapeBorder? shape}) {
    return MaterialButton(
      height: height,
      minWidth: minWidth,
      color: color,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  List<int> getYears() {
    return List<int>.generate(widget.lastDate.year - widget.firstDate.year + 1,
        (index) => widget.firstDate.year + index);
  }

  int getSelectedYearIndex(Jalali date) {
    return getYears().indexOf(date.year);
  }

  List<int> getMonths() {
    return List<int>.generate(12, (index) => index + 1);
  }

  int getSelectedMonthIndex(Jalali date) {
    return getMonths().indexOf(date.month);
  }

  List<int> getDays() {
    return List<int>.generate(
        Jalali(currentDate.year, currentDate.month, 1).monthLength,
        (index) => index + 1);
  }

  int getSelectedDayIndex(Jalali date) {
    return getDays().indexOf(date.day);
  }

  List<int> getDaysInMonth(int year, int month) {
    return List<int>.generate(
        Jalali(year, month, 1).monthLength, (index) => index + 1);
  }
}
