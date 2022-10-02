import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Gallery_Component extends StatefulWidget {
  const Gallery_Component({Key? key}) : super(key: key);

  @override
  State<Gallery_Component> createState() => _Gallery_ComponentState();
}

class _Gallery_ComponentState extends State<Gallery_Component> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset : false,

        body:SingleChildScrollView(
          physics: ScrollPhysics(),

          child: Column(

              children: <Widget>[

                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 10,right: 15,top: 0),

                  child:StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Gallery").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return  GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 256,
                                mainAxisSpacing: 8
                            ),
                            itemBuilder: (context, index) {
                              DocumentSnapshot data = snapshot.data!.docs[index];
                              return Container(
                                width : double.infinity,

                                margin: EdgeInsets.only(left: 0,right: 0,top: 0,bottom: 0),

                                child: Column( children: [
                                  Expanded(flex:4,child:  InkWell(
                                    child: Container(

                                        width : double.infinity,

                                        margin: const EdgeInsets.only(
                                          left: 0,
                                          top: 0,
                                          right: 0,
                                          bottom: 0,
                                        ),

                                        child:ClipRRect(

                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(7.0),

                                              topLeft: Radius.circular(7.0),
                                              bottomRight: Radius.circular(7.0),
                                              bottomLeft: Radius.circular(7.0)
                                          ),
                                          child:  Image.network(data['url'],fit: BoxFit.fill),
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
                                  ),
                                  ),

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
}
