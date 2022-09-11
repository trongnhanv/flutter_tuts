class MyService {
  late int _myVariable;
  static final MyService _instance = MyService._internal();

  factory MyService() => _instance;

  MyService._internal() {
    _myVariable = 0;
  }

  int get myVariable => _myVariable;

  set myVariable(int value) => myVariable = value;

  void increaseMyVariable() => _myVariable++;
}
