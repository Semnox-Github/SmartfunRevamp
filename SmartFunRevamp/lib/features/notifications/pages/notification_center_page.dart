import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/notifications/provider/notifications_provider.dart';

class NotificationCenterPage extends StatelessWidget {
  const NotificationCenterPage({super.key});
  String _getDate(DateTime date) {
    final dateAsString = date.formatDate('MM-dd-yyyy');
    final today = DateTime.now();
    if (today.formatDate('MM-dd-yyyy') == dateAsString) {
      return 'Today';
    } else if (today.subtract(const Duration(days: 1)).formatDate('MM-dd-yyyy') == dateAsString) {
      return 'Yesterday';
    } else {
      return dateAsString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: CustomColors.customBlue),
        backgroundColor: CustomColors.customLigthBlue,
        title: const MulishText(
          text: 'Notification',
          fontWeight: FontWeight.bold,
          fontColor: CustomColors.customBlue,
        ),
        centerTitle: false,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () => ref.read(NotificationsProvider.notificationsStateProvider.notifier).removeAll(),
                icon: const Icon(
                  Icons.delete,
                ),
              );
            },
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kNotificationsSettings),
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(NotificationsProvider.notificationsStateProvider).maybeWhen(
                  orElse: () => Container(),
                  error: (_) => const Center(
                    child: MulishText(
                      text: "We couldn't retrieve your notifications",
                    ),
                  ),
                  inProgress: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  success: (data) {
                    if (data.isEmpty) {
                      return const Center(
                        child: MulishText(
                          text: "You don't have any notifications",
                          fontSize: 30.0,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: data.keys.length,
                      itemBuilder: (context, index) {
                        final date = data.keys.elementAt(index);
                        final notifications = data[date];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                MulishText(text: _getDate(date)),
                                const Expanded(
                                  child: Divider(
                                    thickness: 1.5,
                                    color: CustomColors.customLigthGray,
                                    indent: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                              itemCount: notifications!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final notification = notifications[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                                  child: Dismissible(
                                    key: UniqueKey(),
                                    background: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.delete_outline,
                                              color: CustomColors.hardOrange,
                                            ),
                                            MulishText(
                                              text: 'Remove',
                                              fontColor: CustomColors.hardOrange,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (_) {
                                      ref.read(NotificationsProvider.notificationsStateProvider.notifier).removeNotification(notification);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                        color: notification.isUnread ? CustomColors.customOrange : CustomColors.customLigthGray,
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            size: 40.0,
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    MulishText(
                                                      text: notification.subject,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    MulishText(
                                                      text: notification.sendDate.formatDate('HH:mm a'),
                                                      fontSize: 12,
                                                      fontColor: CustomColors.couponTextColor,
                                                    ),
                                                  ],
                                                ),
                                                MulishText(
                                                  text: notification.body,
                                                  fontSize: 12,
                                                  fontColor: CustomColors.couponTextColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
