import 'dart:io'; // Import dart:io for Platform

import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/login_provider.dart';
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
        'https://tawk.to/chat/64edcd25b2d3e13950ecb7b6/1hhf0ig3c';

    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: _buildWebView(selectedUrl),
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
        onLoad: () {
          print('Hello Tawk!');
        },
        onLinkTap: (String url) {
          print(url);
        },
        placeholder: const Center(
          child: Text('Loading...'),
        ),
      );
    }
  }
}
