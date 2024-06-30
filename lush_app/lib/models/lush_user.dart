class LushUser {
  final String userId;

  String? name;
  String? surname;
  DateTime? birthDate;
  String? birthLocation;

  String? username;
  String? email;
  String? password;

  LushUser({
    required this.userId,
    this.username,
    this.name,
    this.surname,
    this.birthDate,
    this.birthLocation,
    this.email,
    this.password,
  });

  factory LushUser.copyWith(
      {required LushUser user,
      String? name,
      String? surname,
      DateTime? birthDate,
      String? birthLocation,
      String? username,
      String? email,
      String? password}) {
    return LushUser(
      userId: user.userId,
      name: name ?? user.name,
      surname: surname ?? user.surname,
      birthDate: birthDate ?? user.birthDate,
      birthLocation: birthLocation ?? user.birthLocation,
      username: username ?? user.username,
      email: email ?? user.email,
      password: password ?? user.password,
    );
  }

  factory LushUser.fromMap(Map<String, dynamic> map) {
    return LushUser(
      userId: map['userId'],
      username: map['username'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      password: map['password'],
      birthDate: map['birth_date'],
      birthLocation: map['birth_location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'name': name,
      'surname': surname,
      'birth_date': birthDate,
      'birth_location': birthLocation,
      'email': email,
      'password': password,
    };
  }
}
