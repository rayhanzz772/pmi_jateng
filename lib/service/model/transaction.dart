// lib/models/transaction_model.dart

class Transaction {
  final int id; // Updated to int
  final String
      userEmail; // Changed from user_email to userEmail for Dart conventions
  final String channel;
  final String orderId; // Changed from order_id to orderId for Dart conventions
  final String
      snapToken; // Changed from snap_token to snapToken for Dart conventions
  final String
      transactionDate; // Changed from transaction_date to transactionDate for Dart conventions
  final int amount;
  final String
      totalPrice; // Keep this as String since it includes currency symbol
  final String
      transactionStatus; // Changed from transaction_status to transactionStatus for Dart conventions
  final int verifyCheckin;
  final int verifyCheckout;
  final String roomImage; // Made nullable, as per your earlier implementation
  final String
      roomType; // Changed from room_type to roomType for Dart conventions

  Transaction({
    required this.id,
    required this.userEmail,
    required this.channel,
    required this.orderId,
    required this.snapToken,
    required this.transactionDate,
    required this.amount,
    required this.totalPrice,
    required this.transactionStatus,
    required this.verifyCheckin,
    required this.verifyCheckout,
    required this.roomImage,
    required this.roomType,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userEmail: json['user_email'],
      channel: json['channel'],
      orderId: json['order_id'],
      snapToken: json['snap_token'],
      transactionDate: json['transaction_date'],
      amount: json['amount'],
      totalPrice: json['total_price'],
      transactionStatus: json['transaction_status'],
      verifyCheckin: json['verifyCheckin'],
      verifyCheckout: json['verifyCheckout'],
      roomImage: json['room_image'],
      roomType: json['room_type'],
    );
  }
}
