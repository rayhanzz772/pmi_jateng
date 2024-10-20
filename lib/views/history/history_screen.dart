// lib/views/history/history_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/service/model/transaction.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/views/history/detail/history_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedItem = 0;
  String? _email;
  String? _token;
  bool _isLoading = true;
  bool _hasError = false;
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadEmailAndToken();
  }

  Future<void> _loadEmailAndToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('auth_email');
      _token = prefs.getString('auth_token');
      _isLoading = false;
    });

    if (_email != null && _token != null) {
      await _fetchUserTransactions();
    }
  }

  Future<void> _fetchUserTransactions() async {
    try {
      if (_email == null || _token == null) return;

      final transactions =
          await ApiService.fetchUserTransactions(_email!, _token);
      setState(() {
        _transactions = transactions;
        _hasError = false; // Reset error state on success
      });
    } catch (e) {
      setState(() {
        _hasError = true; // Set error state on failure
      });
      print("Error fetching transactions: $e");
    }
  }

  final List<String> labels = ['semua', 'success', 'pending', 'failed'];

  List<Transaction> getFilteredTransactions() {
    if (labels[selectedItem] == 'semua') {
      return _transactions;
    } else {
      return _transactions
          .where((transaction) =>
              transaction.transactionStatus == labels[selectedItem])
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: kPrimaryWhite,
        body: Center(child: CircularProgressIndicator(color: kPrimaryMaroon)),
      );
    }

    if (_token == null || _email == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Get.offNamed('/sign_in');
      });
    }

    if (_hasError) {
      return Scaffold(
        body: Center(
            child: Text("Error loading transactions. Please try again.")),
      );
    }

    List<Transaction> filteredTransactions = getFilteredTransactions();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryMaroon,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
          onPressed: () {
            Get.toNamed('/profile');
          },
        ),
        title: Text(
          'Transaksi',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: kPrimaryWhite,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            height: hp * 0.04,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: labels.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedItem = index;
                    });
                  },
                  child: Container(
                    width: wp * 0.26,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedItem == index ? Colors.red : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        labels[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: wp * 0.04,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(bottom: 200),
            width: wp,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => HistoryDetail(
                          id: transaction.id,
                          user_email: _email!,
                        ));
                  },
                  child: Container(
                    height: hp * 0.2,
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TRANSACTION',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: wp * 0.035,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                transaction.transactionDate,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: wp * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: hp * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                transaction.roomImage,
                                width: wp * 0.3,
                                height: hp * 0.128,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 7),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    transaction.roomType,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: wp * 0.04,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Status: ${transaction.transactionStatus}',
                                    style: TextStyle(
                                      fontSize: wp * 0.035,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Total: ${transaction.totalPrice}',
                                    style: TextStyle(
                                      fontSize: wp * 0.035,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
