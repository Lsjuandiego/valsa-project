class User {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt; // Puede ser nulo
  final String? createdAt; // Puede ser nulo
  final String? updatedAt; // Puede ser nulo

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}