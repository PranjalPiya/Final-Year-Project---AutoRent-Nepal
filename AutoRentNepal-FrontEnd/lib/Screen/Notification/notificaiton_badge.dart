import 'package:flutter/material.dart';

class Notificationbadge extends StatelessWidget {
  final int totalNotification;
  const Notificationbadge({Key? key, required this.totalNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          "$totalNotification",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
