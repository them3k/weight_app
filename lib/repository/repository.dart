abstract class Repository<T> {
  List<T> fetchFakeData();

  List<T> fetchData();

  void addWeight(T item);
}