import 'package:flutter/material.dart';
import 'package:flutter_practical/view/screens/add_category.dart';
import 'package:flutter_practical/view/screens/detail_screen.dart';
import 'package:flutter_practical/view/screens/home_scrren.dart';
import 'package:flutter_practical/view/screens/idea_screen.dart';
import 'package:flutter_practical/view/screens/learedboard_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selecedIndex = 0;
  final _screens = [
    HomeScreen(),
    IdeaScreen(),
    AddCategory(),
    LeaderBoardScreen(),
    DetailScreen()
  ];
  void _seletedPage(int index) {
    setState(() {
      _selecedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selecedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _seletedPage,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selecedIndex,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        // onTap: bn.selectedIndexChange,
        items: const [
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
              label: '',
              activeIcon: FaIcon(FontAwesomeIcons.lightbulb),
              icon: FaIcon(FontAwesomeIcons.solidLightbulb)),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.add_circle),
            icon: Icon(Icons.add_circle_outline),
          ),
          BottomNavigationBarItem(
              label: '',
              activeIcon: FaIcon(FontAwesomeIcons.poll),
              icon: FaIcon(FontAwesomeIcons.poll)),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.collections_bookmark),
            icon: Icon(Icons.collections),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
