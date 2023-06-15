import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/services/chart_service/chart_service.dart';
import 'package:weight_app/services/chart_service/chart_service_impl.dart';

main() {
  late ChartService sut;

  setUp(() {
    sut = ChartServiceImpl();
  });

  DateTime now = DateTime.now();


  group('countRightTitleInterval', () {

    String doubleToStringAsPrecision2(double value ) =>
        value.toStringAsPrecision(2);

    test("diff < 4, return 1", () async {
      //Arrange
      List<Weight> list = [
        Weight(value: 72.1, dateEntry: DateTime(2023, 01, 01)),
        Weight(value: 76, dateEntry: DateTime(2023, 01, 02))
      ];
      sut.fetchDataChart(list, now);
      //Act
      double result = sut.countRightTitleInterval();
      var diff = sut.countDiff();
      //Asset
      expect(doubleToStringAsPrecision2(diff),'3.9');
      expect(result, 1);
    });

    test(" 4 <= diff < 7 , return 2", () async {
      //Arrange
      List<Weight> list = [
        Weight(value: 74, dateEntry: DateTime(2023, 01, 01)),
        Weight(value: 78.1, dateEntry: DateTime(2023, 01, 02))
      ];
      sut.fetchDataChart(list, now);
      //Act
      double result = sut.countRightTitleInterval();
      var diff = sut.countDiff();
      //Asset
      expect(doubleToStringAsPrecision2(diff),'4.1');
      expect(result, 2);
    });


  test("7 <= diff < 10, return 3", () async {
    //Arrange
    List<Weight> list = [
      Weight(value: 70, dateEntry: DateTime(2023, 01, 01)),
      Weight(value: 79.9, dateEntry: DateTime(2023, 01, 02))
    ];
    sut.fetchDataChart(list, now);
    //Act
    double result = sut.countRightTitleInterval();
    var diff = sut.countDiff();
    //Asset
    expect(doubleToStringAsPrecision2(diff),'9.9');
    expect(result, 3);
  });

    test("diff >= 105, return 50", () async {
      //Arrange
      List<Weight> list = [
        Weight(value: 50, dateEntry: DateTime(2023, 01, 01)),
        Weight(value: 200, dateEntry: DateTime(2023, 01, 02))
      ];
      sut.fetchDataChart(list, now);
      //Act
      double result = sut.countRightTitleInterval();
      var diff = sut.countDiff();
      //Asset
      expect(doubleToStringAsPrecision2(diff),'1.5e+2'); //150
      expect(result, 50);
    });
});

  group('countMinY', () {
    Weight testMinWeight =
        Weight(value: 74.1, dateEntry: DateTime(2023, 01, 01));
    Weight testMaxWeight = Weight(value: 75, dateEntry: DateTime(2023, 01, 01));

    test("diff is between 0 & 1, minY is 74", () async {
      //Arrange
      List<Weight> list = [
        Weight(value: 74.1, dateEntry: DateTime(2023, 01, 01)),
        Weight(value: 75, dateEntry: DateTime(2023, 01, 01))
      ];
      sut.fetchDataChart(
          list, DateTime(2023, 01, 01));
      //Act
      double minY = sut.countMinY();
      //Asset
      expect(minY, 74);
    });



    test("min subtract interval, 0", () async {
      //Arrange
      List<Weight> list = [
        Weight(value: 0, dateEntry: DateTime(2023, 01, 01)),
        Weight(value: 70, dateEntry: DateTime(2023, 01, 02))
      ];
      sut.fetchDataChart(list, now);
      //Act
      double diff = sut.countDiff();
      double interval = sut.countRightTitleInterval();
      double result = sut.countMinX();
      //Asset
      expect(diff.toStringAsPrecision(2), '70');
      expect(interval, 20);
      expect(result, 0);

    });

    test("min & interval is not divisible, minY is 73", () async {
      //Arrange
      List<Weight> list = [
        Weight(value: 74.1, dateEntry: DateTime(2023, 01, 01)),
        Weight(value: 76, dateEntry: DateTime(2023, 01, 02))
      ];
      sut.fetchDataChart(list, now);
      //Act
      double diff = sut.countDiff();
      double interval = sut.countRightTitleInterval();
      bool isDivisible = sut.isDivisible(sut.getMinWeightValue(), interval);
      //Asset
      expect(diff.toStringAsPrecision(2), '1.9');
      expect(interval, 1);
      expect(isDivisible, false);
      expect(sut.countMinY(),73.0);
    });

    test("min & interval is divisible, minY is 67", () async {
      //Arrange
      // 70 80 // r 5 // diff 10
      List<Weight> list = [
        Weight(value: 72, dateEntry: DateTime(2023, 01, 01)),
        Weight(value: 80, dateEntry: DateTime(2023, 01, 02))
      ];
      sut.fetchDataChart(list, now);
      //Act
      double diff = sut.countDiff();
      double interval = sut.countRightTitleInterval();
      bool isDivisible = sut.isDivisible(sut.getMinWeightValue(), interval);
      //Asset
      expect(diff.toStringAsPrecision(2), '8.0');
      expect(interval, 3);
      expect(isDivisible, true);
      expect(sut.countMinY(),69.0);
    });
  });

}
