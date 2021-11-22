import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/app_colors.dart';
import 'package:flutter_todo_app/views/calander_page.dart';
import 'package:flutter_todo_app/views/target_form.dart';

import 'home_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.blueColor,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.calendar,
            ),
            label: 'Calendar',
          ),
        ],
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blueColor,
        child: const Icon(
          CupertinoIcons.add,
          color: AppColors.whiteColor,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (cxt) {
              return TargetForm(
                onSave: () {
                  setState(() {});
                },
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _pages[_currentIndex],
    );
  }
}
