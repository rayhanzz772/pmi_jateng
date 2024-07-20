import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class BookNow extends StatefulWidget {
  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDeparture = DateTime.now().add(Duration(days: 1));
  int numberOfGuests = 1;

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
      firstDate: _selectedDate, // Ensure departure date is after arrival date
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

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 12, right: 7, left: 7),
      padding: EdgeInsets.only(left: 10, right: 10),
      height: hp * 0.201,
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
                Container(
                  color: kPrimaryMaroon, // Use the correct color variable here
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
                ),
                Container(
                  color: kPrimaryMaroon, // Use the correct color variable here
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
                ),
              ],
            ),
            SizedBox(height: hp * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: kPrimaryMaroon, // Use the correct color variable here
                  child: Row(
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
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
