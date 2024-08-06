import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pmi_jateng/service/api_service.dart';

// Events
abstract class BookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateName extends BookingEvent {
  final String name;

  UpdateName(this.name);

  @override
  List<Object> get props => [name];
}

class UpdatePhone extends BookingEvent {
  final String phone;

  UpdatePhone(this.phone);

  @override
  List<Object> get props => [phone];
}

class UpdateGuests extends BookingEvent {
  final String guests;

  UpdateGuests(this.guests);

  @override
  List<Object> get props => [guests];
}

class UpdateCheckInDate extends BookingEvent {
  final DateTime checkInDate;

  UpdateCheckInDate(this.checkInDate);

  @override
  List<Object> get props => [checkInDate];
}

class UpdateCheckInTime extends BookingEvent {
  final TimeOfDay checkInTime;

  UpdateCheckInTime(this.checkInTime);

  @override
  List<Object> get props => [checkInTime];
}

class UpdateCheckOutDate extends BookingEvent {
  final DateTime checkOutDate;

  UpdateCheckOutDate(this.checkOutDate);

  @override
  List<Object> get props => [checkOutDate];
}

class UpdateCheckOutTime extends BookingEvent {
  final TimeOfDay checkOutTime;

  UpdateCheckOutTime(this.checkOutTime);

  @override
  List<Object> get props => [checkOutTime];
}

class SubmitBooking extends BookingEvent {
  final String name;
  final String phone;
  final String guests;
  final DateTime checkInDate;
  final TimeOfDay checkInTime;
  final DateTime checkOutDate;
  final TimeOfDay checkOutTime;

  SubmitBooking({
    required this.name,
    required this.phone,
    required this.guests,
    required this.checkInDate,
    required this.checkInTime,
    required this.checkOutDate,
    required this.checkOutTime,
  });

  @override
  List<Object> get props => [
        name,
        phone,
        guests,
        checkInDate,
        checkInTime,
        checkOutDate,
        checkOutTime,
      ];
}

// States
enum BookingStatus { initial, submitting, success, failure }

class BookingState extends Equatable {
  final String name;
  final String phone;
  final String guests;
  final DateTime checkInDate;
  final TimeOfDay checkInTime;
  final DateTime checkOutDate;
  final TimeOfDay checkOutTime;
  final BookingStatus status;
  final String errorMessage;

  BookingState({
    this.name = '',
    this.phone = '',
    this.guests = "1",
    DateTime? checkInDate,
    TimeOfDay? checkInTime,
    DateTime? checkOutDate,
    TimeOfDay? checkOutTime,
    this.status = BookingStatus.initial,
    this.errorMessage = '',
  })  : checkInDate = checkInDate ?? DateTime.now(),
        checkInTime = checkInTime ?? TimeOfDay.now(),
        checkOutDate = checkOutDate ?? DateTime.now(),
        checkOutTime = checkOutTime ?? TimeOfDay.now();

  BookingState copyWith({
    String? name,
    String? phone,
    String? guests,
    DateTime? checkInDate,
    TimeOfDay? checkInTime,
    DateTime? checkOutDate,
    TimeOfDay? checkOutTime,
    BookingStatus? status,
    String? errorMessage,
  }) {
    return BookingState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      guests: this.guests,
      checkInDate: checkInDate ?? this.checkInDate,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        guests,
        checkInDate,
        checkInTime,
        checkOutDate,
        checkOutTime,
        status,
        errorMessage
      ];
}

// Bloc
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final ApiService apiService;

  BookingBloc({required this.apiService}) : super(BookingState()) {
    on<UpdateName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<UpdatePhone>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<UpdateGuests>((event, emit) {
      emit(state.copyWith(guests: event.guests));
    });
    on<UpdateCheckInDate>((event, emit) {
      emit(state.copyWith(checkInDate: event.checkInDate));
    });
    on<UpdateCheckInTime>((event, emit) {
      emit(state.copyWith(checkInTime: event.checkInTime));
    });
    on<UpdateCheckOutDate>((event, emit) {
      emit(state.copyWith(checkOutDate: event.checkOutDate));
    });
    on<UpdateCheckOutTime>((event, emit) {
      emit(state.copyWith(checkOutTime: event.checkOutTime));
    });
    on<SubmitBooking>((event, emit) async {
      emit(state.copyWith(status: BookingStatus.submitting));
    });
  }
}
