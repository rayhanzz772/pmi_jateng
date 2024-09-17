import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pmi_jateng/service/config.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/available/available_room.dart';
import 'dart:convert';

class BookNow extends StatefulWidget {
  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  bool isLoading = false; // Add loading state

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> _fetchAvailableRooms() async {
    if (selectedStartDate == null ||
        selectedEndDate == null ||
        amountController.text.isEmpty) {
      // Handle empty fields if necessary
      return;
    }

    setState(() {
      isLoading = true; // Set loading to true
    });

    final startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate!);
    final endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate!);
    final amount = amountController.text;

    final url =
        '$baseUrl/api/v1/booking/availableRoomOnDate?start_date=$startDate&end_date=$endDate&amount=$amount';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AvailableScreen(data: data),
          ),
        );
      } else {
        // Handle error response
        print('Failed to load available rooms');
      }
    } catch (e) {
      // Handle any errors
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false; // Set loading to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      height: hp * 0.5,
      width: wp,
      decoration: BoxDecoration(
        color: kPrimaryMaroon,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: isLoading // Check loading state
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryWhite),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Ketersediaan Ruang",
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: hp * 0.028,
                      color: kPrimaryWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: hp * 0.05),

                // Start Date Picker with label
                _buildDatePicker(
                  context: context,
                  label: 'Tanggal datang',
                  controller: startDateController,
                  onDateSelected: (date) {
                    setState(() {
                      selectedStartDate = date;
                      startDateController.text =
                          DateFormat('yyyy-MM-dd').format(date);
                    });
                  },
                ),
                SizedBox(height: hp * 0.02),

                // End Date Picker with label
                _buildDatePicker(
                  context: context,
                  label: 'Tanggal pergi',
                  controller: endDateController,
                  onDateSelected: (date) {
                    setState(() {
                      selectedEndDate = date;
                      endDateController.text =
                          DateFormat('yyyy-MM-dd').format(date);
                    });
                  },
                ),
                SizedBox(height: hp * 0.02),

                // Amount Field
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Jumlah tamu',
                    labelStyle: TextStyle(color: kPrimaryWhite),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryWhite),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryFontColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: kPrimaryMaroon,
                  ),
                  style: TextStyle(color: kPrimaryWhite),
                ),
                SizedBox(height: hp * 0.03),

                // Book Now Button
                Center(
                  child: isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryBlack),
                        )
                      : GestureDetector(
                          onTap: _fetchAvailableRooms,
                          child: Container(
                            height: hp * 0.06,
                            width: wp * 0.4,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryBlack, width: 2),
                              color: kPrimaryWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(
                              child: Text(
                                "Book Now",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildDatePicker({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: kPrimaryWhite),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: kPrimaryWhite),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryWhite),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryWhite),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: kPrimaryMaroon,
        hintText: 'Select $label',
        hintStyle: TextStyle(color: kPrimaryWhite),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          onDateSelected(pickedDate);
        }
      },
    );
  }
}
