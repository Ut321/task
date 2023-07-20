class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final double latitude;
  final double longitude;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_details']['id'],
      name: json['user_details']['name'],
      email: json['user_details']['email'],
      phone: json['user_details']['phone'],
      image: json['user_details']['image'],
      latitude: json['user_details']['location']['latitude'].toDouble(),
      longitude: json['user_details']['location']['longitude'].toDouble(),
    );
  }
}
