import 'package:dart_di/src/di_container/namespace.dart';

abstract class DIContainer {
  /// Places dependencies by type [T] on the `stack` principle.
  /// 
  /// The [namespace] parameter allows you to separate dependencies from each other.
  /// 
  /// So, the dependencies defined in one [namespace] `are not visible` in the other.
  /// 
  /// `Important:` if you want to put the implementation as a base type, the parameter [T] `must be specified explicitly`.
  /// 
  /// *For example:*
  /// 
  /// ```dart
  /// abstract class Base {}
  /// class Impl implements Base {}
  /// 
  /// Dc.put<Base>(Impl());
  /// ```
  void put<T>(T dependence, { Namespace namespace = Namespace.main });

  /// It places dependencies by type [T] according to the `stack` principle, 
  /// however, the dependency is collected only at the moment of its first actual need, i.e. calling the [find] method for this `T`.
  /// 
  /// The [namespace] parameter allows you to separate dependencies from each other.
  /// 
  /// So, the dependencies defined in one [namespace] `are not visible` in the other.
  /// 
  /// `Important:` if you want to put the implementation as a base type, the parameter [T] `must be specified explicitly`.
  /// 
  /// *For example:*
  /// 
  /// ```dart
  /// abstract class Base {}
  /// class Impl implements Base {}
  /// 
  /// Dc.lazyPut<Base>(() => Impl());
  /// ```
  void lazyPut<T>(T Function() dependenceBuilder, { Namespace namespace = Namespace.main });

  /// Finds a dependency by type [T].
  /// 
  /// The [namespace] parameter allows you to separate dependencies from each other.
  /// 
  /// So, the dependencies defined in one [namespace] `are not visible` in the other.
  /// 
  /// *Example usage:*
  /// ```dart
  /// // Since this is a generic method, any of these options is possible.
  /// //
  /// // final is optional.
  /// final Base base = Dc.find<Base>();
  /// final base = Dc.find<Base>();
  /// final Base base = Dc.find();
  /// ```
  T find<T>({ Namespace namespace = Namespace.main });

  /// Pop the last value from the `stack` of dependencies of type [T].
  /// 
  /// The [namespace] parameter allows you to separate dependencies from each other.
  /// 
  /// So, the dependencies defined in one [namespace] `are not visible` in the other.
  T? pop<T>({ Namespace namespace = Namespace.main });

  /// Clears all dependencies of type [T].
  ///   
  /// The [namespace] parameter allows you to separate dependencies from each other.
  /// 
  /// So, the dependencies defined in one [namespace] `are not visible` in the other.
  void clear<T>({ Namespace namespace = Namespace.main });

  /// Clears all dependencies of container.
  void clearAll();
}