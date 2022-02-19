class BaseNetworkError {
  final int code;
  final String message;

  const BaseNetworkError({
    required this.code,
    required this.message,
  });

  factory BaseNetworkError.fromJson(Map<String, dynamic> json) {
    return BaseNetworkError(
      code: json['code'],
      message: json['message'],
    );
  }
}
