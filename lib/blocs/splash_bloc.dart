import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

// Events
abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends SplashEvent {}

// States
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {}

// BLoC
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    await Future.delayed(Duration(seconds: 7));
    emit(SplashLoaded());
  }
}
