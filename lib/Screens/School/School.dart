import 'package:flutter/material.dart';

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Schools extends StatefulWidget {
  const Schools({Key? key,required this.type}) : super(key: key);
  final String type;
  @override
  State<Schools> createState() => _SchoolsState();
}

class _SchoolsState extends State<Schools> {
  String status = "Student";
  bool school = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,   //new line
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select School",style: TextStyle(
          color: Colors.white,
        )),
        backgroundColor: Colors.black,
      ),
      body:Container(
         margin: EdgeInsets.only(left: 25,right: 25),
          decoration: BoxDecoration(
            color: parseColor("#1c1c1e"),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(7.0),
                bottomRight: Radius.circular(7.0),
                topLeft: Radius.circular(7.0),
                bottomLeft: Radius.circular(7.0)),
          ),
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("schoolList").snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];

                          return Container(

                              margin: EdgeInsets.only(top: 0,left: 5,right: 0),
                              color: parseColor("#1c1c1e"),

                              child:

                              Column(children: [  Container(
                                margin: EdgeInsets.only(left: 8,right: 0),
                                padding: EdgeInsets.only(bottom: 15),
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  child: Row(children: [

                                    Expanded(flex:6,child:   Container(
                                      padding: EdgeInsets.only(left: 5,right: 5,top: 15),
                                      child: Text(
                                        data['schoolName'],

                                        style: TextStyle(

                                          color: Colors.white,
                                          fontSize: 11,

                                        ),
                                      ),),),
                                    this.widget.type == data['schoolName'] ?  Expanded(
                                      child: Visibility( visible: true,child: Container(
                                        margin: EdgeInsets.only(right: 0,top: 10),
                                        child:   GestureDetector(
                                          child: Icon(
                                            Icons.done,
                                            size: 20,
                                            color: Colors.blue,
                                          ),
                                          onTap: () {
                                            status_School(data['schoolName']);
                                          },
                                        ),),)



                                    )


                                    :  Expanded(
                                        child: Visibility( visible: false,child: Container(
                                          margin: EdgeInsets.only(right: 0,top: 10),
                                          child:   GestureDetector(
                                            child: Icon(
                                              Icons.done,
                                              size: 20,
                                              color: Colors.blue,
                                            ),
                                            onTap: () {
                                              status_School(data['schoolName']);
                                            },
                                          ),),)
                                    )





                                  ],),
                                  onTap: () {
                                    status_School(data['schoolName']);
                                  },
                                ),
                              ),  Container(
                                width : double.infinity,
                                height: 0.1,
                                margin: const EdgeInsets.only(
                                  left: 15,
                                  top: 5,
                                  right: 0,
                                  bottom: 0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(7.0),
                                      bottomRight: Radius.circular(7.0),
                                      topLeft: Radius.circular(7.0),
                                      bottomLeft: Radius.circular(7.0)),
                                ),
                              ),],),


                          );


                        });
                  } else {
                    return Text('Loading Data.....');
                  }
                },
              ),




            ],
          )





      ),
    );
  }
  void  status_School(String schoolname) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('School_status', schoolname);
    Navigator.pop(context);
    // Navigator.pushReplacement(
    //   context,MaterialPageRoute(builder: (context) => RegistrationScreen()),);


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
