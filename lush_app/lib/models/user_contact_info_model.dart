class UserContactInfoModel {
  final String? email;
  final String? password;
  final String? phoneNumber;

  static const emailLabel = 'email';
  static const passwordLabel = 'password';
  static const phoneNumberLabel = 'phone_number';

  UserContactInfoModel({
    this.email,
    this.password,
    this.phoneNumber,
  });

  factory UserContactInfoModel.fromEmailAndPassword(
      String email, String password) {
    return UserContactInfoModel(
      email: email,
      password: password,
    );
  }

  factory UserContactInfoModel.fromMap(Map<String, dynamic> map) {
    return UserContactInfoModel(
      email: map[emailLabel] as String?,
      password: map[passwordLabel] as String?,
      phoneNumber: map[phoneNumberLabel] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      emailLabel: email,
      passwordLabel: password,
      phoneNumberLabel: phoneNumber,
    };
  }

  UserContactInfoModel copyWith({
    String? email,
    String? password,
    String? phoneNumber,
  }) {
    return UserContactInfoModel(
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
