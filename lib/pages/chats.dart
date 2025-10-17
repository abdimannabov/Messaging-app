import 'package:flutter/material.dart';
import 'package:message_app/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/user_tile.dart';

class Chats extends StatelessWidget {
  Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return _builderUserList();
  }

  Widget _builderUserList() {
    final currentUid = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final docs = snapshot.data?.docs ?? [];
        final users = docs
            .map((d) {
              final m = {...d.data(), 'docId': d.id};
              m['isCurrent'] = (m['userID'] == currentUid);
              return m;
            })
            .toList()
            .cast<Map<String, dynamic>>();

        if (users.isEmpty) {
          return const Center(child: Text('No users found'));
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index];
            return _buildUserListItem(userData, context);
          },
        );
      },
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    final email = userData['email'] as String? ?? '';
    final isCurrent = userData['isCurrent'] as bool? ?? false;

    return UserTile(
      text: isCurrent ? '$email (you)' : email,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(receiverEmail: userData['email']),
          ),
        ); // Handle user tap
      },
    );
  }
}
