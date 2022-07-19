class InvalidKeyException implements Exception {
  final String key;
  const InvalidKeyException(this.key);

  @override
  String toString() => 'Key "$key" contains at least one period (.), that does not work currently.';
}
