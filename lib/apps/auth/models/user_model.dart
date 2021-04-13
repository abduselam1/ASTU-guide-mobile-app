class UserModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String avatar;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      avatar: json['avatar'],
    );
  }
}
