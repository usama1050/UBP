import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
class Live_Event_Component extends StatefulWidget {
  const Live_Event_Component({Key? key}) : super(key: key);

  @override
  State<Live_Event_Component> createState() => _Live_Event_ComponentState();
}

class _Live_Event_ComponentState extends State<Live_Event_Component> {
  GoogleMapController? mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  Map map = Map<String, LatLng>();
    LatLng showLocation =  LatLng(27.7089427, 85.3086209); //location to show in map
  double currentZoom = 10.0;
  TextEditingController search = TextEditingController();

  @override
  void initState() {

    get_data();
  }

  get_data() async {

    FirebaseFirestore.instance
        .collection('LiveEvents')
        .get()
        .then((value) {

      value.docs.forEach((liveevent_data) {
        setState(() {
          setState(() {
            markers.add(Marker( //add first marker
              onTap: () async {
                final Uri _url = Uri.parse(liveevent_data['url']);
                if (!await launchUrl(_url)) {
                throw 'Could not launch $_url';
                }

              },
              markerId: MarkerId(liveevent_data['name']),
              position: LatLng(double.parse(liveevent_data['latitude']),double.parse(liveevent_data['longitude'])), //position of marker
              infoWindow: InfoWindow( //popup info
                title: liveevent_data['name'],
                snippet: liveevent_data['address'],
              ),
              icon: BitmapDescriptor.defaultMarker, //Icon for Marker
            ));

            mapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition( //innital position in map
              target: LatLng(double.parse(liveevent_data['latitude']),double.parse(liveevent_data['longitude'])), //initial position
              zoom: currentZoom, //initial zoom level
            )));
            showLocation =  LatLng(double.parse(liveevent_data['latitude']),double.parse(liveevent_data['longitude']));
          });
          map[liveevent_data['name']] = LatLng(double.parse(liveevent_data['latitude']),double.parse(liveevent_data['longitude']));
         // map.addAll({liveevent_data['name'] : LatLng(double.parse(liveevent_data['latitude']),double.parse(liveevent_data['longitude']))});
        });
      });
    });

  }


  Set<Marker> getmarkers() { //markers to place on map
    setState(() {
      FirebaseFirestore.instance
          .collection('LiveEvents')
          .get()
          .then((value) {

        value.docs.forEach((liveevent_data) {
          setState(() {

              // markers.add(Marker( //add first marker
              //   markerId: MarkerId(liveevent_data['name'].toString()),
              //   position: LatLng(40.577140, -73.985830), //position of marker
              //   infoWindow: InfoWindow( //popup info
              //     title: liveevent_data['name'],
              //     snippet: 'My Custom Subtitle',
              //   ),
              //   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
              // ));





          });
        });
      });

      //add more markers here
    });

    return markers;
  }
  void _zoom_in() {
    setState(() {
      currentZoom = currentZoom - 1;
      mapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition( //innital position in map
        target: showLocation, //initial position
        zoom: currentZoom, //initial zoom level
      )));
    });
  }
  void _zoom_out() {
    setState(() {
      currentZoom = currentZoom + 1;
      mapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition( //innital position in map
        target: showLocation, //initial position
        zoom: currentZoom, //initial zoom level
      )));

    });
  }
  void _onMapTypeButtonPressed() {
    setState(() {
      map.forEach((key, value) {
        print('$key \t $value');

      });
      mapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition( //innital position in map
        target: LatLng(showLocation.latitude,showLocation.longitude), //initial position
        zoom: currentZoom, //initial zoom level
      )));

    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Stack(

        children: <Widget>[
          Align(
              alignment:Alignment.center,//change this as you need
              child: GoogleMap( //Map widget from google_maps_flutter package
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition( //innital position in map
                  target: showLocation, //initial position
                  zoom: currentZoom, //initial zoom level
                ),
                  gestureRecognizers: Set()
                    ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
                markers: getmarkers(), //markers to show on map
                mapType: MapType.normal, //map type
                onMapCreated: (controller) { //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
              ),
          ),
Expanded(flex:1,child:  Padding(
  padding: const EdgeInsets.all(16.0),
  child:  TextFormField(

    style: TextStyle(color: Colors.black),
    onChanged: (text) {
      setState(() {
        print(text);
        map.forEach((key, value) {
          if(key == text){
            mapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition( //innital position in map
              target: value, //initial position
              zoom: 13, //initial zoom level
            )));
          }

        });

        // mapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition( //innital position in map
        //   target: LatLng(showLocation.latitude,showLocation.longitude), //initial position
        //   zoom: currentZoom, //initial zoom level
        // )));

      });
    },
    onSaved: (value) {


      search.text = value!;

    },
    textInputAction: TextInputAction.done,
    controller: search,

    decoration:  InputDecoration(

      contentPadding:EdgeInsets.fromLTRB(10,0,10,0),
      filled: true,
      floatingLabelBehavior:  FloatingLabelBehavior.never,
      fillColor: Colors.white,
      labelStyle:TextStyle(fontSize: 12.0, color: Colors.black) ,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),

        ),
      ),

      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),

      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),

        ),
      ),
      prefixIcon: InkWell(
        /// This is Magical Function
        child: Icon(
          /// CHeck Show & Hide.
            Icons.search
        ),
      ),
      labelText: 'Search Event',

    ),
  ),
),),



           Align(
              alignment: Alignment.bottomRight,

              child: Padding(
                padding: const EdgeInsets.all(16.0),

                child:   Column(
                mainAxisAlignment: MainAxisAlignment.end,

                children: <Widget> [
                  FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.gps_fixed_sharp, size: 32.0,color: Colors.black),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: _zoom_in,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.add, size: 32.0,color: Colors.black),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: _zoom_out,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.remove, size: 32.0,color: Colors.black,),
                  ),
                ],
              ),)



            ),

        ],
      ),






    );
  }
}
