class PackageType {
  final int id;
  final String name;
  final String pricePerPerson;
  final int minPersonQuantity;
  final int hasLodgeRoom;
  final int hasMeetingRoom;
  final String description;
  final String images;

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
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      pricePerPerson: json['price_per_person'] ?? '0',
      minPersonQuantity: json['min_person_quantity'] ?? 1,
      hasLodgeRoom: json['hasLodgeRoom'] ?? 0,
      hasMeetingRoom: json['hasMeetingRoom'] ?? 0,
      description: json['description'] ?? '',
      images: json['thumbnail'] ?? '',
    );
  }
}
