import 'package:fkappa/fkappa.dart';

/// Low-level data source (could be SharedPreferences or API).
class CounterLocalDataSource extends BaseDataSource {
  int _counter = 0;

  Future<int> getCounter() async => _counter;

  Future<int> increment(int currentValue) async {
    _counter = currentValue + 1;
    return _counter;
  }
}
