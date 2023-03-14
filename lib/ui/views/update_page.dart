// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weight_app/business_logic/utils/utils.date_format.dart';
// import 'package:weight_app/business_logic/utils/wave_clipper.dart';
// import '../../business_logic/view_model/weight_viewmodel.dart';
// import '../../model/weight_model.dart';
// import '../widget/half_circle_chart.dart';
//
// class UpdatePage extends StatefulWidget {
//   final Weight item;
//   final int index;
//
//   const UpdatePage({required this.item, required this.index, super.key});
//
//   @override
//   State<UpdatePage> createState() => _UpdatePageState();
// }
//
// class _UpdatePageState extends State<UpdatePage> {
//   DateTime _date = DateTime.now();
//   final TextEditingController _weightController = TextEditingController();
//   late double _weightValue;
//   late double _goal = 75.0;
//   late double _minimum = 0;
//   late double _progressValue = 0;
//   late WeightViewModel _viewModel;
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   void loadData() async {
//     _viewModel = Provider.of<WeightViewModel>(context, listen: false);
//     var goal = await _viewModel.goal;
//     var minimum = await _viewModel.getMinWeightValue();
//     _weightValue = widget.item.value;
//     _weightController.text = _weightValue.toString();
//     _date = widget.item.dateEntry;
//     setState(() {
//       _minimum = minimum;
//       _goal = goal;
//       _progressValue = (_minimum / _goal) * 100;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildWaveBg(context);
//   }
//
//   Widget _buildWaveBg(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final AppBar appBar = AppBar(
//       title: const Text('Add'),
//     );
//     return Scaffold(
//       appBar: appBar,
//       body: Column(
//         children: [
//           const Spacer(),
//           HalfCircleChart(
//             minimum: _minimum,
//             goal: _goal,
//             progressValue: _progressValue,
//           ),
//           Stack(children: [
//             Container(
//               padding: const EdgeInsets.only(top: 60),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 0),
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//               height: mediaQuery.size.height -
//                   appBar.preferredSize.height -
//                   mediaQuery.size.height * 0.3 -
//                   mediaQuery.viewPadding.top,
//               child: Column(
//                 children: [
//                   InkWell(
//                     onTap: () => {_buildWeightValueChangeDialog(context)},
//                     child: Text(
//                       '${_weightController.text} kg',
//                       style: TextStyle(
//                           fontSize: 34,
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).colorScheme.onPrimary),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   Row(
//                     children: [
//                       const SizedBox(width: 12),
//                       Text(
//                         DateFormat.ddMMMyyyy(_date),
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Theme.of(context).colorScheme.onPrimary),
//                       ),
//                       const Spacer(),
//                       ElevatedButton(
//                           onPressed: _pickDate, child: Text('pick date')),
//                       const SizedBox(width: 12),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             ClipPath(
//               clipper: WaveClipper(),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.surface,
//                     border: Border.all(color: Colors.white, width: 0)),
//                 height: mediaQuery.size.height -
//                     appBar.preferredSize.height -
//                     mediaQuery.size.height * 0.3 -
//                     mediaQuery.viewPadding.top,
//               ),
//             ),
//             Positioned(
//                 bottom: 20,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                     height: 40,
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     child: ElevatedButton(
//                         onPressed: _saveItem, child: const Text('Save'))))
//           ]),
//         ],
//       ),
//     );
//   }
//
//   void _pickDate() async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(1900),
//         lastDate: DateTime(2100));
//     if (pickedDate != null) {
//       setState(() {
//         _date = pickedDate;
//       });
//     }
//   }
//
//   Future _buildWeightValueChangeDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (innerContext) => AlertDialog(
//           title: const Text('Add Weight'),
//           content: SizedBox(
//             height: 100,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Insert your current weight: '),
//                 TextField(
//                   controller: _weightController,
//                   style: const TextStyle(fontSize: 24),
//                   keyboardType: TextInputType.number,
//                 )
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () => {
//                   _weightValue = double.parse(_weightController.text),
//                   Navigator.of(innerContext).pop(true)
//                 },
//                 child: Text('Save')),
//             TextButton(
//                 onPressed: () => {Navigator.of(innerContext).pop(false)},
//                 child: Text('Cancel')),
//           ],
//         ));
//   }
//
//   void _saveItem() {
//     print('UpdatePage | _saveItem');
//     print('UpdatePage | _saveItem | ${_date} | ${_weightController.text} ');
//     DateTime dateTime = DateTime(_date.year, _date.month, _date.day);
//     Weight weight = Weight(value: _weightValue, dateEntry: dateTime);
//     print('UpdatePage | SaveItem | weight: $weight');
//     _viewModel.updateWeight(weight,widget.index);
//     Navigator.of(context).pop();
//   }
// }
