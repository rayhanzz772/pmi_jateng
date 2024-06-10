// notification_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifications extends NotificationEvent {}

class MarkNotificationAsRead extends NotificationEvent {
  final String notificationId;

  const MarkNotificationAsRead(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}

class ClearNotifications extends NotificationEvent {}

// notification_state.dart
abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<String> notifications; // Example: List of notification messages

  const NotificationLoaded(this.notifications);

  @override
  List<Object> get props => [notifications];
}

class NotificationError extends NotificationState {
  final String error;

  const NotificationError(this.error);

  @override
  List<Object> get props => [error];
}

// notification_bloc.dart

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<MarkNotificationAsRead>(_onMarkNotificationAsRead);
    on<ClearNotifications>(_onClearNotifications);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      // Simulate fetching notifications
      await Future.delayed(Duration(seconds: 2));
      // Example notifications
      List<String> notifications = [
        "Notification 1",
        "Notification 2",
        "Notification 3"
      ];
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError("Failed to load notifications"));
    }
  }

  Future<void> _onMarkNotificationAsRead(
    MarkNotificationAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    // Handle marking a notification as read
    if (state is NotificationLoaded) {
      final notifications = (state as NotificationLoaded).notifications;
      // Example logic: Remove the notification from the list
      notifications.remove(event.notificationId);
      emit(NotificationLoaded(List.from(notifications)));
    }
  }

  Future<void> _onClearNotifications(
    ClearNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    // Clear all notifications
    emit(NotificationLoaded([]));
  }
}
