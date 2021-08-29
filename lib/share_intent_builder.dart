import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ShareIntentBuilder extends StatelessWidget {
  @required
  final Widget Function(String) onRecievedURL;
  @required
  final Widget home;
  final Widget Function() onWaiting;
  const ShareIntentBuilder(
      {Key key, this.onRecievedURL, this.home, this.onWaiting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MemoryShareIntent: <When App is in Memory>
    return StreamBuilder<String>(
      initialData: null,
      stream: ReceiveSharingIntent.getTextStream(),
      builder: (context, streamsnap) {
        if (streamsnap.data == null) {
          // InitShareIntent: <When App is closed>
          return FutureBuilder<String>(
            future: ReceiveSharingIntent.getInitialText(),
            builder: (context, futuresnap) {
              if (futuresnap.connectionState == ConnectionState.done) {
                // Regular Flow
                if (futuresnap.data == null) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: home,
                  );
                }
                print(
                  "ShareIntentBuilder[INIT_TEXT] URL -> ${futuresnap.data}",
                );
                return onRecievedURL(futuresnap.data);
              } else {
                print("ShareIntentBuilder::Waiting");
                return onWaiting != null ? onWaiting() : Container();
              }
            },
          );
        } else {
          print(
            "ShareIntentBuilder[TEXT_STREAM] URL -> ${streamsnap.data}",
          );
          return onRecievedURL(streamsnap.data);
        }
      },
    );
  }
}
