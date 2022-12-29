import 'package:flutter/material.dart';
import 'package:weight_app/repository/weight_repository.dart';
import 'package:weight_app/widget/weight_item.dart';

import '../repository/repository.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  Repository repo = WeightRepository();

  @override
  Widget build(BuildContext context) {
    final items = repo.fetchFakeData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page')
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int position){
        return WeightItem(item: items[position]);
      })
    );
  }
}
