import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terrescience/utils/Constant.dart';
import 'package:terrescience/web_view.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.

    _controller = VideoPlayerController.asset(
        "video/Video.mp4"); /*network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );*/

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  void _showAlertTrailerSwich() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            AppString.APPNAME,
            style: TextStyle(
                fontFamily: 'MontserratMedium',
                color: Colors.black,
                fontSize: 18,
                decoration: TextDecoration.none),
          ),
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              AppString.SKIPVIDEO,
              style: TextStyle(
                  fontFamily: 'MontserratRegular',
                  color: Colors.black,
                  fontSize: 15,
                  decoration: TextDecoration.none),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                AppString.DONTSHOW,
                style: TextStyle(
                    fontFamily: 'MontserratMedium',
                    color: Colors.black,
                    fontSize: 15,
                    decoration: TextDecoration.none),
              ),
              onPressed: () {
                skipVideo(true);
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                AppString.SHOWAGAIN,
                style: TextStyle(
                    fontFamily: 'MontserratMedium',
                    color: Colors.black,
                    fontSize: 15,
                    decoration: TextDecoration.none),
              ),
              onPressed: () {
                skipVideo(false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> skipVideo(bool videoShow) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (videoShow == true) {
      prefs.setString(Constants.IS_VIDEO_SHOW, "1");
    }else{
      prefs.setString(Constants.IS_VIDEO_SHOW, "0");
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => MyWebView(
        title: "TerreScience",
        selectedUrl: "https://terrescience.com",
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _controller.play();
    print(_controller.value.isPlaying);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //title: Text("Breeds of Dogs"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                child: Text("SKIP", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  /*Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => MyWebView(
                      title: "TerreScience",
                      selectedUrl: "https://terrescience.com",
                    ),
                  ));*/
                  //Navigator.of(context).pop();
                  _showAlertTrailerSwich();
                }),
          ),
          /*IconButton(
              icon: Icon(
                Icons.skip_next_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => MyWebView(
                    title: "TerreScience",
                    selectedUrl: "https://terrescience.com",
                  ),
                ));
              }),*/
        ],
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),*/
    );
  }
}
