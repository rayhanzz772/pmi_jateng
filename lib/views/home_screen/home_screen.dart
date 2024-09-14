import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/component/home_screen/package_room.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:pmi_jateng/component/home_screen/about_us.dart';
import 'package:pmi_jateng/component/home_screen/contact_us.dart';
import 'package:pmi_jateng/component/home_screen/footer.dart';
import 'package:pmi_jateng/component/home_screen/mitra.dart';
import 'package:pmi_jateng/component/home_screen/our_gallery.dart';
import 'package:pmi_jateng/component/home_screen/our_services.dart';
import 'package:pmi_jateng/component/home_screen/superior_room.dart';
import 'package:pmi_jateng/component/home_screen/top_bar.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/component/home_screen/meeting_room.dart';
import 'package:pmi_jateng/component/home_screen/sidebar.dart';
import 'package:pmi_jateng/component/home_screen/book_now.dart';
import 'package:pmi_jateng/service/auth_control.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _email;
  String? _name;
  String? _token;
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _RegularRoomCardKey = GlobalKey();
  final GlobalKey _packageRoomCardKey = GlobalKey();
  bool showPackageRoom = false;
  @override
  void initState() {
    super.initState();
    _saveLogin();
  }

  void _scrollToRegularRoomCard() {
    // Cek apakah currentContext null
    if (_RegularRoomCardKey.currentContext == null) {
      print("MeetingRoomCard context is null");
      return; // Keluar jika null
    }

    // Menghitung offset ke MeetingRoomCard
    final RenderBox renderBox =
        _RegularRoomCardKey.currentContext!.findRenderObject() as RenderBox;

    // Menghitung posisi global MeetingRoomCard
    final offset = renderBox.localToGlobal(Offset.zero).dy;

    // Menghitung posisi scroll saat ini
    final currentScrollPosition = _scrollController.position.pixels;

    // Scroll ke offset yang dihitung
    _scrollController.animateTo(
      offset - currentScrollPosition,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToPackageRoomCard() {
    // Check if currentContext is null
    if (_packageRoomCardKey.currentContext == null) {
      print("PackageRoomCard context is null");
      return; // Exit if null
    }

    // Calculate the offset to PackageRoomCard
    final RenderBox renderBox =
        _packageRoomCardKey.currentContext!.findRenderObject() as RenderBox;

    // Calculate global position of PackageRoomCard
    final offset = renderBox.localToGlobal(Offset.zero).dy;

    // Calculate current scroll position
    final currentScrollPosition = _scrollController.position.pixels;

    // Scroll to the calculated offset with additional downward offset (e.g., 50 pixels)
    _scrollController.animateTo(
      offset - currentScrollPosition + 20, // Add 50 pixels offset
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('auth_email');
      _name = prefs.getString('auth_name');
      _token = prefs.getString('auth_token');
      _isLoading = false;
    });

    // Debug print statements
    print('Email: $_email');
    print('name: $_name');
    print('Token: $_token');
  }

  Future<void> _refresh() async {
    await _saveLogin();
  }

  Future<bool> _onWillPop() async {
    if (_token != null) {
      // If token is present, prevent back navigation
      return false;
    }
    // Allow back navigation if no token is present
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: kPrimaryWhite,
        body: Center(
            child: CircularProgressIndicator(
          color: kPrimaryMaroon,
        )),
      );
    }
    if (_token == null || _email == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Get.offNamed('/sign_in');
      });
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      color: kPrimaryMaroon,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: kPrimaryWhite,
          body: Stack(
            children: [
              // Konten di bawah top bar
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      height: hp * 0.75,
                      width: wp,
                      decoration: BoxDecoration(
                          color: kPrimaryBlack,
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/landing_page.png'),
                              fit: BoxFit.cover)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: hp * 0.09),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Find your ',
                                    style: TextStyle(
                                        fontFamily: 'JosefinSans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: wp * 0.12,
                                        color: kPrimaryWhite),
                                  ),
                                  Text('ideal room',
                                      style: TextStyle(
                                          fontFamily: 'josefinsans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: wp * 0.12,
                                          color: kPrimaryWhite)),
                                  Container(
                                    height: hp * 0.03,
                                    width: wp * 0.25,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/Vector.png'),
                                            fit: BoxFit.contain)),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                      _scrollToRegularRoomCard();
                                    });
                                  },
                                  child: Container(
                                    height: hp * 0.15,
                                    width: wp * 0.4,
                                    padding: EdgeInsets.all(3),
                                    margin: EdgeInsets.only(
                                        right: wp * 0.05,
                                        top: hp * 0.09,
                                        left: wp * 0.05),
                                    decoration: BoxDecoration(
                                        color: kPrimaryMaroon,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: wp,
                                          height: hp * 0.09,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(17)),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/our_room.jpg'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(hp * 0.01),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Our rooms',
                                                style: TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: wp * 0.037,
                                                    fontWeight: FontWeight.w600,
                                                    color: kPrimaryWhite),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                width: wp * 0.07,
                                                height: hp * 0.03,
                                                decoration: BoxDecoration(
                                                  color: kPrimaryWhite,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6)),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.arrow_forward,
                                                    color: kPrimaryMaroon,
                                                    size: wp * 0.05,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                      _scrollToPackageRoomCard();
                                    });
                                  },
                                  child: Container(
                                    height: hp * 0.15,
                                    width: wp * 0.4,
                                    padding: EdgeInsets.all(3),
                                    margin: EdgeInsets.only(
                                        right: wp * 0.05, top: hp * 0.09),
                                    decoration: BoxDecoration(
                                        color: kPrimaryMaroon,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: wp,
                                          height: hp * 0.09,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(17)),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/room_2.jpg'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(hp * 0.01),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Package',
                                                style: TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: wp * 0.037,
                                                    fontWeight: FontWeight.w600,
                                                    color: kPrimaryWhite),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                width: wp * 0.07,
                                                height: hp * 0.03,
                                                decoration: BoxDecoration(
                                                  color: kPrimaryWhite,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6)),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.arrow_forward,
                                                    color: kPrimaryMaroon,
                                                    size: wp * 0.05,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    BookNow(),
                    SuperiorRoom(),
                    MeetingRoomCard(
                      key: _RegularRoomCardKey,
                    ),
                    PackageRoomCard(
                      key: _packageRoomCardKey,
                    ),
                    OurServices(),
                    OurGallery(),
                    AboutUs(),
                    ContactUs(),
                    Footer()
                  ],
                ),
              ),
              // Top bar
              TopBar()
            ],
          ),
          drawer: Sidebar(),
        ),
      ),
    );
  }
}
