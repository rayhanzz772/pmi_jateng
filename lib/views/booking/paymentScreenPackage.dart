import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreenPackage extends StatefulWidget {
  final String snapToken;

  PaymentScreenPackage({required this.snapToken});

  @override
  _PaymentScreenPackageState createState() => _PaymentScreenPackageState();
}

class _PaymentScreenPackageState extends State<PaymentScreenPackage> {
  @override
  void initState() {
    super.initState();
    _openPaymentUrl();
  }

  Future<void> _openPaymentUrl() async {
    final paymentUrl =
        'https://app.sandbox.midtrans.com/snap/v2/vtweb/${widget.snapToken}';

    // Gunakan url_launcher untuk membuka URL pembayaran Midtrans di browser
    if (await canLaunch(paymentUrl)) {
      await launch(paymentUrl);
    } else {
      throw 'Could not launch $paymentUrl';
    }

    // Setelah membuka URL, langsung kembali ke halaman home
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold kosong karena kita langsung membuka URL dan kembali ke home
    return Scaffold(
      body: Container(), // Kosongkan isi Scaffold
    );
  }
}
