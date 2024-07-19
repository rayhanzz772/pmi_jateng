import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmi_jateng/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/sign_in/sign_in.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: Scaffold(
        backgroundColor: kPrimaryWhite,
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ErrorState) {
              return Center(child: Text(state.message));
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.only(left: 20),
                          icon: Icon(
                            Icons.arrow_back,
                            color: kPrimaryColor,
                            size: 24,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                            width:
                                10), // Add some spacing between the icon and the image
                        Image.asset(
                          'assets/images/logo_PMI.png',
                          height: 40, // Specify the height of the image
                        ),
                      ],
                    ),
                    Container(
                      color: kPrimaryWhite,
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 22),
                                Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: usernameController,
                                        decoration: InputDecoration(
                                          labelText: 'Username',
                                          labelStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      TextField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      TextField(
                                        controller: passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      TextField(
                                        controller: confirmpasswordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          labelStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          String email = emailController.text;
                                          String username =
                                              usernameController.text;
                                          String confirmpassword =
                                              confirmpasswordController.text;
                                          String password =
                                              passwordController.text;
                                          // BlocProvider.of<AuthenticationBloc>(
                                          //   context,
                                          // ).add(SigninEvent(
                                          //     email: email,
                                          //     password: password));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          minimumSize:
                                              Size(double.infinity, 48),
                                          backgroundColor: kPrimaryColor,
                                        ),
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text("or sign up with"),
                                      SizedBox(height: 16.0),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignInScreen(),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromHeight(45),
                                                alignment: Alignment.centerLeft,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                side: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 152, 152, 152),
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Container(
                                                child: Image.asset(
                                                  'assets/images/google.png',
                                                  width: 35,
                                                  height: 35,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Your onPressed logic here
                                              },
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromHeight(45),
                                                alignment: Alignment.centerLeft,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                side: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 152, 152, 152),
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Container(
                                                child: Image.asset(
                                                  'assets/images/x.png',
                                                  width: 27,
                                                  height: 27,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Your onPressed logic here
                                              },
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromHeight(45),
                                                alignment: Alignment.centerLeft,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                side: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 152, 152, 152),
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Container(
                                                child: Image.asset(
                                                  'assets/images/facebook.png',
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 34),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
