import 'package:uuid/uuid.dart';

abstract class IIdGen {
  String newId();
}

class UUIDAdapter implements IIdGen {
  @override
  String newId() {
    return const Uuid().v4();
  }
}
