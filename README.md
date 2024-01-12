This is a date package in the form of Cupertino and you can set the age limit of your users

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

```yaml
dependencies:
  date_cupertino_bottom_sheet_picker: ^0.0.1
```


```dart
import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';

```

## Usage

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
                width: 1.0,
                firstDate: DateTime(1990),
                lastDate: DateTime(2050),
                selectedDate: selectedDate,
                minAge: 18,
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
For more information about this package, you can also visit our [GitHub repository]() where you can find additional resources, contribute to the package's development, and file issues or bug reports. We appreciate your contributions and feedback, and we aim to make this package as useful as possible for our users.
Thank you for using our package, and we look forward to hearing from you!