class MeetRoomPaket {
  final int id;
  final String name;
  final String price_per_person;
  final String description;
  final String thumbnail;
  MeetRoomPaket({
    required this.id,
    required this.name,
    required this.price_per_person,
    required this.description,
    required this.thumbnail,
  });

  factory MeetRoomPaket.fromJson(Map<String, dynamic> json) {
    return MeetRoomPaket(
      id: json['id'],
      name: json['name'],
      price_per_person: json['price_per_person'],
      description: json['description'],
      thumbnail: json['thumbnail'],
    );
  }
}
