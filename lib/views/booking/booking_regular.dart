import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmi_jateng/blocs/booking/booking_event.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/booking/paymentScreenRegular.dart';

class BookingFormRegular extends StatefulWidget {
  @override
  final String roomType;
  final String price;
  final int id;

  BookingFormRegular(
      {required this.roomType, required this.price, required this.id});
  _BookingFormRegularState createState() => _BookingFormRegularState();
}

class _BookingFormRegularState extends State<BookingFormRegular> {
  String? _email;
  String? _token;
  String? _name;
  bool _isLoading = true;

  Future<void> _saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('auth_token');
      _name = prefs.getString('auth_name');
      _email = prefs.getString('auth_email');
      _isLoading = false;
    });
    print('Email: $_email');
    print('name: $_name');
    print('Token: $_token');
  }

  void initState() {
    super.initState();
    _saveLogin();
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => BookingBloc(apiService: ApiService()),
      child: Scaffold(
        backgroundColor: kPrimaryWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryMaroon,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Form Pemesanan Kamar',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: wp * 0.045,
                color: kPrimaryWhite),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BookingFormRegularFields(
            roomType: widget.roomType,
            price: widget.price,
            id: widget.id,
          ),
        ),
      ),
    );
  }
}

class BookingFormRegularFields extends StatelessWidget {
  final ApiService apiService = ApiService();
  final String roomType;
  final String price;
  final int id;

