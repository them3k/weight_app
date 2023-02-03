import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static final double BALLONS_IMAGE_WIDTH = 100;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weightValue = 79.9;

  final List<String> _choices = const ['Daily', 'Weekly', 'Monthly', 'Yearly'];
  int _choiceIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBarMaxHeight = Scaffold.of(context).appBarMaxHeight ?? 56;
    return Container(
      height: mediaQuery.size.height -
          kBottomNavigationBarHeight -
          mediaQuery.padding.top -
          appBarMaxHeight,
      child: Column(
        children: [
          _buildCongratWidget(context),
          _buildCurrentWeightWidget(context),
          _buildChipsRow(context)
        ],
      ),
    );
  }

  Widget _buildCongratWidget(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ]),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: HomePage.BALLONS_IMAGE_WIDTH,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Congrats!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'You gain 3.4 kg in last week',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'lib/assets/images/ballons.png',
            width: HomePage.BALLONS_IMAGE_WIDTH,
            height: 120,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentWeightWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 16),
      child: Container(
        alignment: Alignment.bottomLeft,
        height: 100,
        child: Column(
          children: [
            const Text(
              'Current Weight',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              _weightValue.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChipsRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _choices.length,
          itemBuilder: (context, index) => _buildChoiceChip(index, context)),
    );
  }

  Widget _buildChoiceChip(int index, BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: ChoiceChip(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: BorderSide.none,
          label: Text(_choices[index]),
          selected: _choiceIndex == index,
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundColor: Colors.grey.withOpacity(0.4),
          onSelected: (isSelected) {
            setState(() {
              _choiceIndex = isSelected ? index : 0;
            });
          },
        ));
  }
}
