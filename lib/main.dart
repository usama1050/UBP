import 'package:Urban_block_party/Components/Artist_Component.dart';
import 'package:Urban_block_party/Components/Gallery_Component.dart';
import 'package:Urban_block_party/Components/GetHelp.dart';
import 'package:Urban_block_party/Components/Live_Event_Component.dart';
import 'package:Urban_block_party/Components/Video_Component.dart';
import 'package:Urban_block_party/Components/contactus_component.dart';
import 'package:Urban_block_party/Components/home_component.dart';
import 'package:Urban_block_party/Components/post.dart';
import 'package:Urban_block_party/Screens/HomeTiles_Detail/HomeTiles_Detail.dart';
import 'package:Urban_block_party/Screens/NotificationTypes/Notificationtype.dart';
import 'package:Urban_block_party/Screens/Profile/Profile_Screen.dart';
import 'package:Urban_block_party/Screens/Registration/RegistrationScreen.dart';
import 'package:Urban_block_party/Screens/Signup/signup.dart';
import 'package:Urban_block_party/Screens/Usertype/Usertype.dart';
import 'package:Urban_block_party/Screens/feed_page.dart';
import 'package:Urban_block_party/Screens/login/login.dart';
import 'package:Urban_block_party/Screens/HomeTiles_Detail/HomeTiles_Detail.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_screen.dart';
import 'package:Urban_block_party/Components/videoPlayer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    const MaterialApp(
        home: MyApp()
    ),
  );
}


const Color p = Color(0xff416d69);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corona Out',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: p,
      ),
      home: const Zoom(),
    );
  }
}

final ZoomDrawerController z = ZoomDrawerController();

class Zoom extends StatefulWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.deepPurple,Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      child: ZoomDrawer(
        controller: z,
        borderRadius: 24,
        style: DrawerStyle.defaultStyle,
        // showShadow: true,
        openCurve: Curves.fastOutSlowIn,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        duration: const Duration(milliseconds: 500),
        // angle: 0.0,

        mainScreen: const Body(),
        menuScreen: Theme(
          data: ThemeData.dark(),
          child:  Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
                padding: EdgeInsets.only(left: 0),
                child:Center(child:  Container(
                    child:Column(children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                          left: 10,
                          top: 100,
                          right: 10,
                          bottom: 0,
                        ),
                        child:FittedBox(
                          child: Image.asset('assets/images/logo.png'),
                          fit: BoxFit.fill,
                        ) , ),
                     Row(children: [
                       Expanded(child: Icon(Icons.house)),
                       Expanded(child:


                       Text("Home",style: TextStyle(color: Colors.white,fontSize: 16),)),

                     ],),
                      Container(
                        width : double.infinity,
                        height: 0.1,
                        margin: const EdgeInsets.only(
                          left: 27,
                          top: 15,
                          right: 0,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,

                        ),
                      ),

                      Row(children: [
                        Expanded(child: Icon(Icons.videocam_outlined)),
                        Expanded(child:
                        InkWell(
                          child:Expanded(child: Text("Live Event",style: TextStyle(color: Colors.white,fontSize: 16),)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Live_Event_Component()),
                            );
                          },
                        ),


                        ),

                      ],),
                      Container(
                        width : double.infinity,
                        height: 0.1,
                        margin: const EdgeInsets.only(
                          left: 27,
                          top: 15,
                          right: 0,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,

                        ),
                      ),

                      Row(children: [
                        Expanded(child: Icon(Icons.image)),
                        Expanded(child:

                        InkWell(
                          child:Expanded(child: Text("Gallery",style: TextStyle(color: Colors.white,fontSize: 16),)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Gallery_Component()),
                            );
                          },
                        ),

                     ),

                      ],),
                      Container(
                        width : double.infinity,
                        height: 0.1,
                        margin: const EdgeInsets.only(
                          left: 27,
                          top: 15,
                          right: 0,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,

                        ),
                      ),

                      Row(children: [
                        Expanded(child: Icon(Icons.heart_broken)),
                        Expanded(child:
                        InkWell(
                          child:Expanded(child: Text("Posts",style: TextStyle(color: Colors.white,fontSize: 16),)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Post_Component()),
                            );
                          },
                        ),


                     ),

                      ],),
                      Container(
                        width : double.infinity,
                        height: 0.1,
                        margin: const EdgeInsets.only(
                          left: 27,
                          top: 15,
                          right: 0,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,

                        ),
                      ),


                      Row(children: [
                        Expanded(child: Icon(Icons.messenger_outlined)),
                        Expanded(child:
                        InkWell(
                          child:Expanded(child: Text("Contact Us",style: TextStyle(color: Colors.white,fontSize: 16),)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => contactus_component()),
                            );
                          },
                        ),
                       ),
                      ],),
                      Container(
                        width : double.infinity,
                        height: 1,
                        margin: const EdgeInsets.only(
                          left: 27,
                          top: 75,
                          right: 0,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(7.0),
                              bottomRight: Radius.circular(7.0),
                              topLeft: Radius.circular(7.0),
                              bottomLeft: Radius.circular(7.0)),

                        ),
                      ),


                      Row(children: [
                        Expanded(child: Icon(Icons.settings)),
                        Expanded(child:
                          InkWell(
                            child:Expanded(child: Text("Setting",style: TextStyle(color: Colors.white,fontSize: 16),)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Profile_Screen()),
                              );
                            },
                          ),
                        ),







                      ],),
                      Container(
                        width : double.infinity,
                        height: 0.1,
                        margin: const EdgeInsets.only(
                          left: 27,
                          top: 15,
                          right: 0,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,

                        ),
                      ),


                      Row(children: [
                        Expanded(child: Icon(Icons.logout)),
                        Expanded(child: Text("Logout",style: TextStyle(color: Colors.white,fontSize: 16),)),

                      ],),
                      Container(
                        width : double.infinity,
                        height: 0.1,
                        margin: const EdgeInsets.only(
                          left: 27,
                          top: 15,
                          right: 0,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,

                        ),
                      ),
                    ],)
                ),)










            ),
          ),
        ),
      )
    );



  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TwoPanels(
        controller: controller,
      ),
    );
  }
}

