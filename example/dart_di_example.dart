import 'package:dart_di/dart_di.dart';

void main() {
  final Client client = Client();

  Dc.lazyPut<Abs>(() => AbsImpl());
  client.doSome();
  Dc.pop<Abs>();

  try {
    client.doSome();
  } catch (e) {
    print(e.toString());
  }

  Dc.put<Abs>(AbsImpl());

  client.doSome();

  // 42
  // Dependence Abs could not found
  // 42
}

abstract class Abs {
  int value = 42;
}

class AbsImpl extends Abs {}

class Client {
  void doSome() {
    final Abs abs = Dc.find();
    print(abs.value);
  }
}
