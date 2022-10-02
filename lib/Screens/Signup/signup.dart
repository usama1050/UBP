import 'package:Urban_block_party/Screens/Registration/RegistrationScreen.dart';
import 'package:Urban_block_party/Services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);
  @override
  State<signup> createState() => _signupState();
}
class _signupState extends State<signup> {
  final AuthServices authServices = new AuthServices();

  // editing Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  // our form key
  final _formKey = GlobalKey<FormState>();
  bool _isHidden_pass = false;
  bool _isHidden_confirm = false;
  // string for displaying the error Message
  String? errorMessage;
  void _togglePasswordView() {
    setState(() {
      _isHidden_pass = !_isHidden_pass;
    });
  }
  void _toggleConfirmPasswordView() {
    setState(() {
      _isHidden_confirm = !_isHidden_confirm;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/background_login.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child:Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
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
                      top: 25,
                      right: 40,
                      bottom: 0,
                    ),
                    child: const Text('Register A New Account',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Colors.white), textAlign: TextAlign.center),
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
                              keyboardType: TextInputType.emailAddress,
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
                              style: TextStyle(color: Colors.black),

                              textInputAction: TextInputAction.next,
                              controller: emailController,
                              decoration: const InputDecoration(
                                contentPadding:EdgeInsets.fromLTRB(10,0,10,0),
                                filled: true,
                                floatingLabelBehavior:  FloatingLabelBehavior.never,
                                fillColor: Colors.white,
                                labelStyle:TextStyle(fontSize: 12.0, color: Colors.black) ,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2.0),

                                ),
                                enabledBorder: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                ),
                                border: const OutlineInputBorder(),

                                labelText: 'Email Address',
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow:  [new BoxShadow(
                                  color: Colors.grey,

                                  blurRadius: 200.0, // You can set this blurRadius as per your requirement
                                ),]
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              obscureText: !_isHidden_pass,


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
                              style: TextStyle(color: Colors.black),

                              controller: passwordController,
                              textInputAction: TextInputAction.next,
                              decoration:  InputDecoration(
                                suffix: InkWell(
                                  onTap: _togglePasswordView,  /// This is Magical Function
                                  child: Icon(
                                    _isHidden_pass ?         /// CHeck Show & Hide.
                                    Icons.visibility :
                                    Icons.visibility_off,
                                  ),
                                ),
                                filled: true,
                                floatingLabelBehavior:  FloatingLabelBehavior.never,
                                fillColor: Colors.white,
                                contentPadding:EdgeInsets.fromLTRB(10,0,10,0),

                                labelStyle:TextStyle(fontSize: 12.0, color: Colors.black) ,

                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2.0),

                                ),
                                enabledBorder: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                ),
                                border: const OutlineInputBorder(),

                                labelText: 'Password',
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow:  [new BoxShadow(
                                  color: Colors.grey,

                                  blurRadius: 200.0, // You can set this blurRadius as per your requirement
                                ),]
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              obscureText: !_isHidden_confirm,
                              validator: (value) {
                                if (confirmpasswordController.text !=
                                    passwordController.text) {
                                  return "Password don't match";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                confirmpasswordController.text = value!;
                              },

                              style: TextStyle(color: Colors.black),

                              controller: confirmpasswordController,
                              decoration:  InputDecoration(
                                suffix: InkWell(
                                  onTap: _toggleConfirmPasswordView,  /// This is Magical Function
                                  child: Icon(
                                    _isHidden_confirm ?         /// CHeck Show & Hide.
                                    Icons.visibility :
                                    Icons.visibility_off,
                                  ),
                                ),
                                contentPadding:EdgeInsets.fromLTRB(10,0,10,0),
                                filled: true,
                                floatingLabelBehavior:  FloatingLabelBehavior.never,
                                fillColor: Colors.white,
                                labelStyle:TextStyle(fontSize: 12.0, color: Colors.black) ,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2.0),

                                ),
                                enabledBorder: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                ),
                                border: const OutlineInputBorder(),

                                labelText: 'Confirm Password',
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
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  child: const Text('Sign Up'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.push(
                                        context,
                                          MaterialPageRoute(builder: (context) => RegistrationScreen(email: emailController.text, password:  passwordController.text)),
                                      );
                                    }
                                  },
                                )
                            ),
                          ),

                        ]),

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
