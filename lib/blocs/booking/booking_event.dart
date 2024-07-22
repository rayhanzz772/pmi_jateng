import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class BookingEvent extends Equatable {
  const BookingEvent();

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
  final int guests;

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

// States
class BookingState extends Equatable {
  final String name;
  final String phone;
  final int guests;
  final DateTime checkInDate;
  final TimeOfDay checkInTime;
  final DateTime checkOutDate;
  final TimeOfDay checkOutTime;

  BookingState({
    this.name = '',
    this.phone = '',
    this.guests = 1,
    DateTime? checkInDate,
    TimeOfDay? checkInTime,
    DateTime? checkOutDate,
    TimeOfDay? checkOutTime,
  })  : this.checkInDate = checkInDate ?? DateTime.now(),
        this.checkInTime = checkInTime ?? TimeOfDay.now(),
        this.checkOutDate = checkOutDate ?? DateTime.now(),
        this.checkOutTime = checkOutTime ?? TimeOfDay.now();

  BookingState copyWith({
    String? name,
    String? phone,
    int? guests,
    DateTime? checkInDate,
    TimeOfDay? checkInTime,
    DateTime? checkOutDate,
    TimeOfDay? checkOutTime,
  }) {
    return BookingState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      guests: guests ?? this.guests,
      checkInDate: checkInDate ?? this.checkInDate,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      checkOutTime: checkOutTime ?? this.checkOutTime,
    );
  }

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

// Bloc
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingState());

  @override
  Stream<BookingState> mapEventToState(BookingEvent event) async* {
    if (event is UpdateName) {
      yield state.copyWith(name: event.name);
    } else if (event is UpdatePhone) {
      yield state.copyWith(phone: event.phone);
    } else if (event is UpdateGuests) {
      yield state.copyWith(guests: event.guests);
    } else if (event is UpdateCheckInDate) {
      yield state.copyWith(checkInDate: event.checkInDate);
    } else if (event is UpdateCheckInTime) {
      yield state.copyWith(checkInTime: event.checkInTime);
    } else if (event is UpdateCheckOutDate) {
      yield state.copyWith(checkOutDate: event.checkOutDate);
    } else if (event is UpdateCheckOutTime) {
      yield state.copyWith(checkOutTime: event.checkOutTime);
    }
  }
}
