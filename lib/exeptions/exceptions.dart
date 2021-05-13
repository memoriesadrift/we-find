class NotFoundException implements Exception {
  final String _msg;
  const NotFoundException(this._msg);

  String errMsg() => _msg;
}
