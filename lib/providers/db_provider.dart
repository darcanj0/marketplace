import 'package:clothing/constants/server.dart';
import 'package:clothing/helpers/id_gen_adapter.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class DbProvider {
  final FirebaseDatabase instance = FirebaseDatabase.instance;
  final IIdGen idGenerator = UUIDAdapter();
  final DbPaths dbPath;

  DatabaseReference getReferenceFrom(String id) {
    return instance.ref('${dbPath.name}/$id');
  }

  DatabaseReference get readRef => instance.ref().child(dbPath.name);

  DbProvider({required this.dbPath});
}
