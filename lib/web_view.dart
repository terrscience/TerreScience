import 'package:flutter/material.dart';
import 'package:terrescience/video_show.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String selectedUrl;
  final String title;

  MyWebView(
      {this.selectedUrl,
      this.title,
      });
  @override
  MyWebViewPageState createState() => MyWebViewPageState();
}

class MyWebViewPageState extends State<MyWebView> {
  //final String selectedUrl;
  //final String title;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  //MyWebView({@required this.selectedUrl, @required this.title});
  //bool isLoading = true;
  num _stackToView = 1;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(widget.title)),
          backgroundColor: Colors.black,
        ),
        body: IndexedStack(
          index: _stackToView,
          children: <Widget>[
            new WebView(
              initialUrl: widget.selectedUrl,
              javascriptMode: JavascriptMode.unrestricted,
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (finish) {
                print("onPageFinished");
                setState(() {
                  _stackToView = 0;
                });
              },
            ),
            Center(child: CircularProgressIndicator())
          ],
        ),
      );
    });
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
