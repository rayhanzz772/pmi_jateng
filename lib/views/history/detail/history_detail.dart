import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/blocs/booking/booking_event.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/service/model/booking_detail.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/booking/paymentScreenPackage.dart';
import 'package:pmi_jateng/views/booking/paymentScreenRegular.dart';
import 'package:pmi_jateng/views/history/detail/component/history_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HistoryDetail extends StatefulWidget {
  @override
  final int id; // Tambahkan parameter id
  final String user_email; // Tambahkan parameter user_email

  const HistoryDetail({Key? key, required this.id, required this.user_email})
      : super(key: key);
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  String? _token;
  String? _email;
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0; // Variable to hold the rating value

  void initState() {
    super.initState();
    _saveLogin();
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

  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryWhite,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
          onPressed: () {
            Get.toNamed('/history');
          },
        ),
        title: Text(
          'Detail Transaksi',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: kPrimaryWhite),
        ),
      ),
      body: FutureBuilder<BookingDetail?>(
          future: _fetchBookingDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: kPrimaryMaroon,
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            } else {
              final bookingDetail = snapshot.data!;

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: kPrimaryFontColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookingDetail.paymentStatus,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: kPrimaryWhite),
                                ),
                                Text(
                                  bookingDetail.paymentStatus == 'pending'
                                      ? "Pesanan belum dibayar. Kami tunggu "
                                      : bookingDetail.paymentStatus == 'success'
                                          ? "Pesanan telah selesai. Kami tunggu "
                                          : "Pesanan gagal. Coba lagi",
                                  style: TextStyle(
                                    color: kPrimaryWhite,
                                  ),
                                ),
                                Text(
                                  bookingDetail.paymentStatus == 'pending'
                                      ? "mohon dibayar sesuai waktu"
                                      : "pesanan berikutnya",
                                  style: TextStyle(
                                    color: kPrimaryWhite,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: kPrimaryWhite,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: wp * 0.8,
                                  child: Text(
                                      "Order Id : ${bookingDetail.orderId}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.visible),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Menyalin ID pesanan ke clipboard
                                    Clipboard.setData(ClipboardData(
                                        text: bookingDetail.orderId));

                                    // Menampilkan pesan snackbar (opsional)
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('ID pesanan disalin!')),
                                    );
                                  },
                                  child: Text(
                                    "Salin",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors
                                          .blue, // Warna teks bisa diubah agar terlihat seperti tautan
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Check-in",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  bookingDetail.checkIn,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "14.00",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Sampai",
                                    style: TextStyle(
                                        fontSize: 11, color: kPrimaryWhite),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Check-out",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  bookingDetail.checkOut,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "14.00",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Informasi Ruangan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        (bookingDetail.roomImage != null &&
                                                bookingDetail
                                                    .roomImage.isNotEmpty)
                                            ? bookingDetail.roomImage
                                            : 'assets/images/kamar.jpeg',
                                        width: 90.0,
                                        height: 90.0,
                                        fit: BoxFit.fill,
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            'assets/images/kamar.jpeg', // Gambar lokal
                                            width: 90.0,
                                            height: 90.0,
                                            fit: BoxFit.fill,
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${bookingDetail.roomBooked}x Twin Room",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            "Pemandangan Kota | 18 m²/194 ft² | Bebas asap rokok | 2 kasur twin",
                                            style: TextStyle(fontSize: 12),
                                            softWrap:
                                                true, // Membungkus teks jika terlalu panjang
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Keuntungan",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          Text(
                                            "Parkir, Air minum, Kopi & Teh, WiFi Gratis",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Permintaan Khusus",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          Text(
                                            "Saya ingin kamar bebas asap rokok",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.access_time,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Informasi Tamu",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tamu utama",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      bookingDetail.userName,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      // pembatas
                      SizedBox(
                        height: 20,
                      ),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.access_time,
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
                                    "Kebijakan Pembatalan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "Tidak datang pada tanggal check-in dianggap sebagai No.Show dan akan dikenai biaya sebesar 100% dari nominal pesanan (kebijakan hotel).",
                                    softWrap: true,
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(top: 12, right: 12, bottom: 12),
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
                        child: Row(
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
                                    "Infromasi Pembayaran",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${bookingDetail.roomBooked} kamar"),
                                          Text("Pajak dan biaya lainnya"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(bookingDetail.roomPerNightPrice),
                                          Text("-"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Harga",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bookingDetail.totalPrice,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Metode Pembayaran",
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    120, 0, 0, 0),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "-",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("ID Pesanan"),
                                          Text("Dipesan pada"),
                                          Text("Dibayar pada"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bookingDetail.orderId.length > 14
                                                ? "${bookingDetail.orderId.substring(0, 14)}..."
                                                : bookingDetail.orderId,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: wp * 0.03,
                                            ),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(bookingDetail.checkIn),
                                          Text(bookingDetail.checkOut),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Review(
                        roomTypeIds: bookingDetail.roomTypeId,
                          transactionId: widget.id,
                          id: widget.id,
                          user_email: widget.user_email),
                      if (bookingDetail.paymentStatus != 'success')
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              if (bookingDetail.snapToken != null) {
                                if (bookingDetail.roomBooked >= 1 &&
                                    bookingDetail.roomBooked <= 100) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentScreenPackage(
                                        snapToken: bookingDetail.snapToken,
                                      ),
                                    ),
                                  );
                                } else if (bookingDetail.roomBooked >= 200) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentScreenRegular(
                                        snapToken: bookingDetail.snapToken,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Invalid number of rooms booked'),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Snap token is not available'),
                                  ),
                                );
                              }
                            },
                            child: Text('Go to Payment'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 20.0),
                              textStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),

                      // Jika paymentStatus 'success', tampilkan status sukses (opsional)
                      if (bookingDetail.paymentStatus == 'success')
                        Text(
                          '',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: wp * 0.03,
                              color: Colors.green[400]),
                        ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
