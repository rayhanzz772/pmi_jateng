import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmi_jateng/blocs/booking/booking_event.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/booking/paymentScreen.dart';

class BookingForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(apiService: ApiService()),
      child: Scaffold(
        backgroundColor: kPrimaryWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryFontColor,
          title: Text(
            'Form Pemesanan Kamar',
            style: TextStyle(color: kPrimaryWhite, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BookingFormFields(),
        ),
      ),
    );
  }
}

class BookingFormFields extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
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
                      "Tipe Kamar : Deluxe",
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
                              style: TextStyle(color: kPrimaryFontColor),
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
                                style: TextStyle(color: kPrimaryFontColor)),
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
                                style: TextStyle(color: kPrimaryFontColor)),
                          ],
                        ),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Icon(Icons.local_laundry_service,
                                size: 18, color: kPrimaryFontColor),
                            SizedBox(width: 8),
                            Text("Laundry",
                                style: TextStyle(color: kPrimaryFontColor)),
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
                                style: TextStyle(color: kPrimaryFontColor)),
                          ],
                        ),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Icon(Icons.bed, size: 18, color: kPrimaryFontColor),
                            SizedBox(width: 8),
                            Text("2 Single Bed",
                                style: TextStyle(color: kPrimaryFontColor)),
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
                Text("Nama Pemesan"),
                SizedBox(
                  height: 3,
                ),
                BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    return Container(
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
                            borderSide: BorderSide(color: kPrimaryFontColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        initialValue: state.name,
                        onChanged: (value) {
                          context.read<BookingBloc>().add(UpdateName(value));
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "*Isi nama pemesan sesuai KTP/Paspor/SIM",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10),
                Text("Nomor Hp"),
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
                      initialValue: state.phone,
                      onChanged: (value) {
                        context.read<BookingBloc>().add(UpdatePhone(value));
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "*Contoh: +62812345678",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10),
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
                        context
                            .read<BookingBloc>()
                            .add(UpdateGuests(int.parse(value)));
                      },
                    );
                  },
                ),
                SizedBox(height: 10),
                Text("Tanggal dan Pukul masuk"),
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
                              text: state.checkInDate
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0],
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: state.checkInDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                context
                                    .read<BookingBloc>()
                                    .add(UpdateCheckInDate(pickedDate));
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Pukul Masuk',
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
                              text: state.checkInTime.format(context),
                            ),
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: state.checkInTime,
                              );
                              if (pickedTime != null) {
                                context
                                    .read<BookingBloc>()
                                    .add(UpdateCheckInTime(pickedTime));
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10),
                Text("Tanggal dan Pukul keluar"),
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
                              text: state.checkOutDate
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0],
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: state.checkOutDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                context
                                    .read<BookingBloc>()
                                    .add(UpdateCheckOutDate(pickedDate));
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          height: 3,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Pukul Keluar',
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
                              text: state.checkOutTime.format(context),
                            ),
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: state.checkOutTime,
                              );
                              if (pickedTime != null) {
                                context
                                    .read<BookingBloc>()
                                    .add(UpdateCheckOutTime(pickedTime));
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Harga Kamar"),
                        Text("Rp. 200.000"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pajak dan biaya lainnya"),
                        Text("Rp. 2000"),
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
                        Text(
                          "Rp. 220000",
                          style: TextStyle(
                              color: kPrimaryFontColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
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
                        if (state.status == BookingStatus.submitting) {
                          return CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: () async {
                            await handleBooking(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryFontColor),
                          child: Text(
                            'Submit',
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

    try {
      final snapToken = await bookingBloc.apiService.insertData(
        name: state.name,
        phone: state.phone,
        guests: state.guests,
        email: "rayhanzz772@gmail.com",
        harga: state.guests * 200000,
        checkinTime: state.checkInDate,
        checkoutTime: state.checkOutDate,
      );

      if (snapToken != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(snapToken: snapToken),
          ),
        );
      } else {
        print('Failed to get snap token');
      }
    } catch (e) {
      // Tangani kesalahan jika diperlukan
      print('Error: $e');
    }
  }
}
