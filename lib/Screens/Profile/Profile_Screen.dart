import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Urban_block_party/Screens/login/login.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
 import 'package:Urban_block_party/Screens/Usertype/Usertype.dart';
import 'package:Urban_block_party/Screens/NotificationTypes/Notificationtype.dart';
import 'package:Urban_block_party/Screens/School/School.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ffi';
import 'package:Urban_block_party/Screens/Signup/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);
  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}
class _Profile_ScreenState extends State<Profile_Screen> {
  String status_notification = "";
  String status_usertype = "";
  String status_school = "";
  String username = "";
  String userID = "";
  String user_name = "";
  String last_name = "";
  String profileImageURL = "";
  PickedFile? imageFile=null;

  String? errorMessage;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  // our form key

  final _formKey = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();

  Future<void> updateUser(String  email,String firstName,String lastName,String profileImageURL,String schoolAffiliation,String type,String userPreference,String id ) {

    return users.doc(id)
        .update({
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


      get_status_notifcation();
      Fluttertoast.showToast(msg: "Profile updated Successful");

    }).catchError((error) => print("Failed to add user: $error"));

  }
  get_status_notifcation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore.instance
        .collection('Users')
        .where('userID', isEqualTo: prefs.getString("uid"))
        .get()
        .then((value) {
      print(value);
      value.docs.forEach((userdata) {
        setState(() {
          //  print(userdata['email']);
          userID = prefs.getString("uid")!;
          EmailController.text = userdata['email'];
          FirstNameController.text = userdata['firstName'];
          LastNameController.text = userdata['lastName'];
          profileImageURL = userdata['profileImageURL'];
          status_notification = userdata['howNotify']['userPreference'];
          status_usertype = userdata['type'];
          status_school = userdata['schoolAffiliation'];
          user_name = userdata['firstName'];
          last_name = userdata['lastName'];

        });
      });
    });
    setState(() {
      // status_notification = prefs.getString('notification_status')!;
      // status_usertype = prefs.getString('User_status')!;
      // status_school = prefs.getString('School_status')!;
    });
  }
  get_getdata_info() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('User_status', "Student");
    // prefs.setString('notification_status', "Frequently");
    // prefs.setString('School_status', "Wings Academy High School");
    setState(() {
      status_notification = prefs.getString('notification_status')!;
      status_usertype = prefs.getString('User_status')!;
      status_school = prefs.getString('School_status')!;
    });
  }
  @override
  void initState() {
    super.initState();
    get_status_notifcation();
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
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text("Profile",style: TextStyle(
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

                                child: ( imageFile==null)? Image.network(
                                  profileImageURL,
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
                              child:  Text( user_name+ " "+ last_name, style: TextStyle(fontWeight: FontWeight.normal,fontSize: 25,color: Colors.black), textAlign: TextAlign.left),
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
                                boxShadow:  [new BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0, // You can set this blurRadius as per your requirement
                              ),],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7.0),
                                    bottomRight: Radius.circular(7.0),
                                    topLeft: Radius.circular(7.0),
                                    bottomLeft: Radius.circular(7.0)),

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
                                          hintStyle: TextStyle(color: Colors.grey) ,
                                          hintText: "Enter First Name",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
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
                                          hintStyle: TextStyle(color: Colors.grey) ,
                                          hintText: "Enter Last Name",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color:  Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color:  Colors.white),
                                          ),
                                          fillColor: Colors.white,//<-- SEE HERE
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
                                          hintStyle: TextStyle(color: Colors.grey) ,
                                          hintText: "Enter Email",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color:  Colors.white),
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
                                        left: 0,
                                        top: 20,
                                        right: 10,
                                        bottom: 0,
                                      ),
                                      child:
                                      Text(
                                          status_school,   overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.black)),
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
                                              get_getdata_info();
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
                                      color: Colors.grey,
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
                                                get_getdata_info();

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
                                          bottom: 10,
                                        ),
                                        child:Container(
                                          margin: EdgeInsets.only(top: 25),

                                          width: 50,
                                          height: 50,
                                          child:  ClipOval(
                                            child: ( imageFile==null)? Image.network(
                                              profileImageURL,
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
                                boxShadow:  [new BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0, // You can set this blurRadius as per your requirement
                                ),],
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7.0),
                                    bottomRight: Radius.circular(7.0),
                                    topLeft: Radius.circular(7.0),
                                    bottomLeft: Radius.circular(7.0)),
                              ),



                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                    ),
                                    child: const Text('Update',style: TextStyle(color: Colors.black),) ,
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
                                              if(imageFile != null){
                                                uploadImage(imageFile!.path.toString());
                                              }else{
                                                _onLoading();
                                                updateUser(EmailController.text,FirstNameController.text,LastNameController.text,profileImageURL,status_school,status_usertype,status_notification,userID);

                                              }

                                            }
                                          }
                                        }

                                      }

                                    },
                                  ),
                                  Spacer(),
                                  Expanded(flex:3,child:
                                  Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child:    ElevatedButton(

                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.red),

                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  side: BorderSide(color:Colors.red),
                                                )
                                            )
                                        ),
                                        child: const Text('Sign out') ,
                                        onPressed: () {
                                          signout();

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
  Future<void> signout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => login_Screen()));
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

  uploadImage(argfile) async {
    _onLoading();
    final _firebaseStorage = FirebaseStorage.instance;
    var file = File(argfile);
    var randomNum = getRandomString(10);
    if (file != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage.ref('ProfileImage/'+userID+'/$randomNum.png')
          .putFile(file);
      debugPrint(snapshot.state.toString());
      if (snapshot.state == TaskState.success) {
        var downloadUrl = await snapshot.ref.getDownloadURL();
        updateUser(EmailController.text,FirstNameController.text,LastNameController.text,downloadUrl,status_school,status_usertype,status_notification,userID);
        debugPrint("Uploaded..");
      } else {
        debugPrint('No Image Path Received');
      }
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
