import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Urban_block_party/Components/videoPlayer.dart';
import 'package:Urban_block_party/Components/leftItems.dart';
import 'package:Urban_block_party/Components/rightItems.dart';
class Video_Component extends StatefulWidget {
  const Video_Component({Key? key}) : super(key: key);

  @override
  State<Video_Component> createState() => _Video_ComponentState();
}

class _Video_ComponentState extends State<Video_Component> {
  List<String> tikTokVideos = ["https://www.youtube.com/watch?v=DxWZ1CbAdVA&ab_channel=JunaidAkram","https://www.youtube.com/watch?v=DxWZ1CbAdVA&ab_channel=JunaidAkram"];
  void _getdata() async {
    FirebaseFirestore.instance
        .collection('videos')
        .get()
        .then((value) {
      print(value);
      value.docs.forEach((userdata) {
        setState(() {

        });
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
         // TikTokVideoPlayer(url: data.itemInfos!.video!.urls![0]),
          title(),
          // RightItems(
          //   comments: data.itemInfos!.commentCount.toString(),
          //   userImg: data.authorInfos!.covers![0],
          //   favorite: data.itemInfos!.diggCount!,
          //   coverImg: data.musicInfos!.covers![0],
          // ),
          // LeftItems(
          //   description: data.itemInfos!.text!,
          //   musicName: data.musicInfos!.musicName!,
          //   authorName: data.musicInfos!.authorName!,
          //   userName: data.authorInfos!.uniqueId!,
          // )
        ],
      ),
    );
  }
  Widget title() => Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 28.0),
      child: Text(
        "Trending | For You",
        style: TextStyle(color: Colors.white, fontSize: 19.0),
      ),
    ),
  );
}
