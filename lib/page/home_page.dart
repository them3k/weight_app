import 'package:flutter/material.dart';
import 'package:weight_app/page/add_weight_page.dart';
import 'package:weight_app/repository/weight_repository.dart';
import 'package:weight_app/widget/weight_item.dart';

import '../repository/repository.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    final items = repository.fetchFakeData();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push<MaterialPageRoute>(MaterialPageRoute(
                builder: (context) => AddWeightPage(
                      repository: repository,
                    )));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(title: const Text('Home Page')),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int position) {
              return WeightItem(item: items[position]);
            }));
  }
}
