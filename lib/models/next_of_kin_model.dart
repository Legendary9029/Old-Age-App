class NextOfKin {
  String id;
  String name;
  String relationship;
  String phoneNumber;
  String email;

  NextOfKin({
    required this.id,
    required this.name,
    required this.relationship,
    required this.phoneNumber,
    required this.email,
  });

  /// Converts the NextOfKin instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'relationship': relationship,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  /// Creates a NextOfKin instance from a JSON object
  factory NextOfKin.fromJson(Map<String, dynamic> json) {
    return NextOfKin(
      id: json['id'],
      name: json['name'],
      relationship: json['relationship'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }
}
