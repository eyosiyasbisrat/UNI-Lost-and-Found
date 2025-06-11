import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../models/message.dart';
import '../widgets/message_list_tile.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Message> dummyMessages = [
      Message(name: 'Kevin', email: 'dr@gm1lsweet.hwse', time: '7:05'),
      Message(name: 'Kevin', email: 'dr@gm1lsweet.hwse', time: '7:05'),
      Message(name: 'Kevin', email: 'dr@gm1lsweet.hwse', time: '7:05'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27649A),
        centerTitle: true,
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: dummyMessages.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) => MessageListTile(message: dummyMessages[index]),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 3),
    );
  }
}
