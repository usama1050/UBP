import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GetHelp extends StatefulWidget {
  const GetHelp({Key? key}) : super(key: key);
  @override
  State<GetHelp> createState() => _GetHelpState();
}

class _GetHelpState extends State<GetHelp> {
  String info = "";
  @override
  void initState() {

    get_data();
  }

  get_data() async {

    FirebaseFirestore.instance
        .collection('GetHelpInfo')
        .get()
        .then((value) {
      print(value);
      value.docs.forEach((helpdata) {
        setState(() {

        info = helpdata['info'];
        //
        //
        });
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [

            Container(

              width : double.infinity,

              margin: const EdgeInsets.only(
                left: 20,
                top: 10,
                right: 20,
                bottom: 0,
              ),
              child: Text(info, style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17,color: Colors.grey), textAlign: TextAlign.left),

            ),
            Container(
              color: Colors.white,
              child:StreamBuilder(
                stream: FirebaseFirestore.instance.collection("GetHelp").snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemExtent: 420.0,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          return Container(

                            width : double.infinity,
                            margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
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
                              InkWell(
                                child: Container(
                                    color: Colors.blue,
                                    width : double.infinity,
height: 200,
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
                                      ),
                                      child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/images/ubpx-app-logo-200-clr.png',
                                          image:data['coverImage']
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
                              ),
                              Row(children: [

                                Container(
margin: EdgeInsets.only(left: 10),
                                  width : 60,
                                  height: 60,



                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/images/ubpx-app-logo-200-clr.png',
                                            image:data['mainImage']
                                            ,fit: BoxFit.fill,
                                            imageErrorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/images/ubpx-app-logo-200-clr.png',

                                              );
                                            },
                                          )







//videoKey

                                ),
                                Expanded(flex:1,child:  Container(

                                  width : double.infinity,


                                  child: Text(data['title'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black), textAlign: TextAlign.left),

                                ),),
                                Expanded(child:  SizedBox(
                                  width: double.infinity,

                                  child:Container(

                                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                      child: ElevatedButton(

                                        style: ElevatedButton.styleFrom(
                                            primary: parseColor("#e5e5e5"), // background
                                            onPrimary: Colors.white,
                                            shape: StadiumBorder()
                                          // foreground
                                        ),
                                        child: const Text('Get Help',style:TextStyle(color: Colors.blue),),
                                        onPressed: () async {
                                          final Uri _url = Uri.parse(data['url']);
                                          if (!await launchUrl(_url)) {
                                          throw 'Could not launch $_url';
                                          }

                                          //comment__#f9097d
                                          //signIn(emailController.text, passwordController.text);
                                        },
                                      )
                                  ),
                                ),)

                              ],),



                              Container(
                                width : double.infinity,
                                margin: const EdgeInsets.only(
                                  left: 35,
                                  top: 10,
                                  right: 15,
                                  bottom: 10,
                                ),
                                child: Text(data['details'],   maxLines: 5,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.grey), textAlign: TextAlign.left),

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
          ],
        ),
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
