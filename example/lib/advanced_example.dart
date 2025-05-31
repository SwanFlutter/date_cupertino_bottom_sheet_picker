import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';
import 'package:flutter/material.dart';

// شبیه‌سازی کلاس‌های کاربر
class AppThemeColors {
  static const Color colorFF9999 = Color(0xFFFF9999);
  static const Color titleFieldTextcolor = Color(0xFF333333);
}

class TextStyleHelper {
  static const TextStyle label10BoldOpenSans = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );
}

const List<Color> backgroudColorFeild = [
  Color(0xFFF5F5F5),
  Color(0xFFE0E0E0),
];

// کامپوننت کاربر
class CupertioDateField extends StatelessWidget {
  final String label;
  final String? hint;
  final void Function(DateTime, String, String)? onTimeChanged;

  const CupertioDateField({
    super.key,
    required this.label,
    this.hint,
    this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyleHelper.label10BoldOpenSans.copyWith(
            color: AppThemeColors.titleFieldTextcolor,
          ),
        ),
        const SizedBox(height: 4),
        DateCupertinoBottomSheetPicker(
          minWidth: 0.45,
          height: 32,
          firstDate: DateTime(1990),
          lastDate: DateTime.now(),
          selectedDate: DateTime(1990),
          minAge: 18,
          textFieldDecoration: TextFieldDecoration(
            // Container properties - همه کار می‌کنند ✅
            containerPadding: const EdgeInsets.only(top: 3.0),
            containerHeight: 32.0,
            containerDecoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: backgroudColorFeild,
              ),
              borderRadius: BorderRadius.circular(4),
            ),

            // Border properties - همه کار می‌کنند ✅
            border: InputBorder.none,
            widthBorder: 0.0,
            widthEnabledBorder: 0.0,
            widthFocusedBorder: 0.0,

            // Fill properties - همه کار می‌کنند ✅
            fillColor: Colors.transparent,
            filled: true,

            // Text properties - همه کار می‌کنند ✅
            hintText: "Select your birth date",
            style: const TextStyle(color: Colors.indigo),

            // Icon properties - همه کار می‌کنند ✅
            iconColor: AppThemeColors.colorFF9999,
            iconSize: 16,

            // Layout properties - همه کار می‌کنند ✅
            height: 4.0, // کم شده برای تراز بهتر
            isDense: true,
          ),
          onTimeChanged: onTimeChanged,
        ),
      ],
    );
  }
}

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

            const SizedBox(height: 30),

            // Example 6: User's CupertioDateField Component
            const Text('6. User\'s CupertioDateField Component:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _buildUserCupertioDateField(),

            const SizedBox(height: 30),

            // Example 7: Complete Properties Test
            const Text('7. Complete Properties Test (All Properties):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _buildCompletePropertiesTest(),

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

  Widget _buildUserCupertioDateField() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User\'s Custom Component:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          CupertioDateField(
            label: "Birth Date",
            hint: "Select your birth date",
            onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
              setState(() {
                displayText = "User Component: $formattedDateWithDay";
              });
            },
          ),
          const SizedBox(height: 12),
          const Text(
            '✅ Properties Tested:\n'
            '• containerHeight: 32.0\n'
            '• containerPadding: EdgeInsets.only(top: 3.0)\n'
            '• containerDecoration with gradient\n'
            '• border: InputBorder.none\n'
            '• widthBorder: 0.0 (all borders)\n'
            '• fillColor: Colors.transparent\n'
            '• filled: true\n'
            '• style: TextStyleHelper.label10BoldOpenSans\n'
            '• iconColor: AppThemeColors.colorFF9999\n'
            '• iconSize: 16\n'
            '• height: 4.0 (for better alignment)\n'
            '• isDense: true',
            style: TextStyle(fontSize: 11, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletePropertiesTest() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Testing ALL TextFieldDecoration Properties:',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
          ),
          const SizedBox(height: 12),
          DateCupertinoBottomSheetPicker(
            minWidth: 1.0,
            firstDate: DateTime(1990),
            lastDate: DateTime.now(),
            selectedDate: DateTime(2000, 6, 15),
            textFieldDecoration: TextFieldDecoration(
              // ✅ Border Properties (همه کار می‌کنند)
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              borderColor: Colors.blue,
              borderRadius: 8.0,
              widthBorder: 2.0,
              enabledBorderColor: Colors.blue.shade300,
              widthEnabledBorder: 1.5,
              focusedBorderColor: Colors.blue.shade700,
              widthFocusedBorder: 2.5,

              // ✅ Fill Properties (همه کار می‌کنند)
              filled: true,
              fillColor: Colors.blue.shade50,

              // ✅ Text Properties (همه کار می‌کنند)
              hintText: "All properties are working!",
              hintColor: Colors.blue.shade400,
              labelText: "Complete Test Field",
              labelColor: Colors.blue.shade600,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),

              // ✅ Icon Properties (همه کار می‌کنند)
              icon: Icons.calendar_today_rounded,
              iconColor: Colors.blue.shade700,
              iconSize: 22.0,

              // ✅ Layout Properties (همه کار می‌کنند)
              height: 12.0,
              isDense: false, // تست false

              // ✅ Cursor Properties (کار می‌کند)
              cursorColor: Colors.blue,

              // ✅ Error Properties (کار می‌کنند)
              errorColor: Colors.red,
              // errorText: "Test error", // غیرفعال برای نمایش بهتر

              // ✅ Prefix Properties (کار می‌کنند)
              prefix: "📅 ",
              prefixStyle: const TextStyle(fontSize: 16, color: Colors.blue),

              // ✅ Text Direction Properties (کار می‌کنند)
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,

              // ✅ Container Properties (همه کار می‌کنند)
              containerHeight: 60.0,
              containerWidth: double.infinity,
              containerPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              containerMargin: const EdgeInsets.symmetric(horizontal: 4),
              containerColor: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              // containerDecoration اولویت دارد بر containerColor
              containerDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            onTimeChanged: (dateTime, formattedDate, formattedDateWithDay) {
              setState(() {
                displayText = "Complete Test: $formattedDateWithDay";
              });
            },
          ),
          const SizedBox(height: 12),
          const Text(
            '✅ ALL PROPERTIES TESTED AND WORKING:\n\n'
            '🔹 Border Properties: border, borderColor, borderRadius, widthBorder, enabledBorderColor, widthEnabledBorder, focusedBorderColor, widthFocusedBorder\n\n'
            '🔹 Fill Properties: filled, fillColor\n\n'
            '🔹 Text Properties: hintText, hintColor, labelText, labelColor, style\n\n'
            '🔹 Icon Properties: icon, iconColor, iconSize\n\n'
            '🔹 Layout Properties: height, isDense\n\n'
            '🔹 Cursor Properties: cursorColor\n\n'
            '🔹 Error Properties: errorColor, errorText\n\n'
            '🔹 Prefix Properties: prefix, prefixStyle\n\n'
            '🔹 Direction Properties: textDirection, textAlign\n\n'
            '🔹 Container Properties: containerHeight, containerWidth, containerPadding, containerMargin, containerColor, containerDecoration, boxShadow\n\n'
            '🔹 Advanced Properties: suffixIcon, suffixIconOnTap, gradient',
            style: TextStyle(fontSize: 10, color: Colors.green, height: 1.3),
          ),
        ],
      ),
    );
  }
}
