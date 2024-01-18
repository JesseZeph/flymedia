import 'dart:io'; // Import dart:io for Platform

import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../providers/login_provider.dart';
import '../../../utils/modal.dart';

class ClientHelp extends StatefulWidget {
  const ClientHelp({super.key});

  @override
  State<ClientHelp> createState() => _ClientHelpState();
}

class _ClientHelpState extends State<ClientHelp> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    const String selectedUrl =
        'https://tawk.to/chat/659fbf338d261e1b5f51dc71/1hjs05p1h';

    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : SafeArea(
            top: true,
            child: Scaffold(
              body: Center(
                child: _buildWebView(selectedUrl),
              ),
            ),
          );
  }

  Widget _buildWebView(String url) {
    var name = context.watch<LoginNotifier>().fullName;
    var email = context.watch<LoginNotifier>().email;

    if (Platform.isIOS) {
      return WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      );
    } else {
      return Tawk(
        directChatLink: url,
        visitor: TawkVisitor(
          name: '${name.split(' ').first},',
          email: email,
        ),
        onLoad: () {},
        onLinkTap: (String url) {},
        placeholder: const Center(
          child: Text('Loading...'),
        ),
      );
    }
  }
}
