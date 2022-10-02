import 'package:Urban_block_party/Screens/HomeTiles_Detail/HomeTiles_Detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Home_Component extends StatefulWidget {
  const Home_Component({Key? key}) : super(key: key);

  @override
  State<Home_Component> createState() => _Home_ComponentState();
}

class _Home_ComponentState extends State<Home_Component> {
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
                    stream: FirebaseFirestore.instance.collection("hometiles").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemExtent: 380.0,
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
                                  Expanded(flex:5,child:  InkWell(
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
                                          ),
                                        child:  Image.network(data['imageUrl'],fit: BoxFit.fill,),
                                      )


                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeTiles_Detail(detail: data['details'],imageList:data['images'],title: data['title'],),
                                          ));
                                    },
                                  ),),

                                  Container(

                                    width : double.infinity,

                                    margin: const EdgeInsets.only(
                                      left: 25,
                                      top: 10,
                                      right: 7,
                                      bottom: 0,
                                    ),
                                    child: Text(data['title'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black), textAlign: TextAlign.left),

                                  ),
                                  Container(
                                    width : double.infinity,

                                    margin: const EdgeInsets.only(
                                      left: 25,
                                      top: 5,
                                      right: 7,
                                      bottom: 10,
                                    ),
                                    child: Text(data['subtitle'],   maxLines: 5,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.grey), textAlign: TextAlign.left),

                                  ),
                                Align(
                                    alignment: Alignment.topLeft,
                                child:     Container(

                                    margin: const EdgeInsets.fromLTRB(25, 0, 10, 10),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: parseColor("#f9097d"), // background
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18), // <-- Radius
                                        ),// foreground
                                      ),

                                      child: const Text('Learn More'),
                                      onPressed: () {

                                      },
                                    )
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
