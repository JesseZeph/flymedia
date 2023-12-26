import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/chat_provider.dart';
import 'package:flymedia_app/models/chats/chat_model.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import 'chat_tile.dart';

class MessageSearchDelegate extends SearchDelegate {
  final bool isClientView;

  MessageSearchDelegate({required this.isClientView});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ChatModel> matchQuery = [];
    for (var message in context.read<ChatProvider>().userMessages) {
      var name = isClientView
          ? message.influencerId['firstAndLastName']
          : message.companyOwnerId['fullname'];
      if (name.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(message);
      }
    }
    return matchQuery.isEmpty
        ? const Center(
            child: CustomKarlaText(
              text: 'No chats found',
              weight: FontWeight.bold,
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) => ChatTile(
              isClientView: isClientView,
              model: matchQuery[index],
            ),
            separatorBuilder: (context, index) => Divider(
              color: const Color(0xffF0F2F6),
              height: 10.h,
            ),
            itemCount: matchQuery.length,
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ChatModel> matchQuery = [];
    for (var message in context.read<ChatProvider>().userMessages) {
      var name = isClientView
          ? message.influencerId['firstAndLastName']
          : message.companyOwnerId['fullname'];
      if (name.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(message);
      }
    }
    return matchQuery.isEmpty
        ? const Center(
            child: CustomKarlaText(
              text: 'No chats found',
              weight: FontWeight.bold,
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) => ChatTile(
              isClientView: isClientView,
              model: matchQuery[index],
            ),
            separatorBuilder: (context, index) => Divider(
              color: const Color(0xffF0F2F6),
              height: 10.h,
            ),
            itemCount: matchQuery.length,
          );
  }
}
