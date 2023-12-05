import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/login_provider.dart';
import '../../../utils/modal.dart';

class ClientHelp extends StatelessWidget {
  const ClientHelp({super.key});

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);

    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : Scaffold(
            body: Center(
              child: Text('Help'),
            ),
          );
  }
}
