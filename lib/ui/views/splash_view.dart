import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business_logic/utils/pages.dart';
import '../../business_logic/view_model/app_state_manager.dart';
import '../../business_logic/view_model/weight_model.dart';

class SplashView extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage<SplashView>(
        key: ValueKey(Pages.splashPath),
        name: Pages.splashPath,
        child: const SplashView());
  }

  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  @override
  void initState() {
    super.initState();
  }

  Future slowDownLoading() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  void loadData() async {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
       await slowDownLoading();
       Provider.of<AppStateManagement>(listen:false,context).loadValues();
     //});
  }

  void throwError() {
    print('Error due to initialization');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/weight_icon.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 16),
            const Text(
              'Weight App',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
