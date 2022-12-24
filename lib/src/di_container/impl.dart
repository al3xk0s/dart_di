import 'package:dart_di/src/di_container/di_container.dart';
import 'package:dart_di/src/di_container/storage/di_storage.dart';
import 'package:dart_di/src/di_container/storage/di_storage_factory.dart';
import 'package:dart_di/src/di_container/namespace.dart';
import 'package:dart_di/src/exceptions/dependence_exception.dart';

class DIContainerImpl implements DIContainer {
  DIContainerImpl(DIStorageFactory factory) {
    _factory = factory;
  }

  late final DIStorageFactory _factory;

  final _namespaceStorageMap = <Namespace, DIStorage>{};

  @override
  void put<T>(T dependence, {Namespace namespace = Namespace.main}) {
    _put<T>(dependence, namespace);
  }

  @override
  void lazyPut<T>(T Function() dependenceBuilder, {Namespace namespace = Namespace.main}) {
    _put<T>(dependenceBuilder, namespace);
  }

  void _put<T>(dynamic dependence, Namespace namespace) {
    final storage = _namespaceStorageMap[namespace] ?? _factory.create();
    storage.add<T>(dependence);
    _namespaceStorageMap[namespace] = storage;
  }

  @override
  T find<T>({Namespace namespace = Namespace.main}) {
    final storage = _getExistStorage<T>(namespace);
    return storage.get<T>();
  }

  @override
  T? pop<T>({Namespace namespace = Namespace.main}) {
    final storage = _namespaceStorageMap[namespace];
    if(storage == null) return null;
    return storage.pop<T>();
  }

  @override
  void clear<T>({Namespace namespace = Namespace.main}) {
    final storage = _namespaceStorageMap[namespace];
    if(storage == null) return;
    storage.clear<T>();
  }

  @override
  void clearAll() {
    for (var storage in _namespaceStorageMap.values) {
      storage.clearAll();
    }
    
    _namespaceStorageMap.clear();
  }

  DIStorage _getExistStorage<T>(Namespace namespace) {
    final storage = _namespaceStorageMap[namespace];
    if(storage == null) throw DependenceNotFoundException(T);
    return storage;
  }
}