import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Ensure you have this package in pubspec.yaml
import 'package:get/get.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/service/model/booking_detail.dart';
import 'package:pmi_jateng/views/history/detail/history_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Review extends StatefulWidget {
  final int transactionId; // Pass transaction ID when creating this widget
  final String? token; // Pass the auth token if needed
  final int id;
  final List<int> roomTypeIds;
  final String user_email; // Tambahkan parameter user_email

  Review(
      {required this.roomTypeIds,
      required this.transactionId,
      this.token,
      required this.id,
      required this.user_email});

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  String? _token;
  String? _email;
  bool _isLoading = true;
  bool _hasReview = false;
  String _reviewText = '';
  int _rating = 0;
  String _error = '';
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchReview();
    _saveLogin();
    _fetchBookingDetail();
  }

  Future<void> _saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token =
          prefs.getString('auth_token'); //ambil token dari SharedPreferences
      _email = prefs.getString('auth_email');
    });
  }

  Future<BookingDetail?> _fetchBookingDetail() async {
    if (_token != null) {
      return ApiService.fetchUserTransactionsById(widget.id, widget.user_email,
          _token!); // Sertakan token dalam API call
    } else {
      throw Exception('Token not available');
    }
  }

  Future<void> _fetchReview() async {
    try {
      final response =
          await ApiService.getReviewForCurrentTransaction(widget.id, _token);

      setState(() {
        _isLoading = false;
        if (response['status'] == true) {
          _hasReview = true;
          _reviewText = response['review'] ?? '';
          _rating = response['score'] ?? 0;
          _reviewController.text = _reviewText; // Prepopulate the text field
        } else {
          _hasReview = false;
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to fetch review: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isLoading)
          CircularProgressIndicator()
        else if (_error.isNotEmpty)
          Text(_error)
        else if (_hasReview)
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Review",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Display Rating
                          RatingBar.builder(
                            initialRating: _rating.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            ignoreGestures:
                                true, // Make rating bar non-interactive
                            onRatingUpdate: (value) {
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Display Review Text
                          Text(
                            _reviewText,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        else
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.star,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Review",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                // Rating Bar
                RatingBar.builder(
                  initialRating: _rating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating.toInt();
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                // Description Field
                TextField(
                  controller: _reviewController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Write your review here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // Submit Button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true; // Show loading indicator if needed
                      });

                      bool success = await ApiService.postReview(
                          widget.user_email,
                          widget.transactionId,
                          _reviewController.text,
                          _rating,
                          widget.token,
                          [1]);

                      setState(() {
                        _isLoading = false; // Hide loading indicator
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Review submitted successfully!'),
                            ),
                          );

                          // Navigate to HistoryDetail page
                          Get.offAll(() => HistoryDetail(
                                id: widget.transactionId,
                                user_email: widget.user_email!,
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to submit review.'),
                            ),
                          );
                        }
                      });
                    },
                    child: Text("Submit Review"),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
