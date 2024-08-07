class MeetRoom {
  final int id;
  final String roomType;
  final int capacity;
  final String price;
  final String description;
  final String image;
  MeetRoom({
    required this.id,
    required this.roomType,
    required this.capacity,
    required this.price,
    required this.description,
    required this.image,
  });

  factory MeetRoom.fromJson(Map<String, dynamic> json) {
    return MeetRoom(
      id: json['id'],
      roomType: json['room_type'],
      capacity: json['capacity'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
    );
  }
}
