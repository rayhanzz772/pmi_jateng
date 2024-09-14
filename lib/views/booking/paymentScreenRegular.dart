import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreenRegular extends StatefulWidget {
  final String snapToken;

  PaymentScreenRegular({required this.snapToken});

  @override
  _PaymentScreenRegularState createState() => _PaymentScreenRegularState();
}

class _PaymentScreenRegularState extends State<PaymentScreenRegular> {
  String? _token; // Variable untuk menyimpan token

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      setState(() {
        _token = token; // Simpan token dalam variabel lokal
      });

      // Buat URL pembayaran Midtrans
      final paymentUrl =
          'https://app.sandbox.midtrans.com/snap/v2/vtweb/${widget.snapToken}';

      // Buka URL di browser menggunakan url_launcher
      if (await canLaunch(paymentUrl)) {
        await launch(paymentUrl);
      } else {
        throw 'Could not launch $paymentUrl';
      }

      // Setelah membuka URL, langsung kembali ke halaman home
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Handle token not found case
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Token tidak ditemukan, silakan masuk kembali.'),
          duration: Duration(seconds: 2),
        ),
      );
      // Kembali ke layar sebelumnya jika token tidak ditemukan
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold kosong karena kita langsung membuka URL dan kembali ke home
    return Scaffold(
      body: Container(), // Kosongkan isi Scaffold
    );
  }
}
