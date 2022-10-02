import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class User_type extends StatefulWidget {
  const User_type({Key? key,required this.type}) : super(key: key);
  final String type;
  @override
  State<User_type> createState() => _User_typeState();
}

class _User_typeState extends State<User_type> {

  bool Student = false;
  bool parent = true;
  bool Teacher = true;
  bool Administrator = true;
  String status = "Student";


  @override
  void initState() {
    super.initState();
    setState(() {
      if(widget.type == "Student"){
        Student = true;
        parent = false;
        Teacher = false;
        Administrator = false;
      }else if(widget.type == "Parent"){
        Student = false;
        parent = true;
        Teacher = false;
        Administrator = false;
      }
      else if(widget.type == "Teacher"){
        Student = false;
        parent = false;
        Teacher = true;
        Administrator = false;
      }else if(widget.type == "Administrator"){
        Student = false;
        parent = false;
        Teacher = false;
        Administrator = true;
      }
      else{
        Student = true;
        parent = false;
        Teacher = false;
        Administrator = false;
      }

    });

  }
  void status_student() async {
    setState(() {
      Student = true;
      parent = false;
      Teacher = false;
      Administrator = false;
      status = "Student";

    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.pop(context);


      // Navigator.pushReplacement(
      //   context,MaterialPageRoute(builder: (context) => RegistrationScreen()),);

    prefs.setString('User_status', "Student");

  }
  void  status_parent() async {
    setState(() {
      Student = false;
      parent = true;
      Teacher = false;
      Administrator = false;
      status = "Parent";
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('User_status', "Parent");
    Navigator.pop(context);

      // Navigator.pushReplacement(
      //   context,MaterialPageRoute(builder: (context) => RegistrationScreen()),);

  }
  void  status_teacher() async {
    setState(() {
      Student = false;
      parent = false;
      Teacher = true;
      Administrator = false;
      status = "Teacher";
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('User_status', "Teacher");
    Navigator.pop(context);


      // Navigator.pushReplacement(
      //   context,MaterialPageRoute(builder: (context) => RegistrationScreen()),);


  }
  void  status_admin() async {
    setState(() {
      Student = false;
      parent = false;
      Teacher = false;
      Administrator = true;
      status = "Administrator";
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('User_status', "Administrator");
    Navigator.pop(context);


      // Navigator.pushReplacement(
      //   context,MaterialPageRoute(builder: (context) => RegistrationScreen()),);
      //

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select User Type",style: TextStyle(
          color: Colors.black,
        )),
        backgroundColor: Colors.white,
      ),
        body:Container(
            height: 180,
            margin: EdgeInsets.only(top: 35,left: 25,right: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(7.0),
                  bottomRight: Radius.circular(7.0),
                  topLeft: Radius.circular(7.0),
                  bottomLeft: Radius.circular(7.0)),
                boxShadow:  [new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0, // You can set this blurRadius as per your requirement
                ),]


            ),
            child: Container(

                margin: EdgeInsets.only(left: 8,right: 0),
                padding: EdgeInsets.only(bottom: 15),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    GestureDetector(
                      child: Row(children: [
                        Container(
                          padding: EdgeInsets.only(left: 15,right: 8,top: 15),
                          child: Text(
                            "Student",

                            style: TextStyle(

                              color: Colors.black,
                              fontSize: 13,

                            ),
                          ),),
                        Spacer(),
                        Visibility(
                          child: Container(
                            margin: EdgeInsets.only(right: 15,top: 10),
                            child:   GestureDetector(
                              child: Icon(
                                Icons.done,
                                size: 20,
                                color: Colors.blue,
                              ),
                              onTap: () {
                                status_student();
                              },
                            ),),
                          visible: Student,
                        ),

                      ],),
                      onTap: () {
                        status_student();
                      },
                    ),

                    Container(
                      width : double.infinity,
                      height: 0.1,
                      margin: const EdgeInsets.only(
                        left: 15,
                        top: 12,
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
                    ),

                    GestureDetector(
                      child: Row(children: [
                        Container(
                          padding: EdgeInsets.only(left: 15,right: 8,top: 15),
                          child: Text(
                            "Parent",

                            style: TextStyle(

                              color: Colors.black,
                              fontSize: 13,

                            ),
                          ),),
                        Spacer(),
                        Visibility(
                          child:Container(
                            margin: EdgeInsets.only(right: 15,top: 10),
                            child:   GestureDetector(
                              child: Icon(
                                Icons.done,
                                size: 20,
                                color: Colors.blue,
                              ),
                              onTap: () {
                                status_parent();
                              },
                            ),),
                          visible: parent,
                        ),


                      ],),
                      onTap: () {
                        status_parent();
                      },
                    ),



                    Container(
                      width : double.infinity,
                      height: 0.1,
                      margin: const EdgeInsets.only(
                        left: 15,
                        top: 12,
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
                    ),
                    GestureDetector(
                      child: Row(children: [
                        Container(
                          padding: EdgeInsets.only(left: 15,right: 8,top: 15),
                          child: Text(
                            "Teacher",

                            style: TextStyle(

                              color: Colors.black,
                              fontSize: 13,

                            ),
                          ),),
                        Spacer(),
                        Visibility(
                          child:Container(
                            margin: EdgeInsets.only(right: 15,top: 10),
                            child:   GestureDetector(
                              child: Icon(
                                Icons.done,
                                size: 20,
                                color: Colors.blue,
                              ),
                              onTap: () {
                                status_teacher();
                              },
                            ),),
                          visible: Teacher,
                        ),

                      ],),
                      onTap: () {
                        status_teacher();
                      },
                    ),
                    Container(
                      width : double.infinity,
                      height: 0.1,
                      margin: const EdgeInsets.only(
                        left: 15,
                        top: 12,
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
                    ),
                    GestureDetector(
                      child: Row(children: [
                        Container(
                          padding: EdgeInsets.only(left: 15,right: 8,top: 15),
                          child: Text(
                            "Administrator",

                            style: TextStyle(

                              color: Colors.black,
                              fontSize: 13,

                            ),
                          ),),
                        Spacer(),
                        Visibility(
                          child:Container(
                            margin: EdgeInsets.only(right: 15,top: 10),
                            child:   GestureDetector(
                              child: Icon(
                                Icons.done,
                                size: 20,
                                color: Colors.blue,
                              ),
                              onTap: () {
                                status_admin();
                              },
                            ),),
                          visible: Administrator,
                        ),

                      ],),
                      onTap: () {
                        status_admin();
                      },
                    ),

                  ],)
            )
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
