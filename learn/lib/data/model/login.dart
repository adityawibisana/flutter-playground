class Login {
  final String accessToken;
  final String uuid;
  final int id;

  const Login({
    required this.accessToken,
    required this.id,
    required this.uuid,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      accessToken: json['access_token'],
      id: json['id'],
      uuid: json['uuid'],
    );
  }
}
