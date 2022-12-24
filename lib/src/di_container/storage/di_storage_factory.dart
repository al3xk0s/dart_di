import 'package:dart_di/src/di_container/storage/di_storage.dart';

abstract class DIStorageFactory {
  DIStorage create();
}

class DIStorageFactoryImpl implements DIStorageFactory {
  @override
  DIStorage create() {
    return DIStorageImpl();
  }
}