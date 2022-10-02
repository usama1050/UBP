import 'package:Urban_block_party/Screens/Artisit_Detail/Artisit_Detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Artist_Component extends StatefulWidget {
  const Artist_Component({Key? key}) : super(key: key);

  @override
  State<Artist_Component> createState() => _Artist_ComponentState();
}

class _Artist_ComponentState extends State<Artist_Component> {
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
                    stream: FirebaseFirestore.instance.collection("artists").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return  GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 256,
                                mainAxisSpacing: 0
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
                                        child:  Image.network(data['imageUrl'],fit: BoxFit.fill),
                                      )



//videoKey
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Artisit_Detail(detail: data['description'],imageList:data['imageUrl'],title: data['name'],subtitle: data['subtitle'],),
                                        ));
                                  },
                                ),
                                ),
                                  Expanded(flex:1,child:      Container(

                                    width : double.infinity,

                                    margin: const EdgeInsets.only(
                                      left: 0,
                                      top: 5,
                                      right: 7,
                                      bottom: 10,
                                    ),
                                    child: Text(data['name'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,color: Colors.black), textAlign: TextAlign.left),

                                  ),)

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
