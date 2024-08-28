import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class BookNow extends StatefulWidget {
  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Check Available Rooms",
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
            label: 'Start Date',
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
            label: 'End Date',
            controller: endDateController,
            onDateSelected: (date) {
              setState(() {
                selectedEndDate = date;
                endDateController.text = DateFormat('yyyy-MM-dd').format(date);
              });
            },
          ),
          SizedBox(height: hp * 0.02),

          // Amount Field
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter Amount',
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
            child: GestureDetector(
              onTap: () {
                // Handle the booking action here
              },
              child: Container(
                height: hp * 0.06,
                width: wp * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryBlack, width: 2),
                  color: kPrimaryWhite,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
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
