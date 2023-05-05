import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/app_state_manager.dart';
import 'package:weight_app/service_locator.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

// Add appStateManagement ( there is information about current screen )

class _BottomNavBarState extends State<BottomNavBar> {

  late AppStateManagement _appStateManagement;

  @override
  void initState() {
    super.initState();
    _appStateManagement = Provider.of<AppStateManagement>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "History", icon: Icon(Icons.history)),
        BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
      ],
      onTap: _onTap,
    );
  }

  void _onTap(int index) {
      switch(index) {
        case 0: _appStateManagement.onHomeTapped(true); break;
        case 1: _appStateManagement.onHistoryTapped(true); break;
        case 2: _appStateManagement.onSettingTapped(true); break;
      }
  }
}
