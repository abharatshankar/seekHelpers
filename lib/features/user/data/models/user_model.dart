import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({int? id, required String name, required String email, required String phone})
      : super(id: id, name: name, email: email, phone: phone);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
