import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_pack_date_cupertino/new.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate = DateTime(2010, 12, 5);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                  print("dateTime: $dateTime, formattedDate: $formattedDate, formattedDateWithDay: $formattedDateWithDay");
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const New()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
