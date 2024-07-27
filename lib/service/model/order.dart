class Post {
  String name;
  String phone;

  Post({
    required this.name,
    required this.phone,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
      };
}
