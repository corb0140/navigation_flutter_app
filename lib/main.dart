import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/data_screen.dart';
import 'screens/contacts_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MainApp createState() => MainApp();
}

class MainApp extends State<MyApp> {
  // State variable to track selected index
  int pageIndex = 0;

  // List of pages
  List<Widget> pages = [
    HomeScreen(),
    DataScreen(),
    ContactsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: Colors.white,
              secondary: Colors.red,
              tertiary: Colors.black,
            ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headlineLarge:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              headlineMedium:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              bodyLarge: const TextStyle(fontSize: 16),
              bodyMedium: const TextStyle(fontSize: 14),
            ),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Navigation"),
          ),
          body: pages[pageIndex], // Display the selected page
          bottomNavigationBar: NavigationBar(
            indicatorColor: Colors.red,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.data_usage), label: 'Data'),
              NavigationDestination(
                  icon: Icon(Icons.contacts), label: 'Contacts'),
            ],
            selectedIndex: pageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                pageIndex = index; //
              });
            },
          )),
    );
  }
}
