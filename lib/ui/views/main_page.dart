import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Page _page = Page.home;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _switchPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
              icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "History",
              icon: Icon(Icons.history)),
          BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings)),
        ],
      ),
    );
  }

  Widget _switchPage(int index) {
    switch (index) {
      case 0:
        return _buildCenterWidget('Home');
      case 1:
        return _buildCenterWidget('History');
      case 2:
        return _buildCenterWidget('Settings');
      default: throw 'Unknow index in BottomNavigationBar';
    }
  }

  Widget _buildCenterWidget(String text) {
    return Center(
      child: Text(text),
    );
  }
}

enum Page { home, history, settings }
