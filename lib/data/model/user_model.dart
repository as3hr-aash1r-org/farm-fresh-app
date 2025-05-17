class UserModel {
  final int? id;
  final String? email;
  final String? userName;
  final String? address;
  final bool isAdmin;

  UserModel({
    this.email,
    this.userName,
    this.address,
    this.id,
    this.isAdmin = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      email: json["email"],
      userName: json["username"],
      address: json['address'],
      isAdmin: json["is_admin"]);
}
