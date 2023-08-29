import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final DatabaseReference _menuRef =
      FirebaseDatabase.instance.ref().child('menu');
  List<String> _currentMenu = [];
  bool _isFetching = true;

  @override
  void initState() {
    super.initState();
    _fetchMenu();
  }

  Future<void> _fetchMenu() async {
    DateTime currentTime = DateTime.now();
    String currentDay = _getDayOfWeek(currentTime.weekday);
    String currentMeal = _getMeal(currentTime);

    DatabaseEvent event = await _menuRef.child(currentDay).child(currentMeal).once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null && snapshot.value is List) {
      List<dynamic> menuData = snapshot.value as List<dynamic>;

      // Filter out null values from the menuData
      List<String> filteredMenuData = menuData.where((item) => item != null).map((value) => value.toString()).toList();

      setState(() {
        _currentMenu = filteredMenuData;
        _isFetching = false;
      });
    } else {
        setState(() {
          _currentMenu = []; // Set an empty menu or show an error message
          _isFetching = false;
        });
      }
  }

  String _getDayOfWeek(int day) {
    // Convert weekday number to day name (1 for Monday, 7 for Sunday)
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _getMeal(DateTime currentTime) {
    int currentHour = currentTime.hour;
    int currentMinute = currentTime.minute;

    // Determine meal based on current time
    if ((currentHour >= 9 && currentMinute >= 30) &&
        (currentHour <= 14 && currentMinute <= 00)) {
      return 'lunch';
    } else if ((currentHour >= 14) && (currentHour <= 21)) {
      return 'dinner';
    } else {
      return 'breakfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu App'),
      ),
      body: _isFetching
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _currentMenu.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _currentMenu[index],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    ),
                );
              },
            ),
    );
  }
}
