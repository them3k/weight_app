import 'package:flutter/material.dart';

import '../../add_page.dart';

class AddWeightButtonContainer extends StatelessWidget {
  const AddWeightButtonContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => navigateToAddPage(context),
        child: Text('Add Weight'),
      ),
    );
  }

  void navigateToAddPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<AddPage>(builder: (_) => const AddPage()));
  }
}
