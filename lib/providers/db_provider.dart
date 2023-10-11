import 'package:clothing/constants/server.dart';
import 'package:clothing/helpers/id_gen_adapter.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class DbProvider {
  final FirebaseDatabase _instance = FirebaseDatabase.instance;
  final IIdGen _idGenerator = UUIDAdapter();
  final DbPaths _dbPath;

  IIdGen get idGenerator => _idGenerator;

  DatabaseReference getReferenceFrom(String id) {
    return _instance.ref('${_dbPath.name}/$id');
  }

  DatabaseReference get readRef => _instance.ref().child(_dbPath.name);

  DbProvider({required DbPaths dbPath}) : _dbPath = dbPath;
}