  BookingFormRegularFields(
      {required this.roomType, required this.price, required this.id});

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kPrimaryGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Tipe Kamar : $roomType",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.wifi,
                                size: 18, color: kPrimaryFontColor),
                            SizedBox(width: 8),
                            Text(
                              "Wifi",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: wp * 0.035,
                                  color: kPrimaryFontColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Icon(Icons.local_fire_department,
                                size: 18, color: kPrimaryFontColor),
                            SizedBox(width: 8),
                            Text("Air Hangat",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: wp * 0.035,
                                    color: kPrimaryFontColor)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.ac_unit,
                                size: 18, color: kPrimaryFontColor),
                            SizedBox(width: 8),
                            Text("AC",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: wp * 0.035,
                                    color: kPrimaryFontColor)),
                          ],
                        ),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Icon(Icons.local_laundry_service,
                                size: 18, color: kPrimaryFontColor),
                            SizedBox(width: 8),
                            Text("Laundry",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: wp * 0.035,
                                    color: kPrimaryFontColor)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tv, size: 18, color: kPrimaryFontColor),
                            SizedBox(width: 8),
                            Text("TV",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: wp * 0.035,
                                    color: kPrimaryFontColor)),
                          ],
                        ),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Icon(Icons.bed, size: 18, color: kPrimaryFontColor),
                            SizedBox(width: 8),
                            Text("2 Single Bed",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: wp * 0.035,
                                    color: kPrimaryFontColor)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kPrimaryGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Banyak Orang"),
                SizedBox(
                  height: 3,
                ),
                BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    return TextFormField(
                      decoration: InputDecoration(
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
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: state.guests.toString(),
                      onChanged: (value) {
                        context.read<BookingBloc>().add(UpdateGuests(value));
                      },
                    );
                  },
                ),
                SizedBox(height: 10),
                Text("Tanggal masuk"),
                SizedBox(
                  height: 3,
                ),
                BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryWhite),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kPrimaryFontColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            readOnly: true,
                            controller: TextEditingController(
                              text: state.checkInDate.toString().split(' ')[0],
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                              );

                              // Retrieve the current BookingState to check the default value
                              final currentState =
                                  context.read<BookingBloc>().state;
                              final defaultDateString =
                                  "yyyy-MM-dd"; // Replace with your actual default date format

                              if (pickedDate != null) {
                                // Create a new DateTime object with the picked date and time set to midnight
                                DateTime dateOnly = DateTime(pickedDate.year,
                                    pickedDate.month, pickedDate.day);

                                // Format the date as "yyyy-MM-dd"
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(dateOnly);

                                // Print the formatted date
                                print('Selected date: $formattedDate');

                                // Dispatch the updated date to the BookingBloc
                                context
                                    .read<BookingBloc>()
                                    .add(UpdateCheckInDate(formattedDate));
                              } else if (currentState.checkInDate ==
                                  "yyyy-MM-dd") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Masukan tanggal masuk dahulu'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        // Expanded(
                        //   child: TextFormField(
                        //     decoration: InputDecoration(
                        //       labelText: 'Pukul Masuk',
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: kPrimaryWhite),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide:
                        //             BorderSide(color: kPrimaryFontColor),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       filled: true,
                        //       fillColor: Colors.white,
                        //     ),
                        //     readOnly: true,
                        //     controller: TextEditingController(
                        //       text: state.checkInTime.format(context),
                        //     ),
                        //     onTap: () async {
                        //       TimeOfDay? pickedTime = await showTimePicker(
                        //         context: context,
                        //         initialTime: state.checkInTime,
                        //       );
                        //       if (pickedTime != null) {
                        //         context
                        //             .read<BookingBloc>()
                        //             .add(UpdateCheckInTime(pickedTime));
                        //       }
                        //     },
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10),
                Text("Tanggal keluar"),
                SizedBox(
                  height: 3,
                ),
                BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryWhite),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kPrimaryFontColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            readOnly: true,
                            controller: TextEditingController(
                              text: state.checkOutDate.toString().split(' ')[0],
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                // Create a new DateTime object with the picked date and time set to midnight
                                DateTime dateOnly = DateTime(pickedDate.year,
                                    pickedDate.month, pickedDate.day);

                                // Format the date as "yyyy-MM-dd"
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(dateOnly);

                                // Print the formatted date
                                print('Selected date: $formattedDate');

                                // Dispatch the updated date to the BookingBloc
                                context
                                    .read<BookingBloc>()
                                    .add(UpdateCheckOutDate(formattedDate));
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          height: 3,
                        ),
                        // Expanded(
                        //   child: TextFormField(
                        //     decoration: InputDecoration(
                        //       labelText: 'Pukul Keluar',
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: kPrimaryWhite),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide:
                        //             BorderSide(color: kPrimaryFontColor),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       filled: true,
                        //       fillColor: Colors.white,
                        //     ),
                        //     readOnly: true,
                        //     controller: TextEditingController(
                        //       text: state.checkOutTime.format(context),
                        //     ),
                        //     onTap: () async {
                        //       TimeOfDay? pickedTime = await showTimePicker(
                        //         context: context,
                        //         initialTime: state.checkOutTime,
                        //       );
                        //       if (pickedTime != null) {
                        //         context
                        //             .read<BookingBloc>()
                        //             .add(UpdateCheckOutTime(pickedTime));
                        //       }
                        //     },
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    BlocBuilder<BookingBloc, BookingState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Harga Kamar"),
                                Text("Rp. $price"),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Pajak dan biaya lainnya"),
                                Text("Rp. -"),
                              ],
                            ),
                            Divider(
                              color: Colors.grey, // Color of the line
                              thickness: 2, // Thickness of the line
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Harga Total",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // Kalkulasi harga total berdasarkan harga per kamar dan jumlah orang
                                Text(
                                  "Rp. ${(int.tryParse(price) ?? 0) * (int.tryParse(state.guests) ?? 0)}",
                                  style: TextStyle(
                                    color: kPrimaryFontColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<BookingBloc, BookingState>(
                      builder: (context, state) {
                        bool isDateValid = state.checkInDate != "yyyy-MM-dd" &&
                            state.checkOutDate != "yyyy-MM-dd";
                        return ElevatedButton(
                          onPressed: isDateValid
                              ? () async {
                                  await handleBooking(context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryFontColor),
                          child: Text(
                            'Book Now',
                            style: TextStyle(color: kPrimaryWhite),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    if (state.status == BookingStatus.failure) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Error: ${state.errorMessage}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                //
                //
                //
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleBooking(BuildContext context) async {
    final bookingBloc = context.read<BookingBloc>();
    final state = bookingBloc.state;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: kPrimaryMaroon),
                SizedBox(width: 16),
                Text("Processing booking..."),
              ],
            ),
          ),
        );
      },
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('auth_email') ?? 'default@example.com';
      final snapToken = await bookingBloc.apiService.BookingRegular(
        email: email,
        id: id.toString(), // Convert `id` to String
        start_dt: state.checkInDate.toString(),
        end_dt: state.checkOutDate.toString(),
        amo: state.guests, // Convert `state.guests` to String
        sd: "client",
      );

      // Dismiss the loading dialog
      Navigator.of(context).pop();

      if (snapToken != null && state.checkInDate != "yyyy-MM-dd") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreenRegular(snapToken: snapToken),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kamar penuh'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Dismiss the loading dialog
      Navigator.of(context).pop();

      // Handle the error if necessary
      print('Error: $e');
    }
  }
}
