import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuraga_app/blocs/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(AppStarted()),
      child: Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashLoaded) {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          },
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              if (state is SplashLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(child: Text('Welcome to My App'));
            },
          ),
        ),
      ),
    );
  }
}
