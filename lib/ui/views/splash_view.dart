import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/weight_icon.png',
            height: 200,
            width: 200,),
            const SizedBox(height: 16),
            const Text('Weight App',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
