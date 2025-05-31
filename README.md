# Date Cupertino Bottom Sheet Picker

[![pub package](https://img.shields.io/pub/v/date_cupertino_bottom_sheet_picker.svg)](https://pub.dev/packages/date_cupertino_bottom_sheet_picker)
[![pub points](https://img.shields.io/pub/points/date_cupertino_bottom_sheet_picker?color=2E8B57&label=pub%20points)](https://pub.dev/packages/date_cupertino_bottom_sheet_picker/score)
[![popularity](https://img.shields.io/pub/popularity/date_cupertino_bottom_sheet_picker?color=orange)](https://pub.dev/packages/date_cupertino_bottom_sheet_picker/score)
[![likes](https://img.shields.io/pub/likes/date_cupertino_bottom_sheet_picker?color=red)](https://pub.dev/packages/date_cupertino_bottom_sheet_picker/score)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A beautiful and customizable Cupertino-style date picker widget for Flutter that displays as a bottom sheet. This package supports both Gregorian and Persian (Shamsi) calendars with age validation features.

## ✨ Features

- 🎨 **Cupertino Design**: Beautiful iOS-style date picker interface
- 📅 **Dual Calendar Support**: Both Gregorian and Persian (Shamsi) calendars
- ⏰ **Date & Time Picker**: Support for both date-only and date-time selection
- 🔒 **Age Validation**: Built-in minimum age restriction functionality
- 🌐 **Localization**: Persian and English language support
- 📱 **Responsive**: Adapts to different screen sizes
- 🎯 **Easy Integration**: Simple API with comprehensive callbacks

## 📸 Screenshots


## 🚀 Quick Start

### Basic Usage

![SheetPicker](https://github.com/SwanFlutter/date_cupertino_bottom_sheet_picker/assets/151648897/5ed512a7-e56e-46dc-b501-fbc14727a9e0)

```dart
DateCupertinoBottomSheetPicker(
  minWidth: 1.0,
  firstDate: DateTime(1990),
  lastDate: DateTime.now(),
  selectedDate: selectedDate,
  minAge: 18,
  textFieldDecoration: TextFieldDecoration(),
  onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
    print("Selected: $dateTime");
    print("Formatted: $formattedDate");
    print("With Day: $formattedDateWithDay");
  },
)
```

### Persian Date & Time Picker

![persian1](https://github.com/user-attachments/assets/3cb98fa6-2e37-4317-a430-70966be2af28)

```dart
DateCupertinoBottomSheetPicker.dateTimePickerPersian(
  minWidth: 0.9,
  onDateAndTimeChanged: (dateTime, formattedDate, formattedDateWithDay, timeOfDay, timeOfDayString, timeOfDayPersianString) {
    print("DateTime: $dateTime");
    print("Formatted Date: $formattedDate");
    print("Date with Day: $formattedDateWithDay");
    print("Time: $timeOfDay");
    print("Time String: $timeOfDayString");
    print("Persian Time: $timeOfDayPersianString");
  },
)
```

### Persian Date Picker

![persian](https://github.com/user-attachments/assets/4dc68077-5e35-4812-9dca-dab19775d6b6)

```dart
DateCupertinoBottomSheetPicker.datePickerPersian(
  minWidth: 0.9,
  onChanged: (dateTime, formattedDate, formattedDateWithDay) {
    print("Selected Date: $dateTime");
    print("Formatted: $formattedDate");
    print("With Day: $formattedDateWithDay");
  },
)
```

### Gregorian Date & Time Picker

![gregorian1](https://github.com/user-attachments/assets/a59e25be-75e3-4bff-be88-2e7f481b04e1)


```dart
DateCupertinoBottomSheetPicker.dateTimePickerGregorian(
  minWidth: 0.9,
  onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
    print("Selected: $dateTime");
    print("Formatted: $formattedDate");
    print("With Day: $formattedDateWithDay");
  },
)
```

### Gregorian Date Picker

![gregorian](https://github.com/user-attachments/assets/73669ab1-a6e7-4d97-bc14-c44824dcc12b)

```dart

Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DateCupertinoBottomSheetPicker(
                minWidth: 1.0,
                firstDate: DateTime(1990),
                lastDate: DateTime.now(),
                selectedDate: selectedDate,
                minAge: 18,
                textFieldDecoration: TextFieldDecoration(),
                onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
                  debugPrint(
                      "dateTime: $dateTime, formattedDate: $formattedDate, formattedDateWithDay: $formattedDateWithDay");
                },
              ),
            ),
          ),

```





## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  date_cupertino_bottom_sheet_picker: ^0.0.8
```

Then run:

```bash
flutter pub get
```

## 📚 Import

```dart
import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';
```

## 📋 API Reference

### DateCupertinoBottomSheetPicker

#### Properties

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `minWidth` | `double` | Minimum width of the picker | `1.0` |
| `firstDate` | `DateTime?` | Earliest selectable date | `null` |
| `lastDate` | `DateTime?` | Latest selectable date | `null` |
| `selectedDate` | `DateTime?` | Initially selected date | `null` |
| `minAge` | `int?` | Minimum age requirement | `null` |
| `textFieldDecoration` | `TextFieldDecoration?` | Text field styling | `null` |
| `onTimeChanged` | `Function` | Callback when date changes | Required |

#### Named Constructors

- `DateCupertinoBottomSheetPicker.datePickerPersian()` - Persian calendar date picker
- `DateCupertinoBottomSheetPicker.dateTimePickerPersian()` - Persian calendar date & time picker
- `DateCupertinoBottomSheetPicker.dateTimePickerGregorian()` - Gregorian calendar date & time picker

## 💡 Complete Example

Check the `/example` folder for a complete implementation.

```dart
import 'package:flutter/material.dart';
import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({Key? key}) : super(key: key);

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime? selectedDate = DateTime(2010, 12, 5);
  String displayText = "Select a date";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker Example'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DateCupertinoBottomSheetPicker(
                minWidth: 1.0,
                firstDate: DateTime(1990),
                lastDate: DateTime.now(),
                selectedDate: selectedDate,
                minAge: 18,
                textFieldDecoration: TextFieldDecoration(
                  hintText: "Select your birth date",
                  labelText: "Birth Date",
                ),
                onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
                  setState(() {
                    selectedDate = dateTime;
                    displayText = "Selected: $formattedDateWithDay";
                  });
                  print("DateTime: $dateTime");
                  print("Formatted: $formattedDate");
                  print("With Day: $formattedDateWithDay");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔧 Requirements

- Flutter SDK: `>=1.17.0`
- Dart SDK: `>=2.19.0 <4.0.0`

## 📦 Dependencies

This package uses the following dependencies:

- `intl: ^0.20.2` - For internationalization and date formatting
- `shamsi_date: ^1.1.0` - For Persian calendar support
- `fade_animation_delayed: ^0.0.2` - For smooth animations

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🐛 Issues & Support

If you encounter any issues or have questions:

- 📧 **Email**: [swan.dev1993@gmail.com](mailto:swan.dev1993@gmail.com)
- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/SwanFlutter/date_cupertino_bottom_sheet_picker/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/SwanFlutter/date_cupertino_bottom_sheet_picker/discussions)

## 🌟 Show Your Support

If this package helped you, please give it a ⭐ on [GitHub](https://github.com/SwanFlutter/date_cupertino_bottom_sheet_picker) and like it on [pub.dev](https://pub.dev/packages/date_cupertino_bottom_sheet_picker)!

## 📈 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed list of changes in each version.

---

**Made with ❤️ by [SwanFlutter](https://github.com/SwanFlutter)**
