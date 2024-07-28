import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class BottomBar extends StatefulWidget {
  final VoidCallback onCheckout;

  BottomBar({required this.onCheckout});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool _isLoading = false;

  void _handleCheckout() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Simulate a delay for loading

    setState(() {
      _isLoading = false;
    });

    widget.onCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: kPrimaryWhite,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleCheckout,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryFontColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        child: _isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryWhite),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, color: kPrimaryWhite),
                  SizedBox(width: 10),
                  Text(
                    'Checkout',
                    style: TextStyle(
                      color: kPrimaryWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
