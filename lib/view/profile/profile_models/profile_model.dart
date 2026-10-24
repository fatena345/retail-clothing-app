class ProfileModel {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final String? creationAt;
  final String? updatedAt;

  ProfileModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    this.creationAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? 'https://api.lorem.space/image/face?w=640&h=480',
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'name': name,
    'role': role,
    'avatar': avatar,
    'creationAt': creationAt,
    'updatedAt': updatedAt,
  };
}