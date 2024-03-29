This is a date package in the form of Cupertino and you can set the age limit of your users

## Features

![SheetPicker](https://github.com/SwanFlutter/date_cupertino_bottom_sheet_picker/assets/151648897/5ed512a7-e56e-46dc-b501-fbc14727a9e0)


## Getting started

```yaml
dependencies:
  date_cupertino_bottom_sheet_picker: ^0.0.4
```


```dart
import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';

```

## Example

to `/example` folder.

```dart
class PickerTest extends StatelessWidget {
  const PickerTest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate = DateTime(2010, 12, 5);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PickerTest'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DateCupertinoBottomSheetPicker(
                width: 1.0, // Changed width 0 to 1.0
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                selectedDate: controller.selectedDate,
                labelText: 'Date of birth...',
                labelTaxtColor: Colors.white,
                 hintColor: Colors.white,
                iconColor: Colors.white,
                minAge: 12,
                 height: 26,
                paddingVertical: 0,
                borderRadius: 8.0,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                borderColor: Colors.white,
                focusedBorderColor: Colors.white,
                enabledBorderColor: Colors.white,
                 onChanged: (dateTime) {
                controller.selectedDate = dateTime;
                controller.dateBirth.text = dateTime.toString();
                debugPrint("Date of birth: $dateTime");
                debugPrint(controller.dateBirth.text);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
```

## Additional information

If you have any issues, questions, or suggestions related to this package, please feel free to contact us at [swan.dev1993@gmail.com](mailto:swan.dev1993@gmail.com). We welcome your feedback and will do our best to address any problems or provide assistance.
For more information about this package, you can also visit our [GitHub repository](https://github.com/SwanFlutter/date_cupertino_bottom_sheet_picker) where you can find additional resources, contribute to the package's development, and file issues or bug reports. We appreciate your contributions and feedback, and we aim to make this package as useful as possible for our users.
Thank you for using our package, and we look forward to hearing from you!
