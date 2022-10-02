import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Urban_block_party/Components/CustomDropdownButton2.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
class contactus_component extends StatefulWidget {
  const contactus_component({Key? key}) : super(key: key);
  @override
  State<contactus_component> createState() => _contactus_componentState();
}
class _contactus_componentState extends State<contactus_component> {
  String? selectedValue;
  var items = [
    'Bringing An ODAEP Program To My School',
    'Hiring ODAEP to produce a Custom Virtual Experience',
    'Partnership Opportunities',
    'Leaving Feedback',
    'Feature Request',
    'Other'
  ];
  // CollectionReference users = FirebaseFirestore.instance.collection('Feedback');
  // Future<void> addFeedback(String  description,String title,String userID ) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   return users
  //       .add({
  //     'createdAt': DateTime.now(), // John Doe
  //     'description':description, // Stokes and Sons
  //     'id':"id", // Stokes and Sons
  //     'title': title,
  //     'userID': prefs.getString("uid"),
  //   }).then((value) {
  //     return users
  //         .doc(value.id)
  //         .update({'id': value.id});
  //   }).catchError((error) => print("Failed to add user: $error"));
  // }
  // void clear_action() {
  //   setState(() {
  //     Detail.text = "";
  //     selectedValue = 'Bringing An ODAEP Program To My School';
  //   });
  // }
  @override
  void initState() {
    super.initState();
  setState(() {
    selectedValue = 'Bringing An ODAEP Program To My School';
  });
  }
  // editing controller
  TextEditingController Detail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body:Container(
          color: Colors.white,

          child: ListView(
            shrinkWrap: false,
            children: <Widget>[


              Container(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 50,
                  right: 0,
                  bottom: 0,
                ),
                child: const Text('Contact Us', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.black), textAlign: TextAlign.left),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 55,
                  top: 50,
                  right: 0,
                  bottom: 0,
                ),
                child: const Text('Subject', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
              ),
//#7b182d
              Container(
                  width : double.infinity,
                  height: 55,
                  padding: const EdgeInsets.only(
                    left: 8,

                  ),
                  margin: const EdgeInsets.only(
                    left: 25,
                    top: 15,
                    right: 25,
                    bottom: 0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7.0),
                        bottomRight: Radius.circular(7.0),
                        topLeft: Radius.circular(7.0),
                        bottomLeft: Radius.circular(7.0)),
                      boxShadow:  [new BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0, // You can set this blurRadius as per your requirement
                      ),]
                  ),
                  child: CustomDropdownButton2(
                    hint: 'Select Item',

                    dropdownItems: items,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.black,

                    value: selectedValue,

                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),

              ),
              Container(
                width : double.infinity,
                height: 150,
                padding: const EdgeInsets.only(
                  left: 8,

                ),
                margin: const EdgeInsets.only(
                  left: 25,
                  top: 15,
                  right: 25,
                  bottom: 0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7.0),
                      bottomRight: Radius.circular(7.0),
                      topLeft: Radius.circular(7.0),
                      bottomLeft: Radius.circular(7.0)),
                    boxShadow:  [new BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0, // You can set this blurRadius as per your requirement
                    ),]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 25,
                        right: 0,
                        bottom: 0,
                      ),
                      child: const Text('Message', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                    ),
                    Container(
                      width : double.infinity,
                      height: 0.5,
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
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 8,
                        right: 0,
                        bottom: 0,
                      ),
                      child: const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 8,
                        right: 0,
                        bottom: 0,
                      ),
                      child: TextField(
                        controller: Detail,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          hintStyle: TextStyle(color: Colors.black) ,
                          hintText: "Let us known what you think",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color:  Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color:  Colors.white),
                          ),
                          fillColor: Colors.white,//<-- SEE HERE
                        ),

                      ),
                    ),






                  ],),

              ),
              Container(
                width : double.infinity,
                height: 50,
                padding: const EdgeInsets.only(
                    left: 15,
                    right: 15

                ),

                margin: const EdgeInsets.only(
                  left: 25,
                  top: 15,
                  right: 25,
                  bottom: 0,
                ),
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


                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(

                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),


                      ),
                      child: const Text('Clear',style: TextStyle(color:Colors.black),) ,
                      onPressed: () {
                          //clear_action();
                      },
                    ),
                    Spacer(),
                    Expanded(flex:3,child:


                    Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child:    ElevatedButton(

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all( parseColor("#f9097d")),

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: parseColor("#f9097d")),
                                  )
                              )
                          ),
                          child: const Text('Submit') ,
                          onPressed: () {
                           send(Detail.text);
                          },
                        )
                    ),
                    ),
                  ],),
              ),
            ],
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

  Future<void> send(String body) async {
    if(!body.isEmpty){
      if(selectedValue! != "null"){
        _onLoading();
        final Email email = Email(
          body: body,
          subject: selectedValue.toString(),
          recipients: ["6737pafkiet@gmail.com"],
          isHTML: false,
        );
        String platformResponse;
        try {
          await FlutterEmailSender.send(email);
          platformResponse = 'success';
          setState(() {
            Detail.text = "";
            selectedValue = 'Bringing An ODAEP Program To My School';
          });
          Navigator.pop(context);
        } catch (error) {
          print(error);
          platformResponse = error.toString();
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(platformResponse),
          ),
        );
      }else{
      //  Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Please select subject",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }else{

      Fluttertoast.showToast(
          msg: "Please fill Description",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    //  Navigator.pop(context);
    }

  }
  void _onLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return  Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  // Text("Loading..."),

                ],
              )
          );
        });



  }

}

