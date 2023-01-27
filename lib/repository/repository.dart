abstract class Repository<T> {
  Future<List<T>> fetchFakeData();

  Future<List<T>> fetchData();

  Future<void> addWeight(T item);
}