import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/ui/views/history_page.dart';
import 'package:weight_app/ui/views/home/home_view.dart';
import 'package:weight_app/ui/views/settings_page.dart';

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

  List page = [const HomeView(), const HistoryPage(), const SettingsPage()];
  List appBarTitle = const ['Home', 'History','Settings'];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeightViewModel>(
      create: (context) => WeightViewModel(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: page[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "History", icon: Icon(Icons.history)),
            BottomNavigationBarItem(
                label: 'Settings', icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(actions: [
      Consumer<WeightViewModel>(
        builder: (context, viewModel, child) {
        return viewModel.isItemsSelected
          ? GestureDetector(
                child: const Icon(Icons.delete),
                onTap: () {
                  viewModel.onTapDeleteSelectedItems();
                },
              )
            : const SizedBox();
      }),
    ], title: Text(appBarTitle[_selectedIndex]));
  }
}

enum Page { home, history, settings }
