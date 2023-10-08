class ServerConstants {
  static const String domain = 'marketplace-e37b2-default-rtdb.firebaseio.com';
  static const String getAndCreatePath = '/products.json';
  static String updateAndDeletePath(String id) => '/products/$id';
}
