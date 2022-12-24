abstract class Dependence<T> {
  T get value;
}

class ValueDependence<T> implements Dependence<T> {
  const ValueDependence(this.value);

  @override
  final T value;
}

class LazyDependence<T> implements Dependence<T> {
  LazyDependence(this.builder);

  @override
  T get value {
    _value ??= builder();
    return _value!;
  }

  T? _value;

  final T Function() builder;
}