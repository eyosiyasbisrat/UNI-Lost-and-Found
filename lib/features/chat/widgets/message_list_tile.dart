import 'package:flutter/material.dart';
import '../models/message.dart';

class MessageListTile extends StatelessWidget {
  final Message message;

  const MessageListTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/image3.png'), // Placeholder image
        radius: 22,
      ),
      title: Text(
        message.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(message.email),
      trailing: Text(message.time),
      onTap: () {
        // TODO: Navigate to conversation screen
      },
    );
  }
}
