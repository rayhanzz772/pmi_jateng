class BookingDetail {
  final String userName;
  final int roomBooked;
  final List<String> roomName;
  final String roomType;
  final String roomImage;
  final String orderId;
  final String checkIn;
  final String checkOut;
  final int totalNight;
  final String paymentStatus;
  final String channel;
  final String roomPerNightPrice;
  final String totalPrice;
  final String snapToken;
  List<int> roomTypeId; // Buat properti untuk room_type_id

  BookingDetail({
    required this.userName,
    required this.roomBooked,
    required this.roomName,
    required this.roomType,
    required this.roomImage,
    required this.orderId,
    required this.checkIn,
    required this.checkOut,
    required this.totalNight,
    required this.paymentStatus,
    required this.channel,
    required this.roomPerNightPrice,
    required this.totalPrice,
    required this.snapToken,
    required this.roomTypeId, // Pastikan roomTypeId ada di sini
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) {
    return BookingDetail(
      userName: json['guest_information']['user_name'],
      roomBooked: json['guest_information']['room_booked'],
      roomName: List<String>.from(json['room_detail']['room_name']),
      roomType: json['room_detail']['room_type'],
      roomImage: json['room_detail']['room_image'],
      orderId: json['order_id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      totalNight: json['total_night'],
      paymentStatus: json['payment_information']['payment_status'],
      channel: json['payment_information']['channel'],
      roomPerNightPrice: json['payment_information']['room_per_night_price'],
      totalPrice: json['payment_information']['total_price'],
      snapToken: json['payment_information']['snap_token'],
      roomTypeId: List<int>.from(json['room_detail']
          ['room_type_id']), // Parsing room_type_id sebagai List<int>
    );
  }
}
