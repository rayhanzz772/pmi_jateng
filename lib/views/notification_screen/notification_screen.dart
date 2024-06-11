import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuraga_app/blocs/notification/notification_bloc.dart';
import 'package:nuraga_app/utils/color/constant.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false, // This removes the default back arrow
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle notification icon press if needed
              },
            ),
            SizedBox(width: 8), // Optional spacing
            Text(
              'Notification',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => NotificationBloc()..add(LoadNotifications()),
        child: NotificationView(),
      ),
    );
  }
}

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return CircularProgressIndicator();
              } else if (state is NotificationLoaded) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = state.notifications[index];
                      return ListTile(
                        title: Text(notification),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<NotificationBloc>()
                                .add(MarkNotificationAsRead(notification));
                          },
                        ),
                      );
                    },
                  ),
                );
              } else if (state is NotificationError) {
                return Text(state.error, style: TextStyle(color: Colors.red));
              }
              return Text('No notifications available');
            },
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     context.read<NotificationBloc>().add(ClearNotifications());
          //   },
          //   child: Text('Clear Notifications'),
          // ),
        ],
      ),
    );
  }
}
