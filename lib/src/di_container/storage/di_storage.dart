import 'package:dart_di/src/di_container/storage/dependence.dart';
import 'package:dart_di/src/exceptions/dependence_exception.dart';

abstract class DIStorage {
  void add<T>(Dependence<T> dependence);
  Dependence<T> get<T>();
  Dependence<T>? pop<T>();

  void clear<T>();
  void clearAll();
}

class DIStorageImpl implements DIStorage {
  final _dependencies = <Type, List<Dependence>>{};

  @override
  void add<T>(Dependence<T> dependence) {
    final depList = _dependencies[T] ?? [];
    depList.add(dependence);
    _dependencies[T] = depList;
  }

  @override
  Dependence<T> get<T>() {
    final depList = _dependencies[T];
    if(depList == null || depList.isEmpty) throw DependenceNotFoundException(T);

    return depList.last as Dependence<T>;
  }

  @override
  Dependence<T>? pop<T>() {
    final depList = _dependencies[T];
    if(depList == null || depList.isEmpty) return null;
    return depList.removeLast() as Dependence<T>;
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