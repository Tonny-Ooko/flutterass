class User {
  final String id;
  final String name;
  final String email;
  final String occupation;
  final String bio;
  final String? phone; 
  final String? address; 
  final String? profileImage; 

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.occupation,
    required this.bio,
    this.phone, 
    this.address, 
    this.profileImage, 
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      occupation: json['occupation'] ?? '',
      bio: json['bio'] ?? '',
      phone: json['phone'], 
      address: json['address'], 
      profileImage: json['profileImage'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'occupation': occupation,
      'bio': bio,
      'phone': phone,
      'address': address,
      'profileImage': profileImage,
    };
  }
}
