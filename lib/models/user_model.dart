class UserModel {
  String id;
  String name;
  String email;
  String phoneNumber;
  String emergencyContact;
  String profileImageUrl;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.emergencyContact,
    required this.profileImageUrl,
    required this.createdAt,
  });

  /// Converts a UserModel instance to a JSON object (for storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'emergencyContact': emergencyContact,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Creates a UserModel instance from a JSON object (for fetching data)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      emergencyContact: json['emergencyContact'],
      profileImageUrl: json['profileImageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
