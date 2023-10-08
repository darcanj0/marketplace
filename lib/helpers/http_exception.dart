class AppHttpException implements Exception {
  AppHttpException({required this.statusCode, required this.msg});
  final int statusCode;
  final String msg;

  @override
  String toString() {
    return msg;
  }
}
