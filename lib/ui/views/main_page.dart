import 'package:flutter/material.dart';
import 'package:weight_app/ui/bottom_navigation_bar.dart';
import 'package:weight_app/ui/views/history/history_view.dart';
import 'package:weight_app/ui/views/home/home_view.dart';
import 'package:weight_app/ui/views/settings_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List page = [const HomeView(), const HistoryView(), const SettingsView()];
  List appBarTitle = const ['Home', 'History','Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: page[_selectedIndex],
        bottomNavigationBar:
        const BottomNavBar()
        // BottomNavigationBar(
        //   currentIndex: _selectedIndex,
        //   onTap: onTap,
        //   items: const [
        //     BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        //     BottomNavigationBarItem(label: "History", icon: Icon(Icons.history)),
        //     BottomNavigationBarItem(
        //         label: 'Settings', icon: Icon(Icons.settings)),
        //   ],
        // ),
      );
  }

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  void dispose() {
    print('main_page | dispose');
    super.dispose();
  }
}

enum Page { home, history, settings }
