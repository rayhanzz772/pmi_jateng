class PackageType {
  final int id;
  final String name;
  final String pricePerPerson;
  final int minPersonQuantity;
  final int hasLodgeRoom;
  final int hasMeetingRoom;
  final String description;
  final List<String> images;

  PackageType({
    required this.id,
    required this.name,
    required this.pricePerPerson,
    required this.minPersonQuantity,
    required this.hasLodgeRoom,
    required this.hasMeetingRoom,
    required this.description,
    required this.images,
  });

  factory PackageType.fromJson(Map<String, dynamic> json) {
    return PackageType(
      id: json['id'],
      name: json['name'],
      pricePerPerson: json['price_per_person'],
      minPersonQuantity: json['min_person_quantity'],
      hasLodgeRoom: json['hasLodgeRoom'],
      hasMeetingRoom: json['hasMeetingRoom'],
      description: json['description'],
      images: List<String>.from(json['images']),
    );
  }
}
