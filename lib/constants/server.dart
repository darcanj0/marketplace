class ServerConstants {
  static const String domain = 'marketplace-e37b2-default-rtdb.firebaseio.com';
  static String getAndCreatePath(ApiPaths path) => '/${path.name}.json';
  static String updateAndDeletePath(ApiPaths path, String id) =>
      '/${path.name}/$id.json';
}

enum ApiPaths { products, orders }
