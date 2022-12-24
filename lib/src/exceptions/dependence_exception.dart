abstract class DependenceException implements Exception {}

class DependenceNotFoundException extends DependenceException {
  final Type type;

  DependenceNotFoundException(this.type);

  @override
  String toString() {
    return 'Dependence $type could not found';
  }
}