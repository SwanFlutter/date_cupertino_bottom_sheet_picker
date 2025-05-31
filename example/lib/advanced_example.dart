import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';
import 'package:flutter/material.dart';

class AdvancedExample extends StatefulWidget {
  const AdvancedExample({Key? key}) : super(key: key);

  @override
  State<AdvancedExample> createState() => _AdvancedExampleState();
}

class _AdvancedExampleState extends State<AdvancedExample> {
  DateTime? selectedDate = DateTime(2010, 12, 5);
  String displayText = "Select a date";
  final TextEditingController customController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Date Picker Example'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              displayText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Example 1: No Border with Gradient Container
            const Text('1. No Border with Gradient Container:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            DateCupertinoBottomSheetPicker(
              minWidth: 1.0,
              firstDate: DateTime(1990),
              lastDate: DateTime.now(),
              selectedDate: selectedDate,
              minAge: 18,
              textFieldDecoration: TextFieldDecoration(
                border: InputBorder.none,
                widthBorder: 0.0,
                widthEnabledBorder: 0.0,
                widthFocusedBorder: 0.0,
                fillColor: Colors.transparent,
                filled: true,
                hintText: "Select your birth date",
                labelText: "Birth Date",
                labelColor: Colors.white,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                iconColor: Colors.white,
                // Container with gradient
                containerDecoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                containerPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              confirmButtonConfig: ConfirmButtonConfig(
                color: Colors.purple,
                text: "انتخاب",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              cancelButtonConfig: CancelButtonConfig(
                color: Colors.grey,
                text: "لغو",
                style: const TextStyle(color: Colors.white),
              ),
              onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
                setState(() {
                  selectedDate = dateTime;
                  displayText = "Selected: $formattedDateWithDay";
                });
              },
            ),

            const SizedBox(height: 30),

            // Example 2: RTL Text with Custom Suffix Icon (Working!)
            const Text('2. RTL Text with Custom Suffix Icon (Working!):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            DateCupertinoBottomSheetPicker(
              minWidth: 1.0,
              firstDate: DateTime(1990),
              lastDate: DateTime.now(),
              selectedDate: selectedDate,
              minAge: 18,
              textFieldDecoration: TextFieldDecoration(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                hintText: "تاریخ تولد خود را انتخاب کنید",
                labelText: "تاریخ تولد",
                labelColor: Colors.orange, // حالا کار می‌کند!
                style: const TextStyle(color: Colors.black, fontSize: 16),
                borderColor: Colors.orange,
                focusedBorderColor: Colors.deepOrange,
                enabledBorderColor: Colors.orange.shade300,
                borderRadius: 20,
                // Custom suffix icon - حالا کار می‌کند!
                suffixIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.date_range,
                      color: Colors.orange, size: 20),
                ),
                // یا می‌توانید از icon و iconSize استفاده کنید:
                // icon: Icons.date_range,
                // iconColor: Colors.orange,
                // iconSize: 28.0,
                // اگر suffixIconOnTap تنظیم نشود، از عملکرد پیش‌فرض استفاده می‌کند
                // suffixIconOnTap: null, // استفاده از عملکرد پیش‌فرض
              ),
              confirmButtonConfig: ConfirmButtonConfig(
                color: Colors.orange,
                text: "تایید",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
                setState(() {
                  selectedDate = dateTime;
                  displayText = "انتخاب شده: $formattedDateWithDay";
                });
              },
            ),

            const SizedBox(height: 30),

            // Example 3: Persian Date Picker with Gradient
            const Text('3. Persian Date Picker with Gradient:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            DateCupertinoBottomSheetPicker.datePickerPersian(
              minWidth: 1.0,
              textFieldDecoration: TextFieldDecoration(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                hintText: "تاریخ شمسی",
                style: const TextStyle(color: Colors.white, fontSize: 16),
                border: InputBorder.none,
                widthBorder: 0.0,
                widthEnabledBorder: 0.0,
                widthFocusedBorder: 0.0,
                fillColor: Colors.transparent,
                filled: true,
                iconColor: Colors.white,
                iconSize: 28.0, // آیکون بزرگ‌تر
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.teal],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                containerPadding: const EdgeInsets.all(16),
                borderRadius: 12,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              confirmButtonConfig: ConfirmButtonConfig(
                color: Colors.green,
                text: "انتخاب",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              cancelButtonConfig: CancelButtonConfig(
                color: Colors.red,
                text: "بازگشت",
              ),
              onChanged: (dateTime, formattedDate, formattedDateWithDay) {
                setState(() {
                  displayText = "تاریخ انتخابی: $formattedDateWithDay";
                });
              },
            ),

            const SizedBox(height: 30),

            // Example 4: Custom Container with Shadow
            const Text('4. Custom Container with Shadow:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            DateCupertinoBottomSheetPicker(
              minWidth: 1.0,
              firstDate: DateTime(1990),
              lastDate: DateTime.now(),
              selectedDate: selectedDate,
              textFieldDecoration: TextFieldDecoration(
                hintText: "Select date with style",
                labelText: "Styled Date",
                borderRadius: 25,
                borderColor: Colors.indigo,
                focusedBorderColor: Colors.indigoAccent,
                icon: Icons.calendar_month_rounded, // آیکون گرد
                iconColor: Colors.indigo,
                iconSize: 26.0, // سایز متوسط
                labelColor: Colors.indigo, // رنگ label
                containerColor: Colors.indigo.shade50,
                containerPadding: const EdgeInsets.all(4),
                containerMargin: const EdgeInsets.symmetric(horizontal: 8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                ],
              ),
              confirmButtonConfig: ConfirmButtonConfig(
                color: Colors.indigo,
                text: "Select",
                shape: const StadiumBorder(),
              ),
              onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
                setState(() {
                  selectedDate = dateTime;
                  displayText = "Styled Selection: $formattedDateWithDay";
                });
              },
            ),

            const SizedBox(height: 30),

            // Example 5: Custom Suffix Icon with Custom OnTap (Fixed!)
            const Text('5. Custom Suffix Icon with Custom OnTap (Fixed!):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _buildCustomDatePickerExample(),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomDatePickerExample() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        readOnly: true,
        controller: customController,
        decoration: InputDecoration(
          hintText: "Custom icon with custom action",
          labelText: "Custom Action Date",
          labelStyle: const TextStyle(color: Colors.purple),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: GestureDetector(
            onTap: () async {
              // نمایش date picker دستی
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(1990),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  selectedDate = picked;
                  customController.text = picked.toString().split(' ')[0];
                  displayText =
                      "Custom Action: ${picked.toString().split(' ')[0]}";
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
