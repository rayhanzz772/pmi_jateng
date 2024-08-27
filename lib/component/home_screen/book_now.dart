import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmi_jateng/blocs/booking/booking_event.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/service/model/meeting_room.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/booking/paymentScreenRegular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookNow extends StatefulWidget {
  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  String? _email;
  String? _token;
  String? _name;
  bool _isLoading = true;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDeparture = DateTime.now().add(Duration(days: 1));
  int numberOfGuests = 1;
  String? selectedId;

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

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectDepartureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDeparture,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDeparture) {
      setState(() {
        _selectedDeparture = picked;
      });
    }
  }

  void incrementGuests() {
    setState(() {
      numberOfGuests++;
    });
  }

  void decrementGuests() {
    if (numberOfGuests > 1) {
      setState(() {
        numberOfGuests--;
      });
    }
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<MeetRoom> rooms) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final MeetRoom room in rooms) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: room.id.toString(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                room.roomType,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          // If it's the last item, do not add a Divider after it.
          if (room != rooms.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
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
                CircularProgressIndicator(),
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
        id: selectedId.toString(),
        start_dt: _selectedDate.toString(),
        end_dt: _selectedDeparture.toString(),
        amo: numberOfGuests.toString(), // Convert `state.guests` to String
        sd: "client",
      );

      // Dismiss the loading dialog
      Navigator.of(context).pop();
      print("snapTOken : ${snapToken}");
      if (snapToken != null) {
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
      Navigator.of(context).pop();
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 12, right: 7, left: 7),
      padding: EdgeInsets.only(left: 10, right: 10),
      height: hp * 0.27,
      decoration: BoxDecoration(
        color: kPrimaryMaroon, // Use the correct color variable here
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        width: wp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Book now your ideal room',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: wp * 0.05,
                fontWeight: FontWeight.w600,
                color: Colors.white, // Use the correct color variable here
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<BookingBloc, BookingState>(
                    builder: (context, state) {
                  return Container(
                    color:
                        kPrimaryMaroon, // Use the correct color variable here
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Arrival date',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: wp * 0.03,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${_selectedDate.toLocal()}".split(' ')[0],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: wp * 0.03,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 100,
                              height: 1,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: kPrimaryMaroon,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: wp * 0.08,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                BlocBuilder<BookingBloc, BookingState>(
                    builder: (context, state) {
                  return Container(
                    color:
                        kPrimaryMaroon, // Use the correct color variable here
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Departure date',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: wp * 0.03,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${_selectedDeparture.toLocal()}".split(' ')[0],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: wp * 0.03,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 100,
                              height: 1,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => _selectDepartureDate(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: kPrimaryMaroon,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: wp * 0.08,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: hp * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Number of guest',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: wp * 0.03,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '$numberOfGuests',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: wp * 0.03,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: 100,
                                height: 1,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF8D0000),
                                ),
                                child: InkWell(
                                  onTap: decrementGuests,
                                  child: Container(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: wp * 0.05,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF8D0000),
                                ),
                                child: InkWell(
                                  onTap: incrementGuests,
                                  child: Container(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: wp * 0.05,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Meeting room',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: wp * 0.03,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins',
                            ),
                          ),
                          SizedBox(height: 4),
                          FutureBuilder<List<MeetRoom>>(
                            future: ApiService.fetchRoomTypes(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Text('No room types available');
                              } else {
                                final List<MeetRoom> rooms = snapshot.data!;
                                return Container(
                                  width: wp * 0.36,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select Room Type',
                                        style: TextStyle(
                                          fontSize: wp * 0.03,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: _addDividersAfterItems(rooms),
                                      value: selectedId,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedId = newValue;
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        height: 40,
                                        width: 140,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                      dropdownStyleData:
                                          const DropdownStyleData(
                                        maxHeight: 200,
                                        width: 140,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: hp * 0.02,
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedId != null) {
                  handleBooking(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a room type'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Container(
                height: hp * 0.04,
                width: wp * 0.3,
                decoration: BoxDecoration(
                    color: kPrimaryWhite,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: kPrimaryBlack, width: 2)),
                child: Center(
                    child: Text(
                  'Book Now',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: wp * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
