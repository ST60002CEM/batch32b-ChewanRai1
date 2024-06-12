// Repository maa error lai handle garna lai ho

class Failure {
  final String error;
  final String? statusCode;

  Failure({
    required this.error,
    this.statusCode,
  });
}
