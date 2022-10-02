import 'package:Urban_block_party/Screens/Registration/Signup_RegistrationScreen.dart';
import 'package:Urban_block_party/Screens/Signup/signup.dart';
import 'package:Urban_block_party/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:odaep/Screens/Home/Home.dart';
// import 'package:odaep/Screens/Signup/signup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

//comments__

import 'package:Urban_block_party/Services/auth_service.dart';

class login_Screen extends StatefulWidget {
  const login_Screen({Key? key}) : super(key: key);
  @override
  State<login_Screen> createState() => _login_ScreenState();
}
class _login_ScreenState extends State<login_Screen> {
  // form key
  final _formKey = GlobalKey<FormState>();
  // editing controller
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // firebase
  // comments
  final _auth = FirebaseAuth.instance;

  String? errorMessage;
  bool _isHidden = false;

  final AuthServices authServices = new AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(

        decoration: BoxDecoration(

        image: DecorationImage(
        image: AssetImage(
        'assets/images/background_login.jpg'),
        fit: BoxFit.fill,
    ),
        ),
          child:Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 55),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                      left: 40,
                      top: 0,
                      right: 40,
                      bottom: 0,
                    ),
                    child:FittedBox(
                      child: Image.asset('assets/images/ubpx-app-logo-200-clr.png'),
                      fit: BoxFit.fill,
                    ) , ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 40,
                      top: 8,
                      right: 40,
                      bottom: 0,
                    ),
                    child: const Text('Welcome to the Urban Block Party App',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: Colors.white), textAlign: TextAlign.center),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              left: 0,
                              top: 20,
                              right: 0,
                              bottom: 0,
                            ),
                            decoration: BoxDecoration(
                                boxShadow:  [new BoxShadow(
                                  color: Colors.grey,

                                  blurRadius: 200.0, // You can set this blurRadius as per your requirement
                                ),]
                            ),
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
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
                                emailController.text = value!;
                              },
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(color: Colors.black),

                              decoration: const InputDecoration(
                                contentPadding:EdgeInsets.fromLTRB(10,0,10,0),
                                floatingLabelBehavior:  FloatingLabelBehavior.never,
                                labelStyle:TextStyle(fontSize: 12.0, color: Colors.black) ,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),

                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25.0),

                                  ),
                                ),

                                labelText: 'Email Address',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            decoration: BoxDecoration(
                                boxShadow:  [new BoxShadow(
                                  color: Colors.grey,

                                  blurRadius: 200.0, // You can set this blurRadius as per your requirement
                                ),]
                            ),
                            child: TextFormField(
                              obscureText: !_isHidden,


                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return ("Password is required for login");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid Password(Min. 6 Character)");
                                }
                              },
                              onSaved: (value) {
                                passwordController.text = value!;
                              },
                              textInputAction: TextInputAction.done,
                              controller: passwordController,

                              decoration:  InputDecoration(

                                contentPadding:EdgeInsets.fromLTRB(10,0,10,0),
                                filled: true,
                                floatingLabelBehavior:  FloatingLabelBehavior.never,
                                fillColor: Colors.white,
                                labelStyle:TextStyle(fontSize: 12.0, color: Colors.black) ,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),

                                  ),
                                ),

                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  ),
                                ),
                                suffix: InkWell(
                                  onTap: _togglePasswordView,  /// This is Magical Function
                                  child: Icon(
                                    _isHidden ?         /// CHeck Show & Hide.
                                    Icons.visibility :
                                    Icons.visibility_off,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25.0),

                                  ),
                                ),
                                labelText: 'Password',

                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 65,
                            child:Container(
                                height: 40,
                                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                    primary: parseColor("#f9097d"), // background
                                    onPrimary: Colors.white,
                                      shape: StadiumBorder()
                                    // foreground
                                  ),
                                  child: const Text('Log In'),
                                  onPressed: () {
                                    //comment__#f9097d
                                    signIn(emailController.text, passwordController.text);
                                  },
                                )
                            ),
                          ),
                        ]
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child:Row(
                      children: <Widget>[
                        const Text('Dont have an account?' ,style:TextStyle(fontSize: 12,color: Colors.black)),
                        TextButton(
                          child: const Text(
                            'Register here',
                            style: TextStyle(fontSize: 12,color: Colors.blue),
                          ),
                          onPressed: () {
                            //comments__
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => signup()),
                            );
                          },
                        ),


                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Container(
                      height: 40,
                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        icon: FaIcon(FontAwesomeIcons.google,color: Colors.white,),
                        label: const Text('Sign Up With Google'),
                        onPressed: () {
                          ///comments__
                          authServices.signInWithGoogle().whenComplete(() {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup_Gmail(email: emailController.text, password:  passwordController.text)),
                            );
                          });
                        },
                      )
                  ),



                ],
              ))
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:back,
        tooltip: 'Increment',
        backgroundColor: Colors.grey,
        child: const Icon(Icons.close_sharp,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
  void back() {
    Navigator.pop(context);
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  //Save session
  save_session(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    //comments__
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
  // login function
  //comment__
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        _onLoading();
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((user) => {
          Navigator.pop(context),
          Fluttertoast.showToast(msg: "Login successfully"),
          save_session(user.user!.uid!.toString())

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
        Navigator.pop(context);
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
