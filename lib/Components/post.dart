import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post_Component extends StatefulWidget {
  const Post_Component({Key? key}) : super(key: key);

  @override
  State<Post_Component> createState() => _Post_ComponentState();
}

class _Post_ComponentState extends State<Post_Component> {
  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset : false,

        body:SingleChildScrollView(
          physics: ScrollPhysics(),

          child: Column(

              children: <Widget>[

                Container(
                  color: Colors.white,
                  child:StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemExtent: 280.0,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data = snapshot.data!.docs[index];
                              DateTime date = (data['time'] as Timestamp).toDate();

                              return Container(
                                width : double.infinity,
                                margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                                decoration: BoxDecoration(
                                    color: parseColor("#eeeeee"),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(7.0),
                                        bottomRight: Radius.circular(7.0),
                                        topLeft: Radius.circular(7.0),
                                        bottomLeft: Radius.circular(7.0)),
                                    boxShadow:  [new BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 3.0, // You can set this blurRadius as per your requirement
                                    ),]
                                ),
                                child: Column( children: [
                                  Row(children: [


                                    Container(

                                      margin: EdgeInsets.only(left: 10,top: 10),
                                      width: 60,
                                      height: 60,
                                      child:  ClipOval(

                                        child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/images/ubpx-app-logo-200-clr.png',
                                          image:data['url']
                                          ,fit: BoxFit.fill,
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/ubpx-app-logo-200-clr.png',

                                            );
                                          },
                                        )
                                        // child: Image.file( File(  imageFile!.path,),width: 120,
                                        //   height: 120,
                                        //   fit: BoxFit.fill,),
                                      ),
                                    ),
                                    Expanded(flex:1,child:  Container(
                                      margin: EdgeInsets.only(left: 10,top: 10),
                                      width : double.infinity,


                                      child: Text(data['title'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black), textAlign: TextAlign.left),

                                    ),),
                                  ],),

                                  Expanded(flex:5,child:  InkWell(
                                    child: Container(

                                        width : double.infinity,

                                        margin: const EdgeInsets.all(10),

                                        child:ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(7.0),

                                            topLeft: Radius.circular(7.0),
                                            bottomRight: Radius.circular(7.0),
                                            bottomLeft: Radius.circular(7.0),
                                          ),
                                            child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/images/ubpx-app-logo-200-clr.png',
                                              image:data['url']
                                              ,fit: BoxFit.fill,
                                              imageErrorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/ubpx-app-logo-200-clr.png',
                                                );
                                              },
                                            )
                                        )



//videoKey
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => Video_component(video: data['downloadUrl'],video_key:data['videoKey'].replaceAll(".mp4", "")),
                                      //     ));
                                    },
                                  ),),


                                Align(
                                    alignment: Alignment.topRight,
                                child: Container(



                                  margin: const EdgeInsets.only(
                                    left: 0,
                                    top: 5,
                                    right: 15,
                                    bottom: 10,
                                  ),
                                  child: Text(DateFormat('hh:mm a').format(date)   ,   maxLines: 5,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),

                                ),

                                )





                                ]),
                              );
                            });
                      } else {
                        return Text('Loading Data.....');
                      }
                    },
                  ),
                ),

              ]),

        )
    );
  }
  Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex = '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }
}
