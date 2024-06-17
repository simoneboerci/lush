class LushUser {
  final String userId;
  String username;

  String name;
  String email;
  String password;

  LushUser({
    required this.userId,
    required this.username,
    this.name = '',
    this.email = '',
    this.password = '',
  });

  factory LushUser.fromMap(Map<String, dynamic> map) {
    return LushUser(
      userId: map['userId'],
      username: map['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
    };
  }
}
