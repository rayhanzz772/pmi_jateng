import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreenRegular extends StatefulWidget {
  final String snapToken;

  PaymentScreenRegular({required this.snapToken});

  @override
  _PaymentScreenRegularState createState() => _PaymentScreenRegularState();
}

class _PaymentScreenRegularState extends State<PaymentScreenRegular> {
  late WebViewController _controller;

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
      )
      ..loadRequest(
        Uri.parse(
            'https://app.sandbox.midtrans.com/snap/v2/vtweb/${widget.snapToken}'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
