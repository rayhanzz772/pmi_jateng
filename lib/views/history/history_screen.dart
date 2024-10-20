import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    if (_email != null && _token != null) {
      await _fetchUserTransactions();
    }
  }

  Future<void> _fetchUserTransactions() async {
    if (_email == null || _token == null) return;

    final transactions =
        await ApiService.fetchUserTransactions(_email!, _token);
    transactions.sort((a, b) {
      DateTime dateTimeA = DateTime.parse(a['transaction_date']);
      DateTime dateTimeB = DateTime.parse(b['transaction_date']);
      return dateTimeB.compareTo(dateTimeA);
    });

    setState(() {
      _transactions = transactions;
    });
  }

  final List<String> labels = ['semua', 'success', 'pending', 'failed'];

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

  Future<void> _refresh() async {
    await _fetchUserTransactions();
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

    List<Map<String, dynamic>> filteredTransactions = getFilteredTransactions();

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
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];

                  // Debugging output
                  print(
                      'Order ID: ${transaction['order_id']}, Length: ${transaction['order_id'].length}');

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => HistoryDetail(
                            id: transaction['id'],
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
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey),
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
                                  transaction['transaction_date']!,
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
                                  '${transaction['room_image']}',
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
                                      '${transaction['room_type']}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: wp * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      transaction['order_id'].length > 20
                                          ? '${transaction['order_id'].substring(0, 20)}...'
                                          : transaction['order_id'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        fontSize: wp * 0.03,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 40.0),
                                      child: Text(
                                        '${transaction['amount']} items - Total Price: ${transaction['total_price']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          fontSize: wp * 0.025,
                                        ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
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
      ),
    );
  }
}
