import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Events
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SigninEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final BuildContext context; // Add context

  SigninEvent(
      {required this.email, required this.password, required this.context});

  @override
  List<Object> get props => [email, password];
}

// States
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class InitialState extends AuthenticationState {}

class LoadingState extends AuthenticationState {}

class SignedInState extends AuthenticationState {}

class ErrorState extends AuthenticationState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

// BLoC
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _firebaseAuth;

  AuthenticationBloc({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(InitialState()) {
    on<SigninEvent>(_onSignInEvent);
  }

  Future<void> _onSignInEvent(
      SigninEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SignedInState());
      Navigator.pushReplacementNamed(
          event.context, '/home'); // Navigate to HomeScreen
    } catch (e) {
      emit(ErrorState(message: 'Akun tidak ditemukan'));
    }
  }
}
