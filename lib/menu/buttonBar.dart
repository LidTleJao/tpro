import 'package:flutter/material.dart';
import 'package:tpro/menu/home_page.dart';
import 'package:tpro/menu/addimage_page.dart';
import 'package:tpro/menu/account_page.dart';

class ButtonBarPage extends StatefulWidget {
  const ButtonBarPage({Key? key}) : super(key: key);

  @override
  State<ButtonBarPage> createState() => _ButtonBarPageState();
}

class _ButtonBarPageState extends State<ButtonBarPage> {
  int _currentIndex = 0;
  final tabs = [Homepage(), AddImagePage()
  , AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        iconSize: 35,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
              backgroundColor: Color.fromARGB(255, 31, 31, 31)),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Add Image",
              backgroundColor: Color.fromARGB(255, 31, 31, 31)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "User",
              backgroundColor: Color.fromARGB(255, 31, 31, 31)),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
