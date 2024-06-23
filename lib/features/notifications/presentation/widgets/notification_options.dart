import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/notifications_notifier.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/features/notifications/presentation/cubit/notification_cubit.dart';

class NotificationOptions extends StatelessWidget {
  const NotificationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsNotifier>(
      builder: (_, notifier, __) {
        return PopupMenuButton(
          offset: const Offset(0, 50),
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<void>(
              onTap: notifier.toggleMuteNotifications,
              child: PopupItem(
                title: notifier.muteNotifications ? 'Un-mute Notifications' : 'Mute Notifications',
                icon: Icon(
                  notifier.muteNotifications ? Icons.notifications_off_outlined : Icons.notifications_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: context.read<NotificationCubit>().clearAll,
              child: const PopupItem(
                title: 'Clear All',
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
