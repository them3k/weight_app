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

  final Weight testSingleWeight = Weight(
      value: 25, dateEntry: DateTime(2023, 05, 03));


  void arrangeStorageServiceReturns3Weights() {
    when(() => sut.storageService.getWeightsByDate())
        .thenAnswer((_) async => weightsFromService);
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
}