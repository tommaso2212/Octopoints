abstract class OctopointsProvider<T> {
  
  List<T>? _data;

  Future<List<T>> getData();

  Future<List<T>> get data => _data != null ? Future.value(_data) : getData();
}