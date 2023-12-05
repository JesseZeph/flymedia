import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/login_provider.dart';
import '../../../utils/modal.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);

    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text('Messages'),
                ],
              ),
            ),
          );
  }
}
