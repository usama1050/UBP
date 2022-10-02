
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class FeedCard extends StatefulWidget {

  final String feed;
  final String like;
  final String uid;
  FeedCard({required this.feed,required this.like,required this.uid});
  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  late VideoPlayerController _controller;
   int comment_count = 0;
  late Future<void> _initializeVideoPlayerFuture;
  void _getdata() async {
    FirebaseFirestore.instance
        .collection('VideoComments').doc(this.widget.uid).collection("comments")
        .get()
        .then((value) {
      print(value);
      value.docs.forEach((comments) {
        setState(() {
          comment_count = comment_count + 1;
        });
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _getdata();
    _controller = VideoPlayerController.network(widget.feed);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("ASPECT");
    print(_controller.value.aspectRatio);
    return Stack(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GestureDetector(
                onTap: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // CircleAvatar(
                      //   widget.feed.user.headshot,
                      //   radius: 22,
                      //   backgroundColor: Colors.transparent,
                      //   borderColor: Colors.brown,
                      //   elevation: 0,
                      //   cacheImage: true,
                      //   showInitialTextAbovePicture: true,
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                           Icons.favorite,
                            size: 35,
                            color: Colors.red,
                          ),
                          Text(
                            this.widget.like,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_bank_rounded,
                            size: 35,
                            color: Colors.white,
                          ),
                          Text(
                            comment_count.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),

             
            ],
          ),
        )
      ],
    );
  }
}
