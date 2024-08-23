import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/service/api_service.dart'; // Import file api_service.dart
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
  List<Map<String, dynamic>> _transactions = [];

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

    // Debug print statements
    print('Email: $_email');
    print('Token: $_token');

    if (_email != null) {
      _fetchUserTransactions();
    }
  }

  Future<void> _fetchUserTransactions() async {
    if (_email == null || _token == null) return;

    final transactions =
        await ApiService.fetchUserTransactions(_email!, _token);
    setState(() {
      _transactions = transactions;
    });
  }

  final List<String> labels = [
    'semua',
    'success',
    'pending',
    'failed',
  ];

  List<Map<String, dynamic>> getFilteredTransactions() {
    if (labels[selectedItem] == 'semua') {
      return _transactions;
    } else {
      return _transactions
          .where((transaction) =>
              transaction['transaction_status'] == labels[selectedItem])
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
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_token == null || _email == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Get.offNamed('/sign_in');
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
          onPressed: () {
            Get.toNamed('/profile');
          },
        ),
        title: Text(
          'History',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: kPrimaryWhite),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                itemCount: getFilteredTransactions().length,
                itemBuilder: (context, index) {
                  final transaction = getFilteredTransactions()[index];
                  return GestureDetector(
                    onTap: () {
                      print(
                          'GestureDetector tapped. ID: ${transaction['id']}, User Email: $_email');
                      Get.to(() => HistoryDetail(
                            id: transaction['id'], // Assuming 'id' exists
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
                            color: Colors.black.withOpacity(0.5),
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
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TRANSACTION',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: wp * 0.035,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  transaction['transaction_date']!,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: wp * 0.03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: hp * 0.01,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/kamar.jpeg', // Placeholder image
                                      width: wp * 0.3,
                                      height: hp * 0.128,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Container(
                                  height: hp * 0.12,
                                  width: wp * 0.58,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${transaction['order_id']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                  fontSize: wp * 0.03),
                                            ),
                                            SizedBox(height: 5),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                '${transaction['amount']} items - Total Price: ${transaction['total_price']}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                    fontSize: wp * 0.025),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        children: [
                                          Text(
                                            transaction['transaction_status']!,
                                            style: TextStyle(
                                              fontSize: wp * 0.03,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              color: transaction[
                                                          'transaction_status'] ==
                                                      'success'
                                                  ? Colors.green
                                                  : transaction[
                                                              'transaction_status'] ==
                                                          'pending'
                                                      ? Colors.blue[900]
                                                      : transaction[
                                                                  'transaction_status'] ==
                                                              'failed'
                                                          ? Colors.red
                                                          : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
