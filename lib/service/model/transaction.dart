// Assuming this is your Transaction class
class Transaction {
  String? id;
  String? transactionDate;
  String? transactionStatus;
  String? orderId;
  String? roomType;
  String? roomImage;
  int amount;
  double totalPrice;

  Transaction({
    this.id,
    this.transactionDate,
    this.transactionStatus,
    this.orderId,
    this.roomType,
    this.roomImage,
    required this.amount,
    required this.totalPrice,
  });

  // Factory method to create a Transaction from a JSON map
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      transactionDate: json['transaction_date'],
      transactionStatus: json['transaction_status'],
      orderId: json['order_id'],
      roomType: json['room_type'],
      roomImage: json['room_image'],
      amount: json['amount'],
      totalPrice: json['total_price'],
    );
  }
}
