import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});

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
  AuthenticationBloc() : super(InitialState());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield LoadingState();

      try {
        // Replace this with your actual sign-in logic
        await Future.delayed(Duration(seconds: 2));
        yield SignedInState();
      } catch (e) {
        yield ErrorState(message: 'Sign-in failed');
      }
    }
  }
}
