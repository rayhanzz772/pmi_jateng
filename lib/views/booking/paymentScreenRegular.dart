import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreenRegular extends StatefulWidget {
  final String snapToken;

  PaymentScreenRegular({required this.snapToken});

  @override
  _PaymentScreenRegularState createState() => _PaymentScreenRegularState();
}

class _PaymentScreenRegularState extends State<PaymentScreenRegular> {
  late WebViewController _controller;
  String? _token; // Variable untuk menyimpan token

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('example.com')) {
              // Handle callback from Midtrans
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Transaksi berhasil'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacementNamed(context, '/home');
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      setState(() {
        _token = token; // Simpan token dalam variabel lokal
      });

      // Load the payment page without the token in the URL
      _controller.loadRequest(
        Uri.parse(
          'https://app.sandbox.midtrans.com/snap/v2/vtweb/${widget.snapToken}',
        ),
      );
    } else {
      // Handle token not found case
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Token tidak ditemukan, silakan masuk kembali.'),
          duration: Duration(seconds: 2),
        ),
      );
      // Navigate back or to a different screen if needed
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
