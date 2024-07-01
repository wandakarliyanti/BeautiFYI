class UserModel {
  final int? id;
  final String fullname;
  final String email;
  final String password;

  UserModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullname: map['fullname'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'password': password,
    };
  }
}
