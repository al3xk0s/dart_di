import 'package:dart_di/src/exceptions/dependence_exception.dart';

abstract class DIStorage {
  void add<T>(dynamic dependence);
  T get<T>();
  T? pop<T>();

  void clear<T>();
  void clearAll();
}

class DIStorageImpl implements DIStorage {
  final _dependencies = <Type, List<dynamic>>{};

  @override
  void add<T>(dynamic dependence) {
    final depList = _dependencies[T] ?? [];
    depList.add(dependence);
    _dependencies[T] = depList;
  }

  @override
  T get<T>() {
    final depList = _dependencies[T];
    if(depList == null || depList.isEmpty) throw DependenceNotFoundException(T);

    if(depList.last is T Function()) {
      final T Function() depBuilder = depList.last;
      depList.removeLast();
      depList.add(depBuilder());
    }

    final dependence = depList.last;
    return dependence;
  }

  @override
  T? pop<T>() {
    final depList = _dependencies[T];
    if(depList == null || depList.isEmpty) return null;
    return depList.removeLast();
  }
  
  @override
  void clear<T>() {
    _dependencies.remove(T);
  }
  
  @override
  void clearAll() {
    _dependencies.clear();
  }  
}