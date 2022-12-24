abstract class Namespace {
  static const Namespace main = NamespaceIDImpl(0);
  
  bool equals(Namespace other);
  int getHashcode();

  @override
  bool operator ==(covariant Namespace other) {
    return super == other || equals(other);
  }

  @override
  int get hashCode => getHashcode();
}

class NamespaceIDImpl implements Namespace {
  const NamespaceIDImpl(this.id);
  final int id;

  @override
  bool equals(covariant NamespaceIDImpl other) {
    return id == other.id;
  }

  @override
  int getHashcode() {
    return id.hashCode;
  }
}
