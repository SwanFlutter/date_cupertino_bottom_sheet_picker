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
              horizontal: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  widget.textFieldDecoration?.borderRadius ?? 12.0),
              borderSide: BorderSide(
                color: widget.textFieldDecoration?.borderColor ?? Colors.black,
                width: widget.textFieldDecoration?.widthBorder ?? 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  widget.textFieldDecoration?.borderRadius ?? 12.0),
              borderSide: BorderSide(
                color: widget.textFieldDecoration?.focusedBorderColor ??
                    Colors.black,
                width: widget.textFieldDecoration?.widthFocusedBorder ?? 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
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
            hintText: widget.textFieldDecoration?.hintText,
            hintStyle: TextStyle(color: widget.textFieldDecoration?.hintColor),
            labelText: widget.textFieldDecoration?.labelText,
            labelStyle:
                TextStyle(color: widget.textFieldDecoration?.labelTaxtColor),
            suffixIcon: InkResponse(
              onTap: onShowCalendarClick,
              child: Icon(
                widget.textFieldDecoration?.icon ?? Icons.calendar_month,
                color: widget.textFieldDecoration?.iconColor ?? Colors.black,
              ),
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

/*/// A callback function that is called when the date changes.
typedef OnDateChange = void Function(DateTime dateTime, String formattedDate, String formattedDateWithDay);

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
    this.timeTextStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
  })  : selectedDate = selectedDate ?? DateTime(1995, 4, 21),
        firstDate = firstDate ?? DateTime(1960, 1, 1),
        lastDate = lastDate ??= DateTime(2060),
        border = border ?? const OutlineInputBorder(),
        shapeBottomSheet = shapeBottomSheet ?? OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        super();
  @override
  State<DateTimePickerGregorian> createState() => _DateTimePickerGregorianState();
}

class _DateTimePickerGregorianState extends State<DateTimePickerGregorian> with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late DateTime currentDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    currentDate = widget.selectedDate;
    controller = TextEditingController();
    // controller.text = widget.selectedDate.toString().split(' ')[0];
    selectedTime = TimeOfDay.now();
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
        child: TextField(
          readOnly: true,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          style: widget.textFieldDecoration?.style ?? TextStyle(color: Colors.black),
          cursorColor: widget.textFieldDecoration?.cursorColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: widget.textFieldDecoration?.height ?? 15.0, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.textFieldDecoration?.borderRadius ?? 12.0),
              borderSide: BorderSide(color: widget.textFieldDecoration?.borderColor ?? Colors.black, width: widget.textFieldDecoration?.widthBorder ?? 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.textFieldDecoration?.borderRadius ?? 12.0),
              borderSide: BorderSide(color: widget.textFieldDecoration?.focusedBorderColor ?? Colors.black, width: widget.textFieldDecoration?.widthFocusedBorder ?? 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.textFieldDecoration?.borderRadius ?? 12.0),
              borderSide: BorderSide(color: widget.textFieldDecoration?.enabledBorderColor ?? Colors.black, width: widget.textFieldDecoration?.widthEnabledBorder ?? 1.0),
            ),
            fillColor: widget.textFieldDecoration?.fillColor ?? Colors.white,
            filled: widget.textFieldDecoration?.filled ?? true,
            errorStyle: TextStyle(color: widget.textFieldDecoration?.errorColor),
            hintText: widget.textFieldDecoration?.hintText,
            hintStyle: TextStyle(color: widget.textFieldDecoration?.hintColor),
            labelText: widget.textFieldDecoration?.labelText,
            labelStyle: TextStyle(color: widget.textFieldDecoration?.labelTaxtColor),
            errorText: widget.textFieldDecoration?.errorText,
            prefix: Text(
              widget.textFieldDecoration?.prefix ?? '',
            ),
            prefixStyle: widget.textFieldDecoration?.prefixStyle ?? TextStyle(fontSize: 20, color: Colors.black),
            suffixIcon: InkResponse(
              onTap: onShowCalendarClick,
              child: Icon(widget.textFieldDecoration?.icon ?? Icons.calendar_month, color: widget.textFieldDecoration?.iconColor ?? Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  void onShowCalendarClick() async {
    final aCtr = AnimationController(vsync: this, duration: const Duration(seconds: 1), reverseDuration: const Duration(seconds: 1));

    final res = await showModalBottomSheet(
      isScrollControlled: true,
      transitionAnimationController: aCtr,
      elevation: widget.elevation,
      backgroundColor: widget.backgroundColorBottomSheet ?? Theme.of(context).colorScheme.inversePrimary,
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
      currentDate = res;
      // استفاده از متد viewFormatDateTimeFor برای آپدیت متن
      TimeOfDay selectedTime = TimeOfDay.fromDateTime(res);
      controller.text = viewFormatDateTimeFor(currentDate, selectedTime);

      widget.onTimeChanged?.call(currentDate, currentDate.formatFullDate(), currentDate.formatFullDateWithDay());
    }
  }
}

class ViewWidgetGregorian extends StatefulWidget {
  /// The current date.
  DateTime currentDate;

  /// The selected time.
  TimeOfDay selectedTime;

  /// The date and time combined.
  String timeAndDate;

  /// The [DateCupertinoBottomSheetPicker] widget.
  DateTimePickerGregorian dateTimePickerGregorian;

  /// Creates a [ViewWidgetGregorian].
  ///
  /// Required parameters:
  /// - [dateCupertinoBottomSheetPicker]: The [DateCupertinoBottomSheetPicker] widget.
  /// - [currentDate]: The current date.
  /// - [selectedTime]: The selected time.
  /// - [timeAndDate]: The date and time combined.
  ViewWidgetGregorian({
    super.key,
    required this.currentDate,
    required this.selectedTime,
    required this.timeAndDate,
    required this.dateTimePickerGregorian,
  });

  @override
  State<ViewWidgetGregorian> createState() => _ViewWidgetGregorianState();
}

class _ViewWidgetGregorianState extends State<ViewWidgetGregorian> {
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
    final double progress = _pageController.hasClients ? (_pageController.page ?? 0) : 0;
    ThemeData themeData = Theme.of(context);
    var widgets = widget.dateTimePickerGregorian;
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
                    CalendarViewDate(
                      minAge: widgets.minAge,
                      selectedDate: widgets.selectedDate,
                      firstDate: widgets.firstDate,
                      lastDate: widgets.lastDate,
                      dateCupertinoBottomSheetPicker: widget.dateTimePickerGregorian,
                      onChange: (DateTime dateTime) {
                        if (widget.currentDate != dateTime) {
                          setState(() {
                            widget.currentDate = dateTime;
                          });
                        }
                      },
                    ),
                    DateAndTimeGregorian(
                      timeAndDate: widget.timeAndDate,
                      selectedTime: widget.selectedTime,
                      currentDate: widget.currentDate,
                      dividerColor: widgets.dividerColor,
                      selectedDate: widget.currentDate,
                      firstDate: widgets.firstDate,
                      lastDate: widgets.lastDate,
                      minAge: widgets.minAge,
                      onTimeChanged: (TimeOfDay newTime, DateTime newDate) {
                        if (widget.selectedTime != newTime || widget.currentDate != newDate) {
                          setState(() {
                            widget.selectedTime = newTime;
                            widget.currentDate = newDate;
                          });
                        }
                      },
                      dateCupertinoBottomSheetPicker: widget.dateTimePickerGregorian,
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
                  _pageController.animateToPage(1, duration: const Duration(milliseconds: 700), curve: Curves.ease);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: themeData.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      widgets.timeText,
                      style: widgets.timeTextStyle,
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
                        shape: widgets.cancelButtonConfig?.shape ?? const StadiumBorder(),
                        onPressed: () {
                          _pageController.animateToPage(0, duration: const Duration(milliseconds: 700), curve: Curves.ease);
                        },
                        child: Text(
                          widgets.cancelButtonConfig?.text ?? 'Cancel',
                          style: widgets.cancelButtonConfig?.style ??
                              const TextStyle(
                                color: Colors.white,
                              ),
                        ),
                      ),
                      MaterialButton(
                        minWidth: minWidth,
                        height: buttonHeight,
                        color: widgets.confirmButtonConfig?.color ?? Colors.blue,
                        shape: widgets.confirmButtonConfig?.shape ?? const StadiumBorder(),
                        onPressed: () {
                          String formattedTime = '${widget.selectedTime.hour}:${widget.selectedTime.minute.toString().padLeft(2, '0')} ${widget.selectedTime.period == DayPeriod.am ? 'صبح' : 'بعد از ظهر'}';
                          Navigator.of(context).pop({
                            'date': widget.currentDate,
                            'time': formattedTime,
                          });
                        },
                        child: Text(
                          widgets.confirmButtonConfig?.text ?? "Select",
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

class DateAndTimeGregorian extends StatefulWidget {
  /// The current date.
  late DateTime currentDate;

  /// The selected time.
  late TimeOfDay selectedTime;

  /// The selected date.
  final DateTime selectedDate;

  /// The first date that can be selected.
  final DateTime firstDate;

  /// The last date that can be selected.
  final DateTime lastDate;

  /// The minimum age that can be selected.
  final num minAge;

  /// The color of the divider.
  final Color dividerColor;

  /// A callback function that is called when the time is changed.
  final Function(TimeOfDay) onTimeChanged;

  /// The date and time combined.
  final String timeAndDate;

  final DateTimePickerGregorian dateCupertinoBottomSheetPicker;

  /// Creates a [DateAndTimeGregorian] widget.
  ///
  /// Required parameters:
  /// - [currentDate]: The current date.
  /// - [selectedTime]: The selected time.
  /// - [selectedDate]: The selected date.
  /// - [firstDate]: The first date that can be selected.
  /// - [lastDate]: The last date that can be selected.
  /// - [minAge]: The minimum age that can be selected.
  /// - [dividerColor]: The color of the divider.
  /// - [onTimeChanged]: A callback function that is called when the time is changed.
  /// - [timeAndDate]: The date and time combined.
  DateAndTimeGregorian({
    super.key,
    required this.currentDate,
    required this.selectedTime,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.minAge,
    required this.dividerColor,
    required this.onTimeChanged,
    required this.timeAndDate,
    required this.dateCupertinoBottomSheetPicker,
  });

  @override
  State<DateAndTimeGregorian> createState() => _DateAndTimeGregorianState();
}

class _DateAndTimeGregorianState extends State<DateAndTimeGregorian> {
  late String displayTimeAndDate;

  @override
  void initState() {
    super.initState();
    displayTimeAndDate = widget.timeAndDate;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimationDelayed(
            delay: const Duration(milliseconds: 700),
            slideDirection: SlideDirection.rightToLeft,
            child: Text(
              displayTimeAndDate,
              style: TextStyle(fontSize: theme.textTheme.headlineSmall!.fontSize, fontWeight: FontWeight.w600, color: theme.colorScheme.primary),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Divider(thickness: 1, color: theme.colorScheme.primary, indent: 0, endIndent: 0),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: GregorianTimePicker(
              dividerColor: theme.colorScheme.primary,
              onTimeChanged: (String timeString) {
                TimeOfDay time = stringToTimeOfDay(timeString);
                widget.onTimeChanged(time);
                setState(() {
                  widget.selectedTime = time;
                  displayTimeAndDate = time.viewFormatDateTimeFor(widget.currentDate, time);
                });
              },
              initialTime: "8:00",
            ),
          ),
          SizedBox(height: 10),
          Divider(thickness: 1, color: theme.colorScheme.primary, indent: 0, endIndent: 0),
          SizedBox(height: 10),
          CalendarViewDate(
            minAge: widget.minAge,
            selectedDate: widget.selectedDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            dateCupertinoBottomSheetPicker: widget.dateCupertinoBottomSheetPicker,
            onChange: (DateTime dateTime) {
              if (mounted) {
                setState(() {
                  widget.currentDate = dateTime;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

String viewFormatDateTimeFor(DateTime dateTime, TimeOfDay time) {
// Format time to 24-hour format
  final formattedTime = convertTimeToStringEnglish(time);

//
  final formattedDate = dateTime.formatFullDate();

  return '$formattedDate  -  $formattedTime';
}

String convertTimeToStringEnglish(TimeOfDay time) {
  final persianHour = convertToEnglishDigits(time.hour);
  final persianMinute = convertToEnglishDigits(time.minute);
  return '$persianHour:${persianMinute.padLeft(2, '0')}';
}
*/