class TwoPanels extends StatefulWidget {
  final AnimationController controller;

  const TwoPanels({Key? key, required this.controller}) : super(key: key);

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> with TickerProviderStateMixin {
  static const _headerHeight = 32.0;
   String title_data = "Home";
  late TabController tabController = TabController(length: 3, vsync: this);
  int _selectedIndex = 0;
  static const List _widgetOptions = [
    const Home_Component(),
    const Artist_Component(),
    const FeedPage(),
    const GetHelp(),
    // const Live_Event_Component(),
    // const Gallery_Component(),
    // const  Post_Component(),
    // const contactus_component(),
  ];
  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final _height = constraints.biggest.height;
    final _backPanelHeight = _height - _headerHeight;
    const _frontPanelHeight = -_headerHeight;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(
        0.0,
        _backPanelHeight,
        0.0,
        _frontPanelHeight,
      ),
      end: const RelativeRect.fromLTRB(0.0, 100, 0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title:  Text(title_data, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25,)),
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.menu,color: Colors.black,),
              onPressed: () {
                z.toggle!();
              },
            ),
              actions: <Widget> [
                IconButton(
                  visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                  padding: EdgeInsets.only(right: 8.0),
                  icon: FaIcon(FontAwesomeIcons.userCircle,color: Colors.black,),
                  onPressed: () => {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile_Screen()),
                  )
                  },
                ),
              ]

          ),
          bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/images/home.png"),
                    ),
                    label: "Home",

                    backgroundColor: Colors.white
                ),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/images/microphone.png"),
                    ),
                    label: "Artisits",

                    backgroundColor: Colors.white
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/video.png"),
                  ),
                  label: "Videos",

                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(

                  icon: ImageIcon(
                    AssetImage("assets/images/contact_icon.png"),
                  ),
                  label: "Get Help",

                  backgroundColor: Colors.white,
                ),

              ],
              type: BottomNavigationBarType.shifting,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black,
              showUnselectedLabels: true,
              iconSize: 30,
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
              elevation: 5
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
        ),

      ],
    );
  }
  void _onItemTapped(int index) {
    setState(() {
        if(index == 3){
          title_data = "Get Help";
        }else if(index == 2){
          title_data = "Videos";
        }
        else if(index == 1){
          title_data = "Artisits";
        }else if(index == 0){
          title_data = "Home";
        }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
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
  // static const List _widgetOptions = [
  //   const Text("sdasd1)",
  //   const Text("sdasd1)"
  //
  //
  // ];
}
