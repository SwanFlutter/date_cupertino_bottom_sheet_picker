import 'package:flutter_test/flutter_test.dart';

import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';

void main() {
  test('adds one to input values', () {
    final calculator = DateCupertinoBottomSheetPicker();
    expect(calculator.toString(), 3);
    expect(calculator.toString(), -6);
    expect(calculator.toString(), 1);
  });
}
