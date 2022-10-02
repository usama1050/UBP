import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Urban_block_party/Screens/Usertype/Usertype.dart';
import 'package:Urban_block_party/Screens/NotificationTypes/Notificationtype.dart';
import 'package:Urban_block_party/Screens/School/School.dart';
 import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ffi';
import 'package:Urban_block_party/Screens/Signup/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Urban_block_party/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key,required this.email,required this.password}) : super(key: key);
  final String email;
  final String password;
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {
  String status_notification = "";
  String status_usertype = "";
  String status_school = "";
  String user_name = "";
  String last_name = "";
  final _auth = FirebaseAuth.instance;
  PickedFile? imageFile=null;
  String? errorMessage;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  // our form key
  final _formKey = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  List<Map<String, String>> myData = [
    {'howNotify': "never"},
  ];
  Future<void> addUser(String  email,String firstName,String lastName,String profileImageURL,String schoolAffiliation,String type,String userPreference,String id ) {
    _onLoading();
    return users.doc(id)
        .set({
      'createdAt': DateTime.now(), // John Doe
      'email': email, // Stokes and Sons
      'firstName': firstName, // Stokes and Sons
      'lastName': lastName,
      'profileImageURL': profileImageURL,
      'schoolAffiliation': schoolAffiliation,
      'type': type,
      'userID': id,
      'howNotify': {'userPreference': userPreference},
    }).then((value) {
      return users.doc(id)
          .update({
        'profileImageURL': profileImageURL,
      }).then((value) {
        Fluttertoast.showToast(msg: "Login Successful");
        save_session(id.toString());
      }).catchError((error) => print("Failed to add user: $error"));
    }).catchError((error) => print("Failed to add user: $error"));
  }
  save_session(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
  get_status_notifcation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('User_status');
    prefs.getString('notification_status');
    prefs.getString('School_status');
    setState(() {
      status_notification = prefs.getString('notification_status')!;
      status_usertype = prefs.getString('User_status')!;
      print(status_usertype);
      status_school = prefs.getString('School_status')!;
    });
  }
  get_getdata_info() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('User_status', "Student");
    prefs.setString('notification_status', "Frequently");
    prefs.setString('School_status', "Wings Academy High School");
    setState(() {
      status_notification = 'Frequently';
      status_usertype = 'Student';
      status_school = 'Wings Academy High School';
    });
  }
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {
          if(imageFile != null){
            uploadImage(imageFile!.path.toString(),value.user!.uid!.toString()!)
          }else{
            addUser(EmailController.text,FirstNameController.text,LastNameController.text,"https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png",status_school,status_usertype,status_notification,value.user!.uid!.toString())
          }
        })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  @override
  void initState()   {
    super.initState();

    setState(() {
      EmailController.text = widget.email;
    });

    get_getdata_info();
  }

  _openGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //new line
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sign up",style: TextStyle(
            color: Colors.black,
          )),
          backgroundColor: Colors.white,
        ),
        body:SingleChildScrollView(

            child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child:Form(
                        key: _formKey,
                        child: Column(

                          children: <Widget>[

                            Container(
                              margin: EdgeInsets.only(top: 25),
                              width: 90,
                              height: 90,
                              child:  ClipOval(
                                child: ( imageFile==null)? Image.asset(
                                  'assets/images/CropODF3.png',
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fill,
                                ): Image.file( File(  imageFile!.path,),width: 120,
                                  height: 120,
                                  fit: BoxFit.fill,),
                              ),),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 25,
                                right: 0,
                                bottom: 0,
                              ),
                              child:  Text(  user_name+ " "+ last_name, style: TextStyle(fontWeight: FontWeight.normal,fontSize: 25,color: Colors.black), textAlign: TextAlign.left),
                            ),
                            Container(
                              width : double.infinity,
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
                                    color: Colors.grey,
                                    blurRadius: 5.0, // You can set this blurRadius as per your requirement
                                  ),]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 8,
                                        right: 15,
                                        bottom: 0,
                                      ),
                                      child: const Text('First Name', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                                    ),

                                    Expanded(child:
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        top: 8,
                                        right: 0,
                                        bottom: 0,
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.end,
                                        cursorColor: Colors.white,
                                        style: TextStyle(color: Colors.black),
                                        validator: (value) {


                                          if (value!.isEmpty) {
                                            return ("Please Enter Your FirstName");
                                          }
                                          return null;
                                        },
                                        onChanged: (value){
                                          setState(() {
                                            user_name = value!;
                                          });
                                        },
                                        onSaved: (value) {

                                          FirstNameController.text = value!;

                                        },
                                        controller: FirstNameController,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          filled: true,
                                          hintStyle: TextStyle(color: Colors.black) ,
                                          hintText: "Enter First Name",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color:   Colors.white),
                                          ),

                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color:  Colors.white),
                                          ),
                                          fillColor: Colors.white,//<-- SEE HERE
                                        ),

                                      ) ,
                                    ),


                                    )

                                  ],),

                                  Container(
                                    width : double.infinity,
                                    height: 0.1,
                                    margin: const EdgeInsets.only(
                                      left: 15,
                                      top: 0,
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


                                  Row(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 8,
                                        right: 15,
                                        bottom: 0,
                                      ),
                                      child: const Text('Last Name', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                                    ),

                                    Expanded(child: Container(

                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        top: 8,
                                        right: 0,
                                        bottom: 0,
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.end,
                                        cursorColor: Colors.white,
                                        style: TextStyle(color: Colors.black),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ("Please Enter Your LastName");
                                          }

                                          return null;
                                        },
                                        onChanged: (value){
                                          setState(() {
                                            last_name = value;
                                          });
                                        },
                                        onSaved: (value) {
                                          LastNameController.text = value!;
                                        },
                                        controller: LastNameController,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          filled: true,
                                          hintStyle: TextStyle(color: Colors.black) ,
                                          hintText: "Enter Last Name",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color:  Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color:  Colors.white),
                                          ),
                                          fillColor:Colors.white,//<-- SEE HERE
                                        ),

                                      ) ,
                                    ),)

                                  ],),

                                  Container(
                                    width : double.infinity,
                                    height: 0.1,
                                    margin: const EdgeInsets.only(
                                      left: 15,
                                      top: 0,
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



                                  Row(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 8,
                                        right: 15,
                                        bottom: 0,
                                      ),
                                      child: const Text('Email', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                                    ),
                                    Expanded(child: Container(

                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        top: 8,
                                        right: 0,
                                        bottom: 0,
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.end,
                                        keyboardType: TextInputType.emailAddress,
                                        cursorColor: Colors.white,
                                        style: TextStyle(color: Colors.black),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ("Please Enter Your Email");
                                          }
                                          // reg expression for email validation
                                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                              .hasMatch(value)) {
                                            return ("Please Enter a valid email");
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          EmailController.text = value!;
                                        },
                                        enabled: false,
                                        controller: EmailController,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          filled: true,
                                          hintStyle: TextStyle(color: Colors.black) ,
                                          hintText: "Enter Email",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color:  Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          fillColor: Colors.white,//<-- SEE HERE
                                        ),

                                      ) ,
                                    ),
                                    )
                                  ],),

                                  Container(
                                    width : double.infinity,
                                    height: 0.1,
                                    margin: const EdgeInsets.only(
                                      left: 15,
                                      top: 0,
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
                                  Row(children: [
                                    Expanded(flex:4,child:  Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 20,
                                        right: 15,
                                        bottom: 0,
                                      ),
                                      child: const Text('schoolAffiliation', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                                    ),),

                                    Expanded(flex:4,child:   Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 20,
                                        right: 0,
                                        bottom: 0,
                                      ),
                                      child:
                                      Text(
                                          status_school,   overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black)),
                                    ),),
                                    Expanded(flex:1,child:   Container(
                                      margin: EdgeInsets.only(right: 0,top: 21),
                                      child:   GestureDetector(
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Schools(type: status_school,))).then((value) {
                                            setState(() {
                                              // refresh state of Page1
                                              get_status_notifcation();

                                            });
                                          });

                                        },
                                      ),),),


                                  ],),
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
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(7.0),
                                          bottomRight: Radius.circular(7.0),
                                          topLeft: Radius.circular(7.0),
                                          bottomLeft: Radius.circular(7.0)),
                                    ),
                                  ),
                                  Row(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 20,
                                        right: 15,
                                        bottom: 0,
                                      ),
                                      child: const Text('User Type', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 20,
                                        right: 8,
                                        bottom: 0,
                                      ),
                                      child:  Text(status_usertype, style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 15,top: 21),
                                      child:   GestureDetector(
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => User_type(type: status_usertype,))).then((value) {
                                            setState(() {
                                              // refresh state of Page1
                                              get_status_notifcation();

                                            });
                                          });

                                          //Navigator.push( context, MaterialPageRoute( builder: (context) => User_type(type: status_usertype,)), ).then((value) => setState(() {}));
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => User_type(type: status_usertype,)),
                                          // );
                                        },
                                      ),),
                                  ],),

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
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(7.0),
                                          bottomRight: Radius.circular(7.0),
                                          topLeft: Radius.circular(7.0),
                                          bottomLeft: Radius.circular(7.0)),
                                    ),
                                  ),

                                  Row(

                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 20,
                                          right: 15,
                                          bottom: 0,
                                        ),
                                        child: const Text('Notify me', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 20,
                                          right: 8,
                                          bottom: 0,
                                        ),
                                        child:  Text(status_notification, style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 15,top: 21),
                                        child:   GestureDetector(
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Notification_types(type: status_notification,))).then((value) {
                                              setState(() {
                                                // refresh state of Page1
                                                get_status_notifcation();

                                              });
                                            });

                                          },
                                        ),),

                                    ],),


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
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(7.0),
                                          bottomRight: Radius.circular(7.0),
                                          topLeft: Radius.circular(7.0),
                                          bottomLeft: Radius.circular(7.0)),
                                    ),
                                  ),


                                  Row(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 20,
                                        right: 15,
                                        bottom: 0,
                                      ),
                                      child: const Text('Profile Image', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black), textAlign: TextAlign.left),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      child:   Container(
                                        padding: const EdgeInsets.only(
                                          left: 0,
                                          top: 0,
                                          right: 15,
                                          bottom: 0,
                                        ),
                                        child:Container(
                                          margin: EdgeInsets.only(top: 25),

                                          width: 40,
                                          height: 40,
                                          child:  ClipOval(
                                            child: ( imageFile==null)? Image.asset(
                                              'assets/images/CropODF3.png',
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.fill,
                                            ): Image.file( File(  imageFile!.path,),width: 120,
                                              height: 120,
                                              fit: BoxFit.fill,),
                                            // child: Image.file( File(  imageFile!.path,),width: 120,
                                            //   height: 120,
                                            //   fit: BoxFit.fill,),
                                          ),



                                        ),
                                      ),
                                      onTap: () {
                                        _openGallery();
                                      },
                                    ),

                                  ],),



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
                                    child: const Text('Back',style: TextStyle(color: Colors.black),) ,
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (BuildContext context) => signup()));
                                    },
                                  ),
                                  Spacer(),
                                  Expanded(flex:3,child:
                                  Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child:    ElevatedButton(

                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(parseColor("#f9097d")),

                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  side: BorderSide(color:Colors.red),
                                                )
                                            )
                                        ),
                                        child: const Text('Create User') ,
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            if(status_school == ""){
                                              Fluttertoast.showToast(
                                                  msg: "Please enter schoolAffiliation",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                            }else{
                                              if(status_usertype == ""){
                                                Fluttertoast.showToast(
                                                    msg: "Please enter user type",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }else{
                                                if(status_notification == ""){
                                                  Fluttertoast.showToast(
                                                      msg: "Please enter notify me",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0
                                                  );
                                                }else{
                                                  signUp(this.widget.email, this.widget.password);
                                                }
                                              }
                                            }

                                          }
                                        },
                                      )
                                  ),


                                  ),
                                ],),



                            ),

                          ],
                        )
                    ),

                  ),

                ]))

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
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  uploadImage(argfile,user_id) async {
    final _firebaseStorage = FirebaseStorage.instance;
    var file = File(argfile);
    var randomNum = getRandomString(10);
    if (file != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage.ref('ProfileImage/'+user_id+'/$randomNum.png')
          .putFile(file);
      debugPrint(snapshot.state.toString());
      if (snapshot.state == TaskState.success) {
        var downloadUrl = await snapshot.ref.getDownloadURL();
        //addUser(EmailController.text,FirstNameController.text,LastNameController.text,downloadUrl,status_school,status_usertype,status_notification,user_id);
        debugPrint("Uploaded..");
      } else {
        debugPrint('No Image Path Received');
      }
    }else{

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
