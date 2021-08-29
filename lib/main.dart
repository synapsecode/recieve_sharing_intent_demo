import 'package:flutter/material.dart';
import 'package:shareintent_app/share_intent_builder.dart';

void main() {
  runApp(ShareIntentApp());
}

class NormalHomePage extends StatelessWidget {
  const NormalHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Normal Homepage"),
      ),
    );
  }
}

class URLPage extends StatelessWidget {
  final String url;
  const URLPage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RecievedURL"),
      ),
      body: Center(
        child: Text(url),
      ),
    );
  }
}

class ShareIntentApp extends StatelessWidget {
  const ShareIntentApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShareIntentBuilder(
        home: NormalHomePage(),
        onRecievedURL: (url) => URLPage(url: url),
        onWaiting: () {
          return Scaffold(
            body: Center(child: Text("WAITING")),
          );
        },
      ),
    );
  }
}
