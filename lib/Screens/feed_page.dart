import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:Urban_block_party/Components/feed_card.dart';
import 'package:video_player/video_player.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(

        child:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("videos").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:  snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];

                    return FeedCard(
                      feed: data['url'],
                      like: data['likes'].toString(),
                      uid: data['uid'].toString(),
                    );
                  });
            } else {
              return Text('Loading Data.....');
            }
          },
        ),


      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
