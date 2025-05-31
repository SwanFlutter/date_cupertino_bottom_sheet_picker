import 'package:date_cupertino_bottom_sheet_picker/src/extensions/default.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/cancel_buttom.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/confirm_button.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/global/text_feild_config.dart';
import 'package:date_cupertino_bottom_sheet_picker/src/widget/gregorian/view_widget_gregorian.dart';
import 'package:flutter/material.dart';

/// A callback function that is called when the date changes.
typedef OnDateChange = void Function(
    DateTime dateTime, String formattedDate, String formattedDateWithDay);

/// A widget that displays a Gregorian date picker.
class DateTimePickerGregorian extends StatefulWidget {
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

  /// The text for the time.
  final String timeText;

  final Color? timeColorBottom;

  /// The text style for the time.
  final TextStyle? timeTextStyle;

  /// Creates a [DateTimePickerGregorian] widget.
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
  /// - [timeText]: The text for the time.
  /// - [timeTextStyle]: The text style for the time.
  DateTimePickerGregorian({
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
    this.timeText = 'What time?',
    this.timeColorBottom,
    this.timeTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
  })  : selectedDate = selectedDate ?? DateTime(1995, 4, 21),
        firstDate = firstDate ?? DateTime(1960, 1, 1),
        lastDate = lastDate ??= DateTime(2060),
        border = border ?? const OutlineInputBorder(),
        shapeBottomSheet = shapeBottomSheet ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        super();
  @override
  State<DateTimePickerGregorian> createState() =>
      _DateTimePickerGregorianState();
}

class _DateTimePickerGregorianState extends State<DateTimePickerGregorian>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late DateTime currentDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    currentDate = widget.selectedDate;
    selectedTime = TimeOfDay.fromDateTime(widget.selectedDate);
    controller.text = viewFormatDateTimeFor(currentDate, selectedTime);

    super.initState();
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
        child: _buildTextField(),
      ),
    );
  }

  Widget _buildTextField() {
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
          horizontal: 10,
        ),
        isDense: widget.textFieldDecoration?.isDense ?? true,
        border: widget.textFieldDecoration?.border ??
            (widget.textFieldDecoration?.widthBorder == 0.0
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        widget.textFieldDecoration?.borderRadius ?? 12.0),
                    borderSide: BorderSide(
                      color: widget.textFieldDecoration?.borderColor ??
                          Colors.black,
                      width: widget.textFieldDecoration?.widthBorder ?? 1.0,
                    ),
                  )),
        focusedBorder: widget.textFieldDecoration?.widthFocusedBorder == 0.0
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    widget.textFieldDecoration?.borderRadius ?? 12.0),
                borderSide: BorderSide(
                  color: widget.textFieldDecoration?.focusedBorderColor ??
                      Colors.black,
                  width: widget.textFieldDecoration?.widthFocusedBorder ?? 1.0,
                ),
              ),
        enabledBorder: widget.textFieldDecoration?.widthEnabledBorder == 0.0
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    widget.textFieldDecoration?.borderRadius ?? 12.0),
                borderSide: BorderSide(
                  color: widget.textFieldDecoration?.enabledBorderColor ??
                      Colors.black,
                  width: widget.textFieldDecoration?.widthEnabledBorder ?? 1.0,
                ),
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
                  color: widget.textFieldDecoration?.iconColor ?? Colors.black,
                  size: widget.textFieldDecoration?.iconSize ?? 24.0,
                ),
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

    return textField;
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
        return ViewWidgetGregorian(
          dateTimePickerGregorian: widget,
          currentDate: currentDate,
          selectedTime: selectedTime,
          timeAndDate: viewFormatDateTimeFor(currentDate, selectedTime),
        );
      },
    );

    if (res is DateTime) {
      setState(() {
        currentDate = res;
        selectedTime = TimeOfDay(hour: res.hour, minute: res.minute);
        controller.text = viewFormatDateTimeFor(currentDate, selectedTime);
      });

      widget.onTimeChanged?.call(
        currentDate,
        currentDate.formatFullDate(),
        currentDate.formatFullDateWithDay(),
      );
    } else {
      debugPrint(
          "onShowCalendarClick - Modal returned null or invalid type: $res");
    }
  }
}
