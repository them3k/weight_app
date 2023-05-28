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

  final weightsFromService = [
    Weight(value: 25, dateEntry: DateTime(2023, 05, 03)),
    Weight(value: 25, dateEntry: DateTime(2023, 05, 03)),
    Weight(value: 25, dateEntry: DateTime(2023, 05, 03))
  ];

  final Weight testSingleWeight =
      Weight(value: 25, dateEntry: DateTime(2023, 05, 03));

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

    group('addWeight', () {
      test("users add a weight, storageService.addWeight called once",
          () async {
        //Arrange

        when(() => sut.storageService.addWeight(testSingleWeight))
            .thenAnswer((_) async => 1);
        //Act
        sut.addWeight(testSingleWeight);
        //Asset
        verify(() => sut.storageService.addWeight(testSingleWeight)).called(1);
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

      test("user adds a weight, list should contains this element ", () async {
        //Arrange
        arrangeStorageAddWeightServiceReturns1();
        //Act
        sut.addWeight(testSingleWeight);
        //Asset
        expect(sut.weights[0], testSingleWeight);
      });
    });

    group('deleteWeight', () {});
  });
}
