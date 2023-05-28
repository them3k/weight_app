import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import 'package:mocktail/mocktail.dart';

class MockServiceStorage extends Mock implements StorageService {}

main() {
  late WeightModel sut; // System under test

  final List<Weight> weightsFromService = [
    Weight(value: 25, dateEntry: DateTime(2023, 05, 03)),
    Weight(value: 26, dateEntry: DateTime(2024, 06, 04)),
    Weight(value: 27, dateEntry: DateTime(2022, 04, 02))
  ];

  final Weight testSingleWeight =
  Weight(value: 25, dateEntry: DateTime(2023, 05, 03));

  final Weight testSingleWeightUpdated =
  Weight(value: 30, dateEntry: DateTime(2023, 05, 03));


  void arrangeStorageServiceReturns3Weights() {
    when(() => sut.storageService.getWeightsByDate())
        .thenAnswer((_) async => weightsFromService);
  }

  void arrangeStorageAddWeightServiceReturns1() {
    when(() => sut.storageService.addWeight(testSingleWeight))
        .thenAnswer((_) async => 1);
  }

  setUpAll(() {
    serviceLocator.registerSingleton<StorageService>(MockServiceStorage());
    registerFallbackValue(Weight(value: 25, dateEntry: DateTime(2023,05,13)));
  });

  setUp(() {
    sut = WeightModel();
  });

  group('loadData', () {
    test("loadData called storageService.getWeightByDate is called once",
            () async {
          //Arrange
          when(() => sut.storageService.getWeightsByDate())
              .thenAnswer((_) async => []);
          await sut.loadData();
          //Act
          //Asset
          verify(() => sut.storageService.getWeightsByDate()).called(1);
        });

    test("loadData called list with 3 weights", () async {
      //Arrange
      arrangeStorageServiceReturns3Weights();
      //Act
      await sut.loadData();
      //Asset
      expect(sut.weights, weightsFromService);
    });
  });

  group('getItemAtIndex', () {
    test("index is -1 return null", () async {
      //Arrange
      int index = -1;
      //Act
      Weight? result = sut.getItemAtIndex(index);
      //Asset
      expect(result, null);
    });

    test("list has 3 items and index is 2 return 3rd testSingleWeight",
            () async {
          //Arrange
          arrangeStorageServiceReturns3Weights();
          //Act
          await sut.loadData();
          Weight? item = sut.getItemAtIndex(2);
          //Asset
          expect(item, weightsFromService[2]);
        });

  });

    group('addWeight', () {
      test("users add a weight, storageService.addWeight called once",
              () async {
            //Arrange

            when(() => sut.storageService.addWeight(testSingleWeight))
                .thenAnswer((_) async => 1);
            //Act
            sut.addWeight(testSingleWeight);
            //Asset
            verify(() => sut.storageService.addWeight(testSingleWeight)).called(
                1);
          });

      test("user adds a weight, list should be incremented by 1", () async {
        //Arrange
        arrangeStorageAddWeightServiceReturns1();
        //Act
        expect(sut.weights.length, 0);
        sut.addWeight(testSingleWeight);
        //Asset
        expect(sut.weights.length, 1);
      });

      test("user adds a weight, list should contains this element", () async {
        //Arrange
        arrangeStorageAddWeightServiceReturns1();
        //Act
        sut.addWeight(testSingleWeight);
        //Asset
        expect(sut.weights[0], testSingleWeight);
      });
    });

    group('updateWeight', () {
      Future arrangeWeightModelUpdateWeight() async {
        arrangeStorageAddWeightServiceReturns1();
        sut.addWeight(testSingleWeight);
      }

      test(
          "user update weights, storageService.updateWeights called once", () async {
        //Arrange
        await arrangeWeightModelUpdateWeight();
        //Act
        sut.updateWeight(testSingleWeightUpdated, 0);
        //Asset
        verify(() =>
            sut.storageService.updateWeight(testSingleWeightUpdated, 0)).called(
            1);
      });

      test("user update weights, length of list remains the same", () async {
        //Arrange
        arrangeWeightModelUpdateWeight();
        int lengthBeforeUpdateWeight = sut.weights.length;
        //Act
        sut.updateWeight(testSingleWeightUpdated, 0);
        int lengthAfterUpdateWeight = sut.weights.length;
        //Asset
        expect(lengthAfterUpdateWeight, lengthBeforeUpdateWeight);
      });

      test(
          "user update weights, testSingleWeight is replaced by testSingleWeightUpdated", () async {
        //Arrange
        arrangeWeightModelUpdateWeight();
        //Act
        sut.updateWeight(testSingleWeightUpdated, 0);
        //Asset
        expect(sut.weights[0], testSingleWeightUpdated);
      });
    });

    group('delete weights', () {
      List<int> oneIndex = [0];

      // user deletes weight, storageService.deleteWeight called once
      test(
          "user deletes weight, storageService.deleteWeight called once", () async {
        //Arrange
        sut.weights.addAll(weightsFromService);
        //Act
        sut.deleteWeights(oneIndex);
        //Asset
        verify(() => sut.storageService.deleteWeight(oneIndex)).called(1);
      });

      test("user deleted one weight, list is decrement by 1", () async {
        //Arrange
        sut.weights.addAll(weightsFromService);
        //Act
        sut.deleteWeights(oneIndex);
        //Asset
        expect(sut.weights.length, 2);
      });

      test("user deleted 2 weights, list is decrement by 2", () async {
        //Arrange
        List<int> indexes = [2,1];
        sut.weights.addAll(weightsFromService);
        //Act
        sut.deleteWeights(indexes);
        //Asset
        expect(sut.weights.length, 1);
      });

      test("user deleted 2 weights, weights from last and second to last is deleted", () async {
      //Arrange
      sut.weights.addAll(weightsFromService);
      var weightFromIndex2 = sut.weights[2];
      var weightFromIndex1 = sut.weights[1];
      //Act
      sut.deleteWeights([2,1]);
      //Asset
        expect(sut.weights.contains(weightFromIndex1), false);
        expect(sut.weights.contains(weightFromIndex2), false);
    });
  });


  // void saveWeight(double value, DateTime dateTime, int? index) {
  //
  //   DateTime dateEntry = simplifyDateTimeFormat(dateTime);
  //   if (index == null) {
  //     addWeight(Weight(value: value, dateEntry: dateEntry));
  //   } else {
  //     updateWeight(Weight(value: value, dateEntry: dateEntry), index);
  //   }
  // }

    group('saveWeights', () {

      test("index is null, storageService.addWeight called once", () async {
      //Arrange
      arrangeStorageAddWeightServiceReturns1();
      Weight weight = Weight(value: 25, dateEntry: DateTime(2023,05,03));
      //Act
      sut.saveWeight(weight.value,weight.dateEntry, null);
      //Asset
        verify(() => sut.storageService.addWeight(weight)).called(1);
    });

      test("index is not null, storageService.updateWeight called once", () async {
      //Arrange
      sut.weights.add(testSingleWeight);
      //Act
      sut.saveWeight(
          testSingleWeightUpdated.value, testSingleWeightUpdated.dateEntry, 0);
      //Asset
      verify(() => sut.storageService.updateWeight(testSingleWeightUpdated, 0))
          .called(1);
    });
  });

  group('saveInitWeight', () {

    DateTime now = DateTime.now();
    double value = 25;
    Weight testWeightNow = Weight(value: value, dateEntry: DateTime(now.year,now.month,now.day));

    test("user saves init value, addWeight called", () async {
      //Arrange

      when(() => sut.storageService.addWeight(
              testWeightNow))
          .thenAnswer((_) async => 1);
      //Act
      sut.saveInitWeight(25);
      //Asset
      verify(() => sut.addWeight(testWeightNow)).called(1);
    });
  });

  test("simplifyDateTimeFormat called, formattedDateTimeNow", () async {
    //Arrange
    DateTime now = DateTime.now();
    DateTime formattedDateTimeNow = DateTime(now.year,now.month,now.day);
    //Act
    var result = sut.simplifyDateTimeFormat(now);
    //Asset
    expect(result, formattedDateTimeNow);
  });

  test("user gets weights, ordered weights list", () async {
    //Arrange
    List<Weight> list = [
      Weight(value: 25, dateEntry: DateTime(2023,05,06)),
      Weight(value: 26, dateEntry: DateTime(2023,05,04)),
      Weight(value: 27, dateEntry: DateTime(2022,05,06)),
    ];

    List<Weight> sortedList = [
      Weight(value: 27, dateEntry: DateTime(2022,05,06)),
      Weight(value: 26, dateEntry: DateTime(2023,05,04)),
      Weight(value: 25, dateEntry: DateTime(2023,05,06)),
    ];
    //Act
    var result = WeightModel.sortByDate(list);
    //Asset
    expect(result, sortedList);
  });
}
