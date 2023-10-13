import 'package:clothing/constants/server.dart';
import 'package:clothing/helpers/id_gen_adapter.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class DbProvider {
  final FirebaseDatabase instance = FirebaseDatabase.instance;
  final IIdGen _idGenerator = UUIDAdapter();
  final DbPaths _dbPath;

  IIdGen get idGenerator => _idGenerator;

  DatabaseReference getReferenceFrom(String id) {
    return instance.ref('${_dbPath.name}/$id');
  }

  DatabaseReference get readRef => instance.ref().child(_dbPath.name);

  DbProvider({required DbPaths dbPath}) : _dbPath = dbPath;
}
