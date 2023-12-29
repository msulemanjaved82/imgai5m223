import 'package:flutter/material.dart';
import 'package:imgai/Generate.dart';
import 'profile.dart';
import 'package:imgai/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Image_Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    GeneratePage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 24, 129),
        title: const Text(
          'AI image_Generator',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White font color
            shadows: [
              Shadow(
                color: Colors.black, // Shadow color
                offset: Offset(2, 2), // Shadow offset
                blurRadius: 2, // Shadow blur radius
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 24, 129), // Background color
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color
              blurRadius: 10, // Shadow blur radius
              offset: const Offset(0, -5), // Shadow offset
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                shadows: [
                  Shadow(
                    color: Colors.black, // Shadow color
                    offset: Offset(2, 2), // Shadow offset
                    blurRadius: 2, // Shadow blur radius
                  ),
                ],
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_tree_outlined,
                size: 30,
                shadows: [
                  Shadow(
                    color: Colors.black, // Shadow color
                    offset: Offset(2, 2), // Shadow offset
                    blurRadius: 2, // Shadow blur radius
                  ),
                ],
              ),
              label: 'Generate',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
                size: 30,
                shadows: [
                  Shadow(
                    color: Colors.black, // Shadow color
                    offset: Offset(2, 2), // Shadow offset
                    blurRadius: 2, // Shadow blur radius
                  ),
                ],
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: const Color.fromARGB(255, 0, 24, 129),
          selectedItemColor: const Color.fromARGB(255, 0, 4, 255),
          unselectedItemColor:
              Colors.white, // Set unselected text color to white
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
