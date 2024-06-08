import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuraga_app/blocs/authentication_bloc.dart';
import 'package:nuraga_app/constant.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: Scaffold(
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ErrorState) {
              return Center(child: Text(state.message));
            } else {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Daftar,",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor)),
                    Text("Mohon masukan data anda terlebih dahulu")
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
