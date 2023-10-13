class ServerConstants {
  static const String domain = 'marketplace-e37b2-default-rtdb.firebaseio.com';
  static String getAndCreatePath(DbPaths path) => '/${path.name}.json';
  static String updateAndDeletePath(DbPaths path, String id) =>
      '/${path.name}/$id.json';

  static String dbPath(DbPaths collection, String id) =>
      '${collection.name}/$id';
}

enum DbPaths { products, orders, userFavorites }
