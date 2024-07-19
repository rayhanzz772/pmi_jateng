import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Events
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SigninEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final BuildContext context;

  SigninEvent({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password];
}

class GoogleSignInEvent extends AuthenticationEvent {}

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
  final GoogleSignIn _googleSignIn;

  AuthenticationBloc({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        super(InitialState()) {
    on<SigninEvent>(_onSignInEvent);
    on<GoogleSignInEvent>(
        _onGoogleSignInEvent); // Register the GoogleSignInEvent handler
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
    } catch (e) {
      emit(ErrorState(message: 'Akun tidak ditemukan'));
    }
  }

  Future<void> _onGoogleSignInEvent(
      GoogleSignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(ErrorState(message: 'Google Sign-In aborted'));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      emit(SignedInState());
    } catch (e) {
      emit(ErrorState(message: 'Sign in with Google failed'));
    }
  }
}
