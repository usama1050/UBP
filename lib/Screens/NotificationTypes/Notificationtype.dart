import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class Notification_types extends StatefulWidget {
  const Notification_types({Key? key,required this.type}) : super(key: key);
  final String type;
  @override
  State<Notification_types> createState() => _Notification_typesState();
}
class _Notification_typesState extends State<Notification_types> {
  bool _frequently = false;
  bool _less_frequently = true;
  bool _never = true;
  String status = "Frequently";
  @override
  void initState() {
    super.initState();
    setState(() {
      if(widget.type == "Frequently"){
        _frequently = true;
        _less_frequently = false;
        _never = false;
      }else if(widget.type == "Less Frequently"){
        _frequently = false;
        _less_frequently = true;
        _never = false;
      }
      else if(widget.type == "never"){
        _frequently = false;
        _less_frequently = false;
        _never = true;
      }else{
        _frequently = true;
        _less_frequently = false;
        _never = false;
      }

    });

  }
  void status_never() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('notification_status', "never");
    setState(() {
      _frequently = false;
      _less_frequently = false;
      _never = true;
      status = "never";
    });
    Navigator.pop(context);

  }
  void  status_lessfreq() async {
    setState(() {
      _frequently = false;
      _less_frequently = true;
      _never = false;
      status = "Less Frequently";
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notification_status', "Less Frequently");
    Navigator.pop(context);
  }
  void  status_freq() async {
    setState(() {
      _frequently = true;
      _less_frequently = false;
      _never = false;
      status = "Frequently";
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notification_status', "Frequently");
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select Notification Type",style: TextStyle(
          color: Colors.black,
        )),
        backgroundColor: Colors.white,
      ),
      body:Container(
        height: 130,
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
                    "Frequently",

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
                        status_freq();
                      },
                    ),),
                  visible: _frequently,
                ),

              ],),
              onTap: () {
                status_freq();
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
                    "Less Frequently",

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
                        status_lessfreq();
                      },
                    ),),
                  visible: _less_frequently,
                ),


              ],),
              onTap: () {
                status_lessfreq();
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
                    "Never",
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
                        status_never();
                      },
                    ),),
                  visible: _never,
                ),

              ],),
              onTap: () {
                status_never();
              },
            ),

          ],)
    )
      ),
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
