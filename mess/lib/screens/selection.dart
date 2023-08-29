import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mess/screens/menu.dart';

class Selection extends StatefulWidget {
  const Selection({super.key});

  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  String _selectedMess = 'Sannasi';

  void _updateMess(String selectedMess) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedMess', selectedMess);
  }

  void _navigate(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MenuScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, 
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 24, 31, 52),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ap1.gif',
                height: 80,
              ),
              const SizedBox(height: 20,),
              Text(
                'Select Your Mess',
                style: GoogleFonts.bangers(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedMess,
                icon: const Icon(Icons.arrow_downward),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedMess = newValue!;
                  });
                },
                items: <String>[
                  'Sannasi',
                  'Agasthiyar',
                  'D Mess',
                  'PF',
                  'M block',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: value == _selectedMess ? Colors.white : Colors.black,
                      )
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromARGB(255, 24, 31, 52),
                ),
                onPressed: () {
                  _updateMess(_selectedMess); // Update selected mess in local storage
                  _navigate(context);
                },
                child: Text(
                  'Submit',
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
